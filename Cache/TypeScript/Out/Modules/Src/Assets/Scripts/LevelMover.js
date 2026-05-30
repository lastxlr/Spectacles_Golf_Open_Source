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
exports.LevelMover = void 0;
var __selfType = requireType("./LevelMover");
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
/**Script in charge of handling movement and rotation of the level by player.
 * Uses some BallLauncher and GameManger data so level moving/rotating is only possible
 * if the ball is not moving (in order not to affect physics) and the level is currently playing.
 * Supports both hand input and simulation mode.
 * Do not forget to disable simulation mode before testing on Specs since only 1 mode can be active at a time
 */
const SIK_1 = require("SpectaclesInteractionKit.lspkg/SIK");
let LevelMover = (() => {
    let _classDecorators = [component];
    let _classDescriptor;
    let _classExtraInitializers = [];
    let _classThis;
    let _classSuper = BaseScriptComponent;
    var LevelMover = _classThis = class extends _classSuper {
        constructor() {
            super();
            this.toggleButton = this.toggleButton;
            this.ballLauncherComponent = this.ballLauncherComponent;
            this.levelManagerComponent = this.levelManagerComponent;
            this.ballObject = this.ballObject;
            this.levelRoot = this.levelRoot;
            this.grabCube = this.grabCube;
            this.instructionLabel = this.instructionLabel;
            this.moveSensitivity = this.moveSensitivity;
            this.rotateSensitivity = this.rotateSensitivity;
            this.simulatorMode = this.simulatorMode;
            this.simulatorCamera = this.simulatorCamera;
            this.simMoveScale = this.simMoveScale;
            this.simRotateScale = this.simRotateScale;
            this.levelEnded = false;
            this.toggleIsOn = false;
            this.ballIsIdle = true;
            // Hand-tracking grab state & data
            this.grabMode = "NONE";
            this.lastRightPinch = vec3.zero();
            this.lastHandsAngle = 0;
            this._rightPinching = false;
            this._leftPinching = false;
            // Simulator state
            this.simIsTouching = false;
            this.simLastTouchPos = vec2.zero();
            this.simActiveMode = "MOVE"; // mode of the current drag
            this.simNextMode = "MOVE"; // mode for the NEXT touch-start
        }
        __initialize() {
            super.__initialize();
            this.toggleButton = this.toggleButton;
            this.ballLauncherComponent = this.ballLauncherComponent;
            this.levelManagerComponent = this.levelManagerComponent;
            this.ballObject = this.ballObject;
            this.levelRoot = this.levelRoot;
            this.grabCube = this.grabCube;
            this.instructionLabel = this.instructionLabel;
            this.moveSensitivity = this.moveSensitivity;
            this.rotateSensitivity = this.rotateSensitivity;
            this.simulatorMode = this.simulatorMode;
            this.simulatorCamera = this.simulatorCamera;
            this.simMoveScale = this.simMoveScale;
            this.simRotateScale = this.simRotateScale;
            this.levelEnded = false;
            this.toggleIsOn = false;
            this.ballIsIdle = true;
            // Hand-tracking grab state & data
            this.grabMode = "NONE";
            this.lastRightPinch = vec3.zero();
            this.lastHandsAngle = 0;
            this._rightPinching = false;
            this._leftPinching = false;
            // Simulator state
            this.simIsTouching = false;
            this.simLastTouchPos = vec2.zero();
            this.simActiveMode = "MOVE"; // mode of the current drag
            this.simNextMode = "MOVE"; // mode for the NEXT touch-start
        }
        onAwake() {
            global["LevelMover"] = this;
            this.createEvent("OnStartEvent").bind(() => this.onStart());
            this.createEvent("UpdateEvent").bind(() => this.onUpdate());
        }
        onStart() {
            this.ballBody = this.ballObject.getComponent("Physics.BodyComponent");
            this.levelTransform = this.levelRoot.getTransform();
            this.grabCube.enabled = false;
            this.instructionLabel.enabled = false;
            // Subscribe to toggle's onValueChange.
            // Silent isOn setter is used for force-off so this callback is not re-entered.
            if (this.toggleButton?.onValueChange) {
                this.toggleButton.onValueChange.add((_value) => {
                    this.handleToggleChange(this.toggleButton.isOn);
                });
            }
            const previousCallback = this.ballLauncherComponent.onStateChanged;
            // Track ball state so we can refuse toggle activation mid-movement.
            this.ballLauncherComponent.onStateChanged =
                (s) => {
                    previousCallback?.(s);
                    this.ballIsIdle = (s === "IDLE");
                    this.toggleButton.setIsToggleable?.(this.ballIsIdle && !this.levelEnded);
                };
            if (this.simulatorMode) {
                this.setupMouseInput();
            }
            else {
                this.setupHandInput();
            }
        }
        // ------------------ Toggle handling -------------------------------
        handleToggleChange(isOn) {
            if (isOn) {
                if (this.levelEnded || !this.ballIsIdle) {
                    try {
                        // Refuse — silent setter resets visual without firing onValueChange.
                        this.toggleButton.isOn = false;
                        return;
                    }
                    catch {
                        print('ToggleButton.isOn in LevelMover failed');
                    }
                }
                this.activate();
            }
            else {
                this.deactivate();
            }
        }
        // ------------ Public API (called from GameManager) -----------------------
        onLevelEnded() {
            this.levelEnded = true;
            this.toggleButton.setIsToggleable?.(false);
            if (this.toggleIsOn) {
                this.deactivate();
                this.toggleButton.isOn = false;
            }
        }
        onLevelStarted() {
            this.levelEnded = false;
            this.ballIsIdle = true;
            this.toggleButton.setIsToggleable?.(true);
            this.toggleIsOn = false;
            this.grabMode = "NONE";
            this._rightPinching = false;
            this._leftPinching = false;
            this.simNextMode = "MOVE"; // reset alternation for the new level
            this.grabCube.enabled = false;
            this.instructionLabel.enabled = false;
        }
        // ------------ Activate / Deactivate ----------------
        activate() {
            this.toggleIsOn = true;
            // Static body: ball follows levelRoot as a child transform;
            // physics engine won't fight the manual transform change.
            this.ballBody.dynamic = false;
            // Block launcher so no shot can start while player repositions level.
            this.ballLauncherComponent.setInputBlocked(true);
            this.grabCube.enabled = true;
            this.instructionLabel.enabled = true;
            this.grabMode = "NONE";
            this.simIsTouching = false;
        }
        deactivate() {
            this.toggleIsOn = false;
            this.grabMode = "NONE";
            this.simIsTouching = false;
            this.grabCube.enabled = false;
            this.instructionLabel.enabled = false;
            this.ballBody.dynamic = true;
            this.ballLauncherComponent.setInputBlocked(false);
            this.ballLauncherComponent.resetLastShotPosition?.();
            this.levelManagerComponent.syncBoardPosition();
        }
        // ------------- Simulator mouse input -----------------------
        setupMouseInput() {
            this.createEvent("TouchStartEvent").bind((e) => {
                // Only react when toggle is actively on
                if (!this.toggleIsOn)
                    return;
                this.simIsTouching = true;
                this.simActiveMode = this.simNextMode; // lock in which mode this drag uses
                this.simLastTouchPos = e.getTouchPosition();
            });
            this.createEvent("TouchMoveEvent").bind((e) => {
                if (!this.toggleIsOn || !this.simIsTouching)
                    return;
                const currentPos = e.getTouchPosition();
                const delta = new vec2(currentPos.x - this.simLastTouchPos.x, currentPos.y - this.simLastTouchPos.y);
                if (this.simActiveMode === "MOVE") {
                    this.simApplyTranslation(delta);
                }
                else {
                    this.simApplyRotationY(delta);
                }
                this.simLastTouchPos = currentPos;
            });
            this.createEvent("TouchEndEvent").bind((_e) => {
                if (!this.simIsTouching)
                    return;
                this.simIsTouching = false;
                // Alternate mode for the next touch
                this.simNextMode = (this.simActiveMode === "MOVE") ? "ROTATE" : "MOVE";
            });
        }
        /** Maps 2-D screen drag to world-space XZ translation via the camera axes,
         * matching the BallLauncher convention (camera right -> world right,
         * screen Y inverted -> world forward).
         */
        simApplyTranslation(screenDelta) {
            const camT = this.simulatorCamera.getTransform();
            const right = new vec3(camT.right.x, 0, camT.right.z).normalize();
            const forward = new vec3(camT.forward.x, 0, camT.forward.z).normalize();
            const worldDelta = right.uniformScale(screenDelta.x * this.simMoveScale)
                .add(forward.uniformScale(-screenDelta.y * this.simMoveScale));
            const current = this.levelTransform.getWorldPosition();
            this.levelTransform.setWorldPosition(current.add(worldDelta));
        }
        /**Maps horizontal screen drag to Y-axis rotation.
         * Vertical drag is intentionally ignored -> only one axis is allowed.
         */
        simApplyRotationY(screenDelta) {
            const angle = screenDelta.x * this.simRotateScale;
            const yDelta = quat.fromEulerAngles(0, angle, 0);
            const currentRot = this.levelTransform.getWorldRotation();
            this.levelTransform.setWorldRotation(yDelta.multiply(currentRot));
        }
        // ----- Hand Input Setup-----------------------
        setupHandInput() {
            this._rightHand = SIK_1.SIK.HandInputData.getHand('right');
            this._leftHand = SIK_1.SIK.HandInputData.getHand('left');
            this._rightHand.onPinchDown.add(() => {
                if (!this.toggleIsOn)
                    return;
                this._rightPinching = true;
                if (this._leftPinching) {
                    this.grabMode = "ROTATE";
                    this.lastHandsAngle = this.handsAngleXZ(this._rightHand.indexTip.position, this._leftHand.indexTip.position);
                }
                else {
                    this.grabMode = "MOVE";
                    this.lastRightPinch = this._rightHand.indexTip.position;
                }
            });
            this._rightHand.onPinchUp.add(() => {
                this._rightPinching = false;
                this.grabMode = "NONE";
            });
            this._rightHand.onHandLost.add(() => {
                this._rightPinching = false;
                this.grabMode = "NONE";
            });
            this._leftHand.onPinchDown.add(() => {
                if (!this.toggleIsOn)
                    return;
                this._leftPinching = true;
                if (this._rightPinching) {
                    this.grabMode = "ROTATE";
                    this.lastHandsAngle = this.handsAngleXZ(this._rightHand.indexTip.position, this._leftHand.indexTip.position);
                }
                //Left hand doesn't work w/o right
            });
            this._leftHand.onPinchUp.add(() => {
                this._leftPinching = false;
                if (this._rightPinching && this.grabMode === "ROTATE") {
                    this.grabMode = "MOVE";
                    this.lastRightPinch = this._rightHand.indexTip.position;
                }
            });
            this._leftHand.onHandLost.add(() => {
                this._leftPinching = false;
                if (this._rightPinching && this.grabMode === "ROTATE") {
                    this.grabMode = "MOVE";
                    this.lastRightPinch = this._rightHand.indexTip.position;
                }
            });
        }
        // ---------------- Per-frame update (hand tracking) ---------------
        onUpdate() {
            if (!this.toggleIsOn)
                return;
            // In simulator mode all interaction is event-driven (touch events above).
            // Nothing to do here per-frame.
            if (this.simulatorMode)
                return;
            // ------------ Hand tracking ----------------------
            if (this.grabMode === "MOVE" && this._rightPinching) {
                const rPos = this._rightHand.indexTip.position;
                const delta = rPos.sub(this.lastRightPinch).uniformScale(this.moveSensitivity);
                this.levelTransform.setWorldPosition(this.levelTransform.getWorldPosition().add(delta));
                this.lastRightPinch = rPos;
            }
            else if (this.grabMode === "ROTATE" && this._rightPinching && this._leftPinching) {
                const rPos = this._rightHand.indexTip.position;
                const lPos = this._leftHand.indexTip.position;
                const currentAngle = this.handsAngleXZ(rPos, lPos);
                const yDelta = quat.fromEulerAngles(0, (this.lastHandsAngle - currentAngle) * this.rotateSensitivity, 0);
                this.levelTransform.setWorldRotation(yDelta.multiply(this.levelTransform.getWorldRotation()));
                this.lastHandsAngle = currentAngle;
            }
        }
        /** Angle (radians) of the right-to-left vector projected onto XZ-axis */
        handsAngleXZ(right, left) {
            return Math.atan2(right.z - left.z, right.x - left.x);
        }
    };
    __setFunctionName(_classThis, "LevelMover");
    (() => {
        const _metadata = typeof Symbol === "function" && Symbol.metadata ? Object.create(_classSuper[Symbol.metadata] ?? null) : void 0;
        __esDecorate(null, _classDescriptor = { value: _classThis }, _classDecorators, { kind: "class", name: _classThis.name, metadata: _metadata }, null, _classExtraInitializers);
        LevelMover = _classThis = _classDescriptor.value;
        if (_metadata) Object.defineProperty(_classThis, Symbol.metadata, { enumerable: true, configurable: true, writable: true, value: _metadata });
        __runInitializers(_classThis, _classExtraInitializers);
    })();
    return LevelMover = _classThis;
})();
exports.LevelMover = LevelMover;
//# sourceMappingURL=LevelMover.js.map