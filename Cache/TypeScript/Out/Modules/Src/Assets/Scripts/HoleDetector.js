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
exports.HoleDetector = void 0;
var __selfType = requireType("./HoleDetector");
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
/** Script in charge of detecting if the ball has got in hole.
 * Sends info to the Game Manager once hit is detected (to end the level)
 * Shall be assigned to a SceneObject with collider component (which shall be inside the hole)
 *
 * The collision is detected by collisiong with the object with Body Component. Currently in the lens Ball is the only object with the Body Component
 */
let HoleDetector = (() => {
    let _classDecorators = [component];
    let _classDescriptor;
    let _classExtraInitializers = [];
    let _classThis;
    let _classSuper = BaseScriptComponent;
    var HoleDetector = _classThis = class extends _classSuper {
        constructor() {
            super();
            this.holeSound = this.holeSound;
            this.holeVFXBox = this.holeVFXBox;
        }
        __initialize() {
            super.__initialize();
            this.holeSound = this.holeSound;
            this.holeVFXBox = this.holeVFXBox;
        }
        onAwake() {
            this.createEvent("OnStartEvent").bind(() => this.onStart());
        }
        onStart() {
            this.holeCollider = this.sceneObject.getComponent("Physics.ColliderComponent");
            this.holeVFXBox.enabled = false;
            this.holeCollider.onOverlapEnter.add((e) => {
                const otherBody = e.overlap.collider.sceneObject.getComponent("Physics.BodyComponent");
                if (!otherBody)
                    return;
                if (!this.holeSound.isPlaying())
                    this.holeSound.play(1);
                this.playHoleVFX();
            });
        }
        playHoleVFX() {
            const vfxMaterial = this.holeVFXBox.getComponent("Component.RenderMeshVisual").getMaterial(0);
            const anim = vfxMaterial.mainPass.baseTex.control;
            const duration = anim.getDuration();
            this.holeVFXBox.enabled = true;
            anim.play(1, 0);
            const endEvent = this.createEvent("DelayedCallbackEvent");
            endEvent.bind(() => {
                this.holeVFXBox.enabled = false;
                const gm = global["GameManager"];
                if (gm && typeof gm.onBallInHole === "function") {
                    gm.onBallInHole();
                }
                else {
                    print("GameManager not found");
                }
            });
            endEvent.reset(duration);
        }
    };
    __setFunctionName(_classThis, "HoleDetector");
    (() => {
        const _metadata = typeof Symbol === "function" && Symbol.metadata ? Object.create(_classSuper[Symbol.metadata] ?? null) : void 0;
        __esDecorate(null, _classDescriptor = { value: _classThis }, _classDecorators, { kind: "class", name: _classThis.name, metadata: _metadata }, null, _classExtraInitializers);
        HoleDetector = _classThis = _classDescriptor.value;
        if (_metadata) Object.defineProperty(_classThis, Symbol.metadata, { enumerable: true, configurable: true, writable: true, value: _metadata });
        __runInitializers(_classThis, _classExtraInitializers);
    })();
    return HoleDetector = _classThis;
})();
exports.HoleDetector = HoleDetector;
//# sourceMappingURL=HoleDetector.js.map