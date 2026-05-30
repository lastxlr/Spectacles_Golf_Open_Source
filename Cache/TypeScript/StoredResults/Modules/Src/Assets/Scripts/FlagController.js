"use strict";
var __esDecorate = (this && this.__esDecorate) || function (ctor, descriptorIn, decorators, contextIn, initializers, extraInitializers) {
    function accept(f) { if (f !== void 0 && typeof f !== "function") throw new TypeError("Function expected"); return f; }
    var kind = contextIn.kind, key = kind === "getter" ? "get" : kind === "setter" ? "set" : "value";
    var target = !descriptorIn && ctor ? contextIn["static"] ? ctor : ctor.prototype : null;
    var descriptor = descriptorIn || (target ? Object.getOwnPropertyDescriptor(target, contextIn.name) : {});
    var _, done = false;
    for (var i = decorators.length - 1; i >= 0; i--) {
        var context = {};
        for (var p in contextIn) context[p] = p === "access" ? {} : contextIn[p];
        for (var p in contextIn.access) context.access[p] = contextIn.access[p];
        context.addInitializer = function (f) { if (done) throw new TypeError("Cannot add initializers after decoration has completed"); extraInitializers.push(accept(f || null)); };
        var result = (0, decorators[i])(kind === "accessor" ? { get: descriptor.get, set: descriptor.set } : descriptor[key], context);
        if (kind === "accessor") {
            if (result === void 0) continue;
            if (result === null || typeof result !== "object") throw new TypeError("Object expected");
            if (_ = accept(result.get)) descriptor.get = _;
            if (_ = accept(result.set)) descriptor.set = _;
            if (_ = accept(result.init)) initializers.unshift(_);
        }
        else if (_ = accept(result)) {
            if (kind === "field") initializers.unshift(_);
            else descriptor[key] = _;
        }
    }
    if (target) Object.defineProperty(target, contextIn.name, descriptor);
    done = true;
};
var __runInitializers = (this && this.__runInitializers) || function (thisArg, initializers, value) {
    var useValue = arguments.length > 2;
    for (var i = 0; i < initializers.length; i++) {
        value = useValue ? initializers[i].call(thisArg, value) : initializers[i].call(thisArg);
    }
    return useValue ? value : void 0;
};
var __setFunctionName = (this && this.__setFunctionName) || function (f, name, prefix) {
    if (typeof name === "symbol") name = name.description ? "[".concat(name.description, "]") : "";
    return Object.defineProperty(f, "name", { configurable: true, value: prefix ? "".concat(prefix, " ", name) : name });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.FlagController = void 0;
var __selfType = requireType("./FlagController");
function component(target) {
    target.getTypeName = function () { return __selfType; };
    if (target.prototype.hasOwnProperty("getTypeName"))
        return;
    Object.defineProperty(target.prototype, "getTypeName", {
        value: function () { return __selfType; },
        configurable: true,
        writable: true
    });
}
/**Script in charge of raising the flag once the ball enters flag collider. Not important and can be skipped.
 * Just helps with the visuals, but if used must be attached to the flag object with Y-axis as up axis.
 * Flag is raised with the basic lerp
 */
let FlagController = (() => {
    let _classDecorators = [component];
    let _classDescriptor;
    let _classExtraInitializers = [];
    let _classThis;
    let _classSuper = BaseScriptComponent;
    var FlagController = _classThis = class extends _classSuper {
        constructor() {
            super();
            this.lerpSpeed = this.lerpSpeed;
            this.loweredY = this.loweredY;
            this.raisedY = this.raisedY;
            this.lerpThreshold = this.lerpThreshold;
            this.triggerCollider = this.triggerCollider;
            this.currentY = 0.0;
            this.targetY = 0.0;
            this.isMoving = false;
        }
        __initialize() {
            super.__initialize();
            this.lerpSpeed = this.lerpSpeed;
            this.loweredY = this.loweredY;
            this.raisedY = this.raisedY;
            this.lerpThreshold = this.lerpThreshold;
            this.triggerCollider = this.triggerCollider;
            this.currentY = 0.0;
            this.targetY = 0.0;
            this.isMoving = false;
        }
        onAwake() {
            this.createEvent("OnStartEvent").bind(() => this.onStart());
            this.createEvent("UpdateEvent").bind(() => this.onUpdate());
        }
        onStart() {
            this.flagTransform = this.sceneObject.getTransform();
            this.currentY = this.loweredY;
            this.targetY = this.loweredY;
            const localPos = this.flagTransform.getLocalPosition();
            this.flagTransform.setLocalPosition(new vec3(localPos.x, this.currentY, localPos.z));
            // Event when ball enters trigger area (used to raise the flag)
            this.triggerCollider.onOverlapEnter.add((e) => {
                const otherBody = e.overlap.collider.sceneObject.getComponent("Physics.BodyComponent");
                if (!otherBody)
                    return;
                this.targetY = this.raisedY;
                this.isMoving = true;
            });
            // Event when ball exits trigger area (used to lower the flag)
            this.triggerCollider.onOverlapExit.add((e) => {
                const otherBody = e.overlap.collider.sceneObject.getComponent("Physics.BodyComponent");
                if (!otherBody)
                    return;
                this.targetY = this.loweredY;
                this.isMoving = true;
            });
        }
        onUpdate() {
            if (!this.isMoving)
                return;
            const dt = getDeltaTime();
            this.currentY += (this.targetY - this.currentY) * this.lerpSpeed * dt;
            if (this.targetY === this.raisedY && this.currentY > this.raisedY - this.lerpThreshold) {
                this.currentY = this.raisedY;
                this.isMoving = false;
            }
            else if (this.targetY === this.loweredY && this.currentY < this.loweredY + this.lerpThreshold) {
                this.currentY = this.loweredY;
                this.isMoving = false;
            }
            const localPos = this.flagTransform.getLocalPosition();
            this.flagTransform.setLocalPosition(new vec3(localPos.x, this.currentY, localPos.z));
        }
    };
    __setFunctionName(_classThis, "FlagController");
    (() => {
        const _metadata = typeof Symbol === "function" && Symbol.metadata ? Object.create(_classSuper[Symbol.metadata] ?? null) : void 0;
        __esDecorate(null, _classDescriptor = { value: _classThis }, _classDecorators, { kind: "class", name: _classThis.name, metadata: _metadata }, null, _classExtraInitializers);
        FlagController = _classThis = _classDescriptor.value;
        if (_metadata) Object.defineProperty(_classThis, Symbol.metadata, { enumerable: true, configurable: true, writable: true, value: _metadata });
        __runInitializers(_classThis, _classExtraInitializers);
    })();
    return FlagController = _classThis;
})();
exports.FlagController = FlagController;
//# sourceMappingURL=FlagController.js.map