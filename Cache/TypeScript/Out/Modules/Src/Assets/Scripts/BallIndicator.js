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
exports.BallIndicator = void 0;
var __selfType = requireType("./BallIndicator");
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
/**Script in charge of showing blinking cylinder object on top of the ball (helps player to see where the ball currently is)
 * Also shows hand hint at start and destroys it after first hit
 */
let BallIndicator = (() => {
    let _classDecorators = [component];
    let _classDescriptor;
    let _classExtraInitializers = [];
    let _classThis;
    let _classSuper = BaseScriptComponent;
    var BallIndicator = _classThis = class extends _classSuper {
        constructor() {
            super();
            //Used to check the state, so the indicator is showed only when the ball state is IDLE
            this.ballLauncher = this.ballLauncher;
            //Used to get world position and move the indicator there
            this.ballObject = this.ballObject;
            this.yOffset = this.yOffset;
            this.indicatorColor = this.indicatorColor;
            this.alphaMin = this.alphaMin;
            this.alphaMax = this.alphaMax;
            this.alphaSpeed = this.alphaSpeed;
            this.handHint = this.handHint;
            this._alpha = 0;
            this._alphaDir = 1;
            this._isAnimating = false;
            this._hintDestroyed = false;
        }
        __initialize() {
            super.__initialize();
            //Used to check the state, so the indicator is showed only when the ball state is IDLE
            this.ballLauncher = this.ballLauncher;
            //Used to get world position and move the indicator there
            this.ballObject = this.ballObject;
            this.yOffset = this.yOffset;
            this.indicatorColor = this.indicatorColor;
            this.alphaMin = this.alphaMin;
            this.alphaMax = this.alphaMax;
            this.alphaSpeed = this.alphaSpeed;
            this.handHint = this.handHint;
            this._alpha = 0;
            this._alphaDir = 1;
            this._isAnimating = false;
            this._hintDestroyed = false;
        }
        onAwake() {
            this.createEvent("OnStartEvent").bind(() => this.onStart());
            this.createEvent("UpdateEvent").bind(() => this.onUpdate());
        }
        onStart() {
            this.handHint.enabled = false;
            const visual = this.sceneObject.getComponent('Component.RenderMeshVisual');
            this._mat = visual.mainMaterial;
            this.sceneObject.enabled = false;
            // For performance the ball state is not checked every frame, but the callback event is sent each time state has changed
            // If state is IDLE -> show indicator
            const launcher = this.ballLauncher;
            launcher.onStateChanged = (s) => {
                if (s === "IDLE") {
                    const bp = this.ballObject.getTransform().getWorldPosition();
                    this.sceneObject.getTransform().setWorldPosition(new vec3(bp.x, bp.y + this.yOffset, bp.z));
                    this._alpha = this.alphaMin;
                    this._alphaDir = 1;
                    this._mat.mainPass.baseColor = new vec4(1, 0.329412, 0.419608, 0);
                    this.sceneObject.enabled = true;
                    this._isAnimating = true;
                    if (!this._hintDestroyed) {
                        this.handHint.enabled = true;
                    }
                }
                else if (s === "AIMING") {
                    this.sceneObject.enabled = false;
                    this._isAnimating = false;
                    if (!this._hintDestroyed) {
                        this.handHint.destroy();
                        this._hintDestroyed = true;
                    }
                }
                else {
                    this.sceneObject.enabled = false;
                    this._isAnimating = false;
                }
            };
        }
        onUpdate() {
            if (!this._isAnimating)
                return;
            this._alpha += this._alphaDir * this.alphaSpeed * getDeltaTime();
            if (this._alpha >= this.alphaMax) {
                this._alpha = this.alphaMax;
                this._alphaDir = -1;
            }
            else if (this._alpha <= this.alphaMin) {
                this._alpha = this.alphaMin;
                this._alphaDir = 1;
            }
            this._mat.mainPass.baseColor = new vec4(this.indicatorColor.x, this.indicatorColor.y, this.indicatorColor.z, this._alpha);
        }
    };
    __setFunctionName(_classThis, "BallIndicator");
    (() => {
        const _metadata = typeof Symbol === "function" && Symbol.metadata ? Object.create(_classSuper[Symbol.metadata] ?? null) : void 0;
        __esDecorate(null, _classDescriptor = { value: _classThis }, _classDecorators, { kind: "class", name: _classThis.name, metadata: _metadata }, null, _classExtraInitializers);
        BallIndicator = _classThis = _classDescriptor.value;
        if (_metadata) Object.defineProperty(_classThis, Symbol.metadata, { enumerable: true, configurable: true, writable: true, value: _metadata });
        __runInitializers(_classThis, _classExtraInitializers);
    })();
    return BallIndicator = _classThis;
})();
exports.BallIndicator = BallIndicator;
//# sourceMappingURL=BallIndicator.js.map