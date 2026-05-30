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
exports.GameUI = void 0;
var __selfType = requireType("./GameUI");
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
/** Script in charge of showing the UI between levels.
 * Controls the UI animation, data update (current score, total score, if-else last level) and "next" button tap.
 * Pretty straightforward
 */
const CapsuleButton_1 = require("SpectaclesUIKit.lspkg/Scripts/Components/Button/CapsuleButton");
let GameUI = (() => {
    let _classDecorators = [component];
    let _classDescriptor;
    let _classExtraInitializers = [];
    let _classThis;
    let _classSuper = BaseScriptComponent;
    var GameUI = _classThis = class extends _classSuper {
        constructor() {
            super();
            this.panelRoot = this.panelRoot;
            this.messageText = this.messageText;
            this.levelScoreText = this.levelScoreText;
            this.totalScoreText = this.totalScoreText;
            this.buttonText = this.buttonText;
            this.buttonObject = this.buttonObject;
            this.buttonSound = this.buttonSound;
            this.dismissDelay = this.dismissDelay;
            this.animSpeed = this.animSpeed;
            this.currentScale = 0;
            this.targetScale = 0;
            this.animState = "IDLE";
            this.buttonLocked = false;
            this.OVERSHOOT = 1.1;
        }
        __initialize() {
            super.__initialize();
            this.panelRoot = this.panelRoot;
            this.messageText = this.messageText;
            this.levelScoreText = this.levelScoreText;
            this.totalScoreText = this.totalScoreText;
            this.buttonText = this.buttonText;
            this.buttonObject = this.buttonObject;
            this.buttonSound = this.buttonSound;
            this.dismissDelay = this.dismissDelay;
            this.animSpeed = this.animSpeed;
            this.currentScale = 0;
            this.targetScale = 0;
            this.animState = "IDLE";
            this.buttonLocked = false;
            this.OVERSHOOT = 1.1;
        }
        onAwake() {
            global["GameUI"] = this;
            this.createEvent("OnStartEvent").bind(() => this.onStart());
            this.createEvent("UpdateEvent").bind(() => this.onUpdate());
        }
        onStart() {
            this.panelTransform = this.panelRoot.getTransform();
            this.baseScale = this.panelTransform.getLocalScale();
            this.panelTransform.setLocalScale(vec3.zero());
            this.panelRoot.enabled = false;
            const capsuleButton = this.buttonObject.getComponent(CapsuleButton_1.CapsuleButton.getTypeName());
            if (capsuleButton) {
                capsuleButton.onTriggerUp.add(() => {
                    if (this.buttonLocked)
                        return;
                    this.onButtonPressed();
                });
            }
            else {
                print("GameUI: CapsuleButton not found");
            }
        }
        showPanel(type, levelScore, totalScore, shots, isLastLevel) {
            this.levelScoreText.text = "LEVEL SCORE: +" + levelScore;
            this.totalScoreText.text = "TOTAL SCORE: " + totalScore;
            this.buttonText.text = isLastLevel ? "Play Again" : "Next Level";
            if (type === "GAME_OVER") {
                this.messageText.text = "GAME OVER";
            }
            else if (type === "OUT_OF_SHOTS") {
                this.messageText.text = "OUT OF SHOTS";
            }
            else if (shots === 1) {
                this.messageText.text = "HOLE IN ONE!";
            }
            else if (shots <= 3) {
                this.messageText.text = "GREAT SHOT!";
            }
            else {
                this.messageText.text = "LEVEL COMPLETE";
            }
            ;
            this.buttonLocked = false;
            this.currentScale = 0;
            this.targetScale = this.OVERSHOOT;
            this.panelRoot.enabled = true;
            this.animState = "SHOWING";
        }
        onButtonPressed() {
            if (this.buttonLocked)
                return;
            this.buttonLocked = true;
            if (!this.buttonSound.isPlaying())
                this.buttonSound.play(1);
            const delay = this.createEvent("DelayedCallbackEvent");
            delay.bind(() => {
                this.animState = "HIDING";
                this.targetScale = 0;
            });
            delay.reset(this.dismissDelay);
        }
        onDismissComplete() {
            this.panelRoot.enabled = false;
            this.animState = "IDLE";
            const gm = global["GameManager"];
            if (gm && typeof gm.onNextLevelPressed === "function") {
                gm.onNextLevelPressed();
            }
        }
        onUpdate() {
            if (this.animState === "IDLE")
                return;
            const dt = getDeltaTime();
            if (this.animState === "SHOWING") {
                this.currentScale += (this.targetScale - this.currentScale) * this.animSpeed * dt;
                if (this.currentScale >= this.OVERSHOOT - 0.01) {
                    this.targetScale = 1.0;
                }
                if (this.targetScale === 1.0 && Math.abs(this.currentScale - 1.0) < 0.005) {
                    this.currentScale = 1.0;
                    this.animState = "IDLE";
                }
            }
            if (this.animState === "HIDING") {
                this.currentScale += (this.targetScale - this.currentScale) * this.animSpeed * dt;
                if (Math.abs(this.currentScale) < 0.005) {
                    this.currentScale = 0;
                    this.onDismissComplete();
                    return;
                }
            }
            this.panelTransform.setLocalScale(new vec3(this.baseScale.x * this.currentScale, this.baseScale.y * this.currentScale, this.baseScale.z * this.currentScale));
        }
    };
    __setFunctionName(_classThis, "GameUI");
    (() => {
        const _metadata = typeof Symbol === "function" && Symbol.metadata ? Object.create(_classSuper[Symbol.metadata] ?? null) : void 0;
        __esDecorate(null, _classDescriptor = { value: _classThis }, _classDecorators, { kind: "class", name: _classThis.name, metadata: _metadata }, null, _classExtraInitializers);
        GameUI = _classThis = _classDescriptor.value;
        if (_metadata) Object.defineProperty(_classThis, Symbol.metadata, { enumerable: true, configurable: true, writable: true, value: _metadata });
        __runInitializers(_classThis, _classExtraInitializers);
    })();
    return GameUI = _classThis;
})();
exports.GameUI = GameUI;
//# sourceMappingURL=GameUI.js.map