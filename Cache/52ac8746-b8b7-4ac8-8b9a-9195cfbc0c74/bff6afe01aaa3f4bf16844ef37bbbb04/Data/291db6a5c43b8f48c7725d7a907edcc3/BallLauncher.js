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
exports.BallLauncher = void 0;
var __selfType = requireType("./BallLauncher");
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
/**Main script in charge of launching the ball. Must be attached to ball object
 * Handles physics, hand/mouse input, trail building, out of bounds event
 *
 * Do not forget to disable simulation mode before testing on Specs since only 1 mode can be active at a time
 */
const SIK_1 = require("SpectaclesInteractionKit.lspkg/SIK");
let BallLauncher = (() => {
    let _classDecorators = [component];
    let _classDescriptor;
    let _classExtraInitializers = [];
    let _classThis;
    let _classSuper = BaseScriptComponent;
    var BallLauncher = _classThis = class extends _classSuper {
        constructor() {
            super();
            this.maxPullDistance = this.maxPullDistance;
            this.launchForceMultiplier = this.launchForceMultiplier;
            this.grabRadius = this.grabRadius;
            this.stopThreshold = this.stopThreshold;
            this.slingBase = this.slingBase;
            this.slingPart = this.slingPart;
            this.arrowObject = this.arrowObject;
            this.powerBarObject = this.powerBarObject;
            this.outOfBoundsEffect = this.outOfBoundsEffect;
            this.outOfBoundsTriggers = this.outOfBoundsTriggers;
            this.outOfBoundsSound = this.outOfBoundsSound;
            this.wallHitSound = this.wallHitSound;
            this.stretchSound = this.stretchSound;
            this.releaseWeakSound = this.releaseWeakSound;
            this.releaseStrongSound = this.releaseStrongSound;
            this.enableTrail = this.enableTrail;
            this.trailObject = this.trailObject;
            this.trailMaterial = this.trailMaterial;
            this.trailColor = this.trailColor;
            this.trailWidth = this.trailWidth;
            this.trailLength = this.trailLength;
            this.trailUpdateInterval = this.trailUpdateInterval;
            this.simulatorMode = this.simulatorMode;
            this.simulatorCamera = this.simulatorCamera;
            this.maxScreenPull = this.maxScreenPull;
            this.debugMode = this.debugMode;
            this.inputBlocked = false;
            this.state = "IDLE";
            this.lastPinchPos = vec3.zero();
            this.simTouchStart = vec2.zero();
            this.simDragDelta = vec2.zero();
            this.isTouching = false;
            this.lastShotPosition = vec3.zero();
            this.isReturning = false;
            // Power bar colors cache
            this.COLOR_GREY = new vec4(0.5, 0.5, 0.5, 1.0);
            this.COLOR_YELLOW = new vec4(1.0, 0.85, 0.0, 1.0);
            this.COLOR_GREEN = new vec4(0.2, 0.9, 0.2, 1.0);
            this.COLOR_RED = new vec4(0.9, 0.1, 0.1, 1.0);
            // Sling constants. Slingshot is animated by changing Z-axis scale of the sling (the pivot point is positioned the way it would look like the sling stretches)
            this.SLING_Z_REST = 0.125; // sling scale state at rest
            this.SLING_Z_MAX = 1.65; // sling scale state when fully stretched/charged
            this.SLING_Z_STRIKE = 0.12; // impulse fires when sling Z-scale <= this
            this.SLING_Z_END = -0.1; // sling scale when fired (for better visial effect of hitting the ball)
            this.SLING_RELEASE_DURATION = 0.05; // seconds for release snap
            this.SLING_HIDE_DELAY = 0.35; // seconds to hide slingBase after impact
            // Sling release animation state
            this.isSlingReleasing = false;
            this.slingReleaseStartZ = 0.125;
            this.slingReleaseElapsed = 0;
            this.pendingImpulse = null;
            this.hasAppliedImpulse = false;
            this.currentPullT = 0;
            this.firedFrameGuard = 0; // skip tryStopBall for N frames after applyImpulse (to avoid stopping the ball right away if the hit force is too small)
            // Cached slingshot derived values (computed once in onStart)
            this._stopThresholdSq = 0;
            this._currentSlingZ = 0;
            this._slingScaleX = 1;
            this._slingScaleY = 1;
            this._powerBarScaleX = 1;
            this._powerBarScaleY = 1;
            this.trailFrameCount = 0;
            this._trailPos = []; // [trailLength][3],position xyz per vertex
            this._trailCol = []; // [trailLength][4], rgba per vertex
            this._trailVtx = []; // [trailLength], [[pos],[col]] wrappers
            this._trailIndices = []; // pre-baked [0,1,...,trailLength-1]
            this._trailHead = 0; // circular write pointer (advances by 2 per update)
            this._VEC3_UP = new vec3(0, 1, 0); // values to determine up and side to draw trail along with the ball's movement direction
            this._VEC3_SIDE = new vec3(1, 0, 0); // values to determine up and side to draw trail along with the ball's movement direction
            this.onStateChanged = null;
        }
        __initialize() {
            super.__initialize();
            this.maxPullDistance = this.maxPullDistance;
            this.launchForceMultiplier = this.launchForceMultiplier;
            this.grabRadius = this.grabRadius;
            this.stopThreshold = this.stopThreshold;
            this.slingBase = this.slingBase;
            this.slingPart = this.slingPart;
            this.arrowObject = this.arrowObject;
            this.powerBarObject = this.powerBarObject;
            this.outOfBoundsEffect = this.outOfBoundsEffect;
            this.outOfBoundsTriggers = this.outOfBoundsTriggers;
            this.outOfBoundsSound = this.outOfBoundsSound;
            this.wallHitSound = this.wallHitSound;
            this.stretchSound = this.stretchSound;
            this.releaseWeakSound = this.releaseWeakSound;
            this.releaseStrongSound = this.releaseStrongSound;
            this.enableTrail = this.enableTrail;
            this.trailObject = this.trailObject;
            this.trailMaterial = this.trailMaterial;
            this.trailColor = this.trailColor;
            this.trailWidth = this.trailWidth;
            this.trailLength = this.trailLength;
            this.trailUpdateInterval = this.trailUpdateInterval;
            this.simulatorMode = this.simulatorMode;
            this.simulatorCamera = this.simulatorCamera;
            this.maxScreenPull = this.maxScreenPull;
            this.debugMode = this.debugMode;
            this.inputBlocked = false;
            this.state = "IDLE";
            this.lastPinchPos = vec3.zero();
            this.simTouchStart = vec2.zero();
            this.simDragDelta = vec2.zero();
            this.isTouching = false;
            this.lastShotPosition = vec3.zero();
            this.isReturning = false;
            // Power bar colors cache
            this.COLOR_GREY = new vec4(0.5, 0.5, 0.5, 1.0);
            this.COLOR_YELLOW = new vec4(1.0, 0.85, 0.0, 1.0);
            this.COLOR_GREEN = new vec4(0.2, 0.9, 0.2, 1.0);
            this.COLOR_RED = new vec4(0.9, 0.1, 0.1, 1.0);
            // Sling constants. Slingshot is animated by changing Z-axis scale of the sling (the pivot point is positioned the way it would look like the sling stretches)
            this.SLING_Z_REST = 0.125; // sling scale state at rest
            this.SLING_Z_MAX = 1.65; // sling scale state when fully stretched/charged
            this.SLING_Z_STRIKE = 0.12; // impulse fires when sling Z-scale <= this
            this.SLING_Z_END = -0.1; // sling scale when fired (for better visial effect of hitting the ball)
            this.SLING_RELEASE_DURATION = 0.05; // seconds for release snap
            this.SLING_HIDE_DELAY = 0.35; // seconds to hide slingBase after impact
            // Sling release animation state
            this.isSlingReleasing = false;
            this.slingReleaseStartZ = 0.125;
            this.slingReleaseElapsed = 0;
            this.pendingImpulse = null;
            this.hasAppliedImpulse = false;
            this.currentPullT = 0;
            this.firedFrameGuard = 0; // skip tryStopBall for N frames after applyImpulse (to avoid stopping the ball right away if the hit force is too small)
            // Cached slingshot derived values (computed once in onStart)
            this._stopThresholdSq = 0;
            this._currentSlingZ = 0;
            this._slingScaleX = 1;
            this._slingScaleY = 1;
            this._powerBarScaleX = 1;
            this._powerBarScaleY = 1;
            this.trailFrameCount = 0;
            this._trailPos = []; // [trailLength][3],position xyz per vertex
            this._trailCol = []; // [trailLength][4], rgba per vertex
            this._trailVtx = []; // [trailLength], [[pos],[col]] wrappers
            this._trailIndices = []; // pre-baked [0,1,...,trailLength-1]
            this._trailHead = 0; // circular write pointer (advances by 2 per update)
            this._VEC3_UP = new vec3(0, 1, 0); // values to determine up and side to draw trail along with the ball's movement direction
            this._VEC3_SIDE = new vec3(1, 0, 0); // values to determine up and side to draw trail along with the ball's movement direction
            this.onStateChanged = null;
        }
        setInputBlocked(blocked) {
            this.inputBlocked = blocked;
        }
        triggerOutOfBounds() {
            if (this.isReturning)
                return;
            this.onBallOutOfBounds();
        }
        resetLastShotPosition() {
            this.lastShotPosition = this.ballTransform.getWorldPosition();
        }
        setState(s) {
            this.state = s;
            if (this.onStateChanged)
                this.onStateChanged(s);
        }
        onAwake() {
            this.body = this.sceneObject.getComponent("Physics.BodyComponent");
            this.ballTransform = this.sceneObject.getTransform();
            this.createEvent("OnStartEvent").bind(() => this.onStart());
            this.createEvent("UpdateEvent").bind(() => this.onUpdate());
        }
        onStart() {
            // Add callback to check if collided with the wall (prevents playing wallHit sound effect when ball moves on the floor)
            this.body.onCollisionEnter.add((e) => {
                if (this.state !== "FIRED" && this.state !== "MOVING")
                    return;
                const contacts = e.collision.contacts;
                if (!contacts || contacts.length === 0)
                    return;
                const normal = contacts[0].normal;
                if (Math.abs(normal.y) > 0.7)
                    return;
                if (!this.wallHitSound.isPlaying())
                    this.wallHitSound.play(1);
            });
            this.powerBarTransform = this.powerBarObject.getTransform();
            this.outOfBoundsEffectTransform = this.outOfBoundsEffect.getTransform();
            this.slingBaseTransform = this.slingBase.getTransform();
            this.slingPartTransform = this.slingPart.getTransform();
            this.arrowObject.enabled = false;
            this.powerBarObject.enabled = false;
            this.outOfBoundsEffect.enabled = false;
            this.slingBase.enabled = false;
            this._stopThresholdSq = this.stopThreshold * this.stopThreshold;
            // Cache sling part X/Y scale once so setSlingZ never reads the transform.
            const slingInitScale = this.slingPartTransform.getLocalScale();
            this._slingScaleX = slingInitScale.x;
            this._slingScaleY = slingInitScale.y;
            this._currentSlingZ = slingInitScale.z;
            // Cache power bar X/Y scale once so updatePowerBar never reads the transform.
            const pbInitScale = this.powerBarTransform.getLocalScale();
            this._powerBarScaleX = pbInitScale.x;
            this._powerBarScaleY = pbInitScale.y;
            this.powerBarTransform.setLocalScale(new vec3(pbInitScale.x, pbInitScale.y, 0));
            // Init sling to rest scale (prevents flash of previous state on first show)
            this.setSlingZ(this.SLING_Z_REST);
            this.lastShotPosition = this.ballTransform.getWorldPosition();
            // Add callback to fire when ball hits out of bounds collider
            this.body.onOverlapEnter.add((e) => {
                if (this.isReturning)
                    return;
                const col = e.overlap.collider;
                const isOOB = this.outOfBoundsTriggers.some(t => col.isSame(t));
                if (!isOOB)
                    return;
                this.onBallOutOfBounds();
            });
            // Pre-allocate delayed events so release/OOB paths never call createEvent().
            this._slingHideEvent = this.createEvent("DelayedCallbackEvent");
            this._slingHideEvent.bind(() => {
                this.slingBase.enabled = false;
            });
            this._returnBallEvent = this.createEvent("DelayedCallbackEvent");
            this._returnBallEvent.bind(() => {
                this.ballTransform.setWorldPosition(this.lastShotPosition);
                this.outOfBoundsEffect.enabled = false;
                this.isReturning = false;
                this.body.dynamic = true;
                this.setState("IDLE");
                if (this.debugMode)
                    print("Ball returned to last shot position");
            });
            if (this.simulatorMode) {
                this.setupMouseInput();
            }
            else {
                this.setupHandInput();
            }
            this.body.dynamic = true;
            if (this.enableTrail)
                this.initTrail();
        }
        // ------------------ Slingshot helpers ------------------------------------------
        setSlingZ(z) {
            this._currentSlingZ = z;
            this.slingPartTransform.setLocalScale(new vec3(this._slingScaleX, this._slingScaleY, z));
        }
        getSlingZ() {
            return this._currentSlingZ;
        }
        /** Called when aiming started: prepares sling then shows slingBase */
        showSlingshot() {
            this.setSlingZ(this.SLING_Z_REST);
            this.slingBaseTransform.setWorldPosition(this.ballTransform.getWorldPosition());
            this.slingBase.enabled = true;
            this.arrowObject.enabled = false;
            this.powerBarObject.enabled = false;
        }
        /** Hide all aim visuals immediately (obstacle cancel, resetBall, etc.) */
        hideAimVisuals() {
            this.arrowObject.enabled = false;
            this.powerBarObject.enabled = false;
            this.slingBase.enabled = false;
            this.isSlingReleasing = false;
            this.pendingImpulse = null;
            this.stopStretchSound();
        }
        /** Hide directionArrow & powerBar but keep slingBase visible for a while (called at release start) */
        hideAimUI() {
            this.arrowObject.enabled = false;
            this.powerBarObject.enabled = false;
        }
        startStretchSound() {
            if (!this.stretchSound.isPlaying())
                this.stretchSound.play(1);
        }
        stopStretchSound() {
            if (this.stretchSound.isPlaying())
                this.stretchSound.stop(false);
        }
        /** Begin the sling snap animation.
         * impulseVec is stored and applied when sling Z crosses SLING_Z_STRIKE.
         */
        startSlingRelease(impulseVec, pullT) {
            this.stopStretchSound();
            if (pullT >= 0.85) {
                if (!this.releaseStrongSound.isPlaying())
                    this.releaseStrongSound.play(1);
            }
            else {
                if (!this.releaseWeakSound.isPlaying())
                    this.releaseWeakSound.play(1);
            }
            this.hideAimUI();
            this.isSlingReleasing = true;
            this.slingReleaseStartZ = this.getSlingZ();
            this.slingReleaseElapsed = 0;
            this.pendingImpulse = impulseVec;
            this.hasAppliedImpulse = false;
        }
        /** Updates sling visual and values during aiming and launch hit animation if sling is released */
        updateSlingRelease() {
            const dt = getDeltaTime();
            this.slingReleaseElapsed += dt;
            const progress = Math.min(this.slingReleaseElapsed / this.SLING_RELEASE_DURATION, 1.0);
            const currentZ = this.slingReleaseStartZ + progress * (this.SLING_Z_END - this.slingReleaseStartZ);
            this.setSlingZ(currentZ);
            // Apply impulse when sling reaches strike point
            if (!this.hasAppliedImpulse && currentZ <= this.SLING_Z_STRIKE && this.pendingImpulse) {
                this.applyImpulse(this.pendingImpulse);
                this.hasAppliedImpulse = true;
            }
            if (progress >= 1.0) {
                this.isSlingReleasing = false;
                this.pendingImpulse = null;
                this._slingHideEvent.reset(this.SLING_HIDE_DELAY);
            }
        }
        /** The actual physics impulse + state transition. Called from updateSlingRelease. */
        applyImpulse(impulse) {
            this.lastShotPosition = this.ballTransform.getWorldPosition();
            this.body.addForce(impulse, Physics.ForceMode.Impulse);
            const gm = global["GameManager"];
            if (gm)
                gm.onShotStarted();
            if (this.debugMode)
                print("FIRED, impulse=" + impulse.length.toFixed(2));
            if (this.enableTrail) {
                this.trailMeshVisual.enabled = true;
                this.trailFrameCount = 0;
                this.resetTrail();
            }
            this.firedFrameGuard = 5; // physics needs a few frames to update velocity
            this.setState("FIRED");
        }
        /** Method in charge of out of bounds effect. Checkes conditions, sends info
         * to Game Manager (to count shots and trigger out of shots conditions if occur),
         * enables and plays animation, SFX & VFX and returns ball to last saved position
         */
        onBallOutOfBounds() {
            this.isReturning = true;
            if (this.trailMeshVisual)
                this.trailMeshVisual.enabled = false;
            const gm = global["GameManager"];
            if (gm)
                gm.onBallOutOfBounds();
            this.body.velocity = vec3.zero();
            this.body.angularVelocity = vec3.zero();
            this.body.dynamic = false;
            if (!this.outOfBoundsSound.isPlaying())
                this.outOfBoundsSound.play(1);
            const currentBallPos = this.ballTransform.getWorldPosition();
            this.outOfBoundsEffectTransform.setWorldPosition(currentBallPos);
            this.outOfBoundsEffect.enabled = true;
            let outOfBoundsMaterial = this.outOfBoundsEffect.getComponent("Component.RenderMeshVisual").getMaterial(0);
            let anim = outOfBoundsMaterial.mainPass.baseTex.control;
            let duration = anim.getDuration();
            anim.play(1, 0);
            print(anim.isPlaying());
            this._returnBallEvent.reset(duration);
        }
        // ---------- Simulator input ----------------------------------------
        /**Method in charge of mouse input setup. Checks when mouse touch is started-finished, if it is withing the ball grab radius, calculates pinch distance
         * and applies corresponding methods
         */
        setupMouseInput() {
            this.createEvent("TouchStartEvent").bind((e) => {
                if (this.inputBlocked)
                    return;
                this.isTouching = true;
                if (this.state !== "IDLE")
                    return;
                const touchPos = e.getTouchPosition();
                const ballScreenPos = this.simulatorCamera.worldSpaceToScreenSpace(this.ballTransform.getWorldPosition());
                const dx = ballScreenPos.x - touchPos.x;
                const dy = ballScreenPos.y - touchPos.y;
                if (dx * dx + dy * dy < 0.15 * 0.15) {
                    this.simTouchStart = touchPos;
                    this.simDragDelta = vec2.zero();
                    this.setState("AIMING");
                    this.currentPullT = 0;
                    this.showSlingshot();
                    this.startStretchSound();
                    if (this.debugMode)
                        print("AIMING (simulator)");
                }
            });
            this.createEvent("TouchMoveEvent").bind((e) => {
                if (this.inputBlocked)
                    return;
                this.isTouching = true;
                if (this.state !== "AIMING")
                    return;
                const touchPos = e.getTouchPosition();
                this.simDragDelta = new vec2(touchPos.x - this.simTouchStart.x, touchPos.y - this.simTouchStart.y);
                const launchDir = this.getLaunchDirFromDelta(this.simDragDelta);
                if (launchDir !== null) {
                    this.arrowObject.enabled = true;
                    this.powerBarObject.enabled = true;
                    this.updateAimRotation(launchDir);
                    this.currentPullT = Math.min(this.simDragDelta.length / this.maxScreenPull, 1.0);
                    this.updatePowerBar(this.currentPullT);
                    this.updateSlingScale(this.currentPullT);
                }
            });
            this.createEvent("TouchEndEvent").bind((_e) => {
                if (this.inputBlocked)
                    return;
                this.isTouching = false;
                if (this.state !== "AIMING")
                    return;
                this.state = "IDLE"; // prevent double-fire
                this.fireFromScreenDelta(this.simDragDelta);
            });
        }
        // --------- Hand tracked input ------------------------------
        /**Method in charge of hand input setup. Checks when pinch is started-finished, if it is withing the ball grab radius, calculates pinch distance
         * and applies corresponding methods
         */
        setupHandInput() {
            this._rightHand = SIK_1.SIK.HandInputData.getHand('right');
            this._rightHand.onPinchDown.add(() => {
                if (this.inputBlocked || this.state !== "IDLE")
                    return;
                const indexPos = this.getPinchCenter(this._rightHand);
                const dist = indexPos.distance(this.ballTransform.getWorldPosition());
                if (dist >= this.grabRadius)
                    return;
                this.lastPinchPos = indexPos;
                this.setState("AIMING");
                this.currentPullT = 0;
                this.showSlingshot();
                this.startStretchSound();
                if (this.debugMode)
                    print("AIMING (hand)");
            });
            this._rightHand.onPinchUp.add(() => {
                if (this.state !== "AIMING")
                    return;
                this.setState("IDLE");
                this.fire(this.lastPinchPos);
            });
            this._rightHand.onHandLost.add(() => {
                if (this.state !== "AIMING")
                    return;
                if (this.debugMode)
                    print("Hand lost - firing from last position");
                this.setState("IDLE");
                this.fire(this.lastPinchPos);
            });
        }
        /** Gets center point between point finger and a thumb to calculate direction properly */
        getPinchCenter(hand) {
            const t = hand.thumbTip.position;
            const i = hand.indexTip.position;
            return new vec3((t.x + i.x) * 0.5, (t.y + i.y) * 0.5, (t.z + i.z) * 0.5);
        }
        /** Calculate launch direction base on mouse input data */
        getLaunchDirFromDelta(delta) {
            if (delta.length < 0.01)
                return null;
            const camTransform = this.simulatorCamera.getTransform();
            const flatRight = new vec3(camTransform.right.x, 0, camTransform.right.z).normalize();
            const flatForward = new vec3(camTransform.forward.x, 0, camTransform.forward.z).normalize();
            return flatRight.uniformScale(-delta.x)
                .add(flatForward.uniformScale(-delta.y))
                .normalize();
        }
        /** Rotates slingBase (which contains arrow + powerBar as children).
         * slingBase uses powerBar rotation (angle).
         * arrowObject should have local Y = 180° set in editor.
         */
        updateAimRotation(launchDir) {
            const angle = Math.atan2(launchDir.x, launchDir.z);
            this.slingBaseTransform.setWorldRotation(quat.fromEulerAngles(0, angle + Math.PI, 0));
        }
        updatePowerBar(delta) {
            this.powerBarTransform.setLocalScale(new vec3(this._powerBarScaleX, this._powerBarScaleY, delta));
            let color;
            if (delta <= 0.25) {
                color = this.COLOR_GREY;
            }
            else if (delta <= 0.5) {
                color = vec4.lerp(this.COLOR_GREY, this.COLOR_YELLOW, (delta - 0.25) / 0.25);
            }
            else if (delta <= 0.75) {
                color = vec4.lerp(this.COLOR_YELLOW, this.COLOR_GREEN, (delta - 0.5) / 0.25);
            }
            else {
                color = vec4.lerp(this.COLOR_GREEN, this.COLOR_RED, (delta - 0.75) / 0.25);
            }
            this.powerBarObject.getComponent("Component.RenderMeshVisual").getMaterial(0).mainPass.baseColor = color;
        }
        updateSlingScale(t) {
            // t: 0 → SLING_Z_REST, 1 → SLING_Z_MAX
            const z = this.SLING_Z_REST + t * (this.SLING_Z_MAX - this.SLING_Z_REST);
            this.setSlingZ(z);
        }
        // ----- Fire (simulator) -----------------------
        fireFromScreenDelta(delta) {
            const launchDir = this.getLaunchDirFromDelta(delta);
            if (launchDir === null) {
                this.setState("IDLE");
                this.hideAimVisuals();
                return;
            }
            const t = Math.min(delta.length / this.maxScreenPull, 1.0);
            if (t < 0.01) {
                this.setState("IDLE");
                this.hideAimVisuals();
                return;
            }
            const impulse = launchDir.uniformScale(t * this.launchForceMultiplier);
            this.startSlingRelease(impulse, t);
        }
        // --------------- Fire (hand tracking) -----------------------------------
        fire(pinchPos) {
            const ballPos = this.ballTransform.getWorldPosition();
            const raw = pinchPos.sub(ballPos);
            const flat = new vec3(raw.x, 0, raw.z);
            const pullDist = Math.min(flat.length, this.maxPullDistance);
            const t = pullDist / this.maxPullDistance;
            if (t < 0.01) {
                this.setState("IDLE");
                this.hideAimVisuals();
                return;
            }
            const launchDir = flat.normalize().uniformScale(-1);
            const impulse = launchDir.uniformScale(t * this.launchForceMultiplier);
            this.startSlingRelease(impulse, t);
        }
        /** Checks if ball speed is higher than stopTreshold and if not stops the ball.
         * Sends info to Game Manager to count the shots (shot is counted once the ball has stopped)
         */
        tryStopBall() {
            if (!this.body.dynamic)
                return;
            if (this.firedFrameGuard > 0) {
                this.firedFrameGuard--;
                return;
            }
            const vel = this.body.velocity;
            const velLenSq = vel.x * vel.x + vel.y * vel.y + vel.z * vel.z;
            if (velLenSq >= this._stopThresholdSq)
                return;
            this.body.velocity = vec3.zero();
            this.body.angularVelocity = vec3.zero();
            if (this.state === "FIRED") {
                if (this.trailMeshVisual)
                    this.trailMeshVisual.enabled = false;
                this.setState("IDLE");
                if (this.debugMode)
                    print("IDLE");
                const gm = global["GameManager"];
                if (gm)
                    gm.onBallStopped();
            }
            else if (this.state === "MOVING") {
                this.setState("IDLE");
                if (this.debugMode)
                    print("IDLE (after obstacle)");
            }
        }
        // ------------------- Reset --------------------------------
        resetBall(position) {
            if (this.trailMeshVisual && this.enableTrail)
                this.trailMeshVisual.enabled = false;
            this.body.velocity = vec3.zero();
            this.body.angularVelocity = vec3.zero();
            this.ballTransform.setWorldPosition(position);
            this.setState("IDLE");
            this.hideAimVisuals();
            this.lastShotPosition = position;
            if (this.debugMode)
                print("Ball reset to: " + position);
        }
        // ----------------------------------------- MAIN UPDATE -------------------------------------------------
        onUpdate() {
            // Sling release animation runs regardless of inputBlocked or state
            if (this.isSlingReleasing) {
                this.updateSlingRelease();
            }
            if (this.state === "MOVING") {
                this.tryStopBall();
            }
            else if (this.state === "FIRED") {
                if (this.enableTrail)
                    this.updateTrail();
                this.tryStopBall();
            }
            if (this.inputBlocked)
                return;
            // Obstacle pushed ball during IDLE or AIMING
            if (this.state === "IDLE" || this.state === "AIMING") {
                const vel = this.body.velocity;
                const velLenSq = vel.x * vel.x + vel.y * vel.y + vel.z * vel.z;
                if (velLenSq > this._stopThresholdSq) {
                    if (this.state === "AIMING") {
                        this.hideAimVisuals();
                        if (this.debugMode)
                            print("Aim cancelled by obstacle");
                    }
                    this.setState("MOVING");
                    return;
                }
            }
            if (this.simulatorMode) {
                if (this.state === "AIMING" && !this.isTouching) {
                    if (this.debugMode)
                        print("Touch lost - firing from last position");
                    this.setState("IDLE");
                    this.fireFromScreenDelta(this.simDragDelta);
                }
                return;
            }
            //Hand input 
            if (this.state === "AIMING") {
                this.lastPinchPos = this.getPinchCenter(this._rightHand);
                const ballPos = this.ballTransform.getWorldPosition();
                const raw = this.lastPinchPos.sub(ballPos);
                const flatX = raw.x;
                const flatZ = raw.z;
                const flatLenSq = flatX * flatX + flatZ * flatZ;
                if (flatLenSq > 0.0001) {
                    this.arrowObject.enabled = true;
                    this.powerBarObject.enabled = true;
                    const flatLen = Math.sqrt(flatLenSq);
                    const launchDir = new vec3(flatX, 0, flatZ).normalize().uniformScale(-1);
                    this.updateAimRotation(launchDir);
                    this.currentPullT = Math.min(flatLen / this.maxPullDistance, 1.0);
                    this.updatePowerBar(this.currentPullT);
                    this.updateSlingScale(this.currentPullT);
                }
            }
        }
        // ------------------- Trail--------------------------------
        /** Modified trail asset from asset library. Writes the top and bottom edge positions of the trail ribbon for the current
         * ball position into the two provided pre-allocated number[3] arrays. Avoids returning a heap-allocated object on every call.
         * Uses fallbacks to match trail with ball's current direction
         */
        initTrail() {
            this.trailMeshVisual = this.trailObject.createComponent('Component.RenderMeshVisual');
            this.trailMeshVisual.clearMaterials();
            this.trailMeshVisual.mainMaterial = this.trailMaterial;
            this.trailBuilder = new MeshBuilder([
                { name: 'position', components: 3 },
                { name: 'color', components: 4 },
            ]);
            this.trailBuilder.topology = MeshTopology.TriangleStrip;
            this.trailBuilder.indexType = MeshIndexType.UInt16;
            // Building trail's initial params. If you want you can change trail color here (_trailCol variables)
            for (let i = 0; i < this.trailLength; i++) {
                this._trailPos.push([0, 0, 0]);
                this._trailCol.push([this.trailColor.x, this.trailColor.y, this.trailColor.z, this.trailColor.w]);
                this._trailVtx.push([this._trailPos[i], this._trailCol[i]]);
                this._trailIndices.push(i);
            }
            this.trailMeshVisual.enabled = false;
        }
        /** Calculates top and bottom verticies to build trail mesh */
        getTrailTopBottom(outTop, outBot) {
            const center = this.ballTransform.getWorldPosition();
            const vel = this.body.velocity;
            const half = this.trailWidth * 0.5;
            const velLenSq = vel.x * vel.x + vel.y * vel.y + vel.z * vel.z;
            if (velLenSq > 0.0001) {
                const velNorm = vel.normalize();
                let right = velNorm.cross(this._VEC3_UP);
                // 
                if (right.x * right.x + right.y * right.y + right.z * right.z < 0.0001) {
                    right = velNorm.cross(this._VEC3_SIDE);
                }
                right = right.normalize().uniformScale(half);
                outTop[0] = center.x + right.x;
                outTop[1] = center.y + right.y;
                outTop[2] = center.z + right.z;
                outBot[0] = center.x - right.x;
                outBot[1] = center.y - right.y;
                outBot[2] = center.z - right.z;
            }
            else {
                outTop[0] = center.x;
                outTop[1] = center.y + half;
                outTop[2] = center.z;
                outBot[0] = center.x;
                outBot[1] = center.y - half;
                outBot[2] = center.z;
            }
        }
        resetTrail() {
            const vc = this.trailBuilder.getVerticesCount();
            const ic = this.trailBuilder.getIndicesCount();
            if (vc > 0) {
                this.trailBuilder.eraseVertices(0, vc);
                this.trailBuilder.eraseIndices(0, ic);
            }
            const tmpTop = [0, 0, 0];
            const tmpBot = [0, 0, 0];
            this.getTrailTopBottom(tmpTop, tmpBot);
            for (let i = 0; i < this.trailLength; i++) {
                const isTop = (i % 2 === 0);
                const p = this._trailPos[i];
                p[0] = isTop ? tmpTop[0] : tmpBot[0];
                p[1] = isTop ? tmpTop[1] : tmpBot[1];
                p[2] = isTop ? tmpTop[2] : tmpBot[2];
                this._trailCol[i][3] = 0;
                this.trailBuilder.appendVertices(this._trailVtx[i]);
            }
            this.trailBuilder.appendIndices(this._trailIndices);
            this._trailHead = 0;
            if (this.trailBuilder.isValid()) {
                this.trailMeshVisual.mesh = this.trailBuilder.getMesh();
                this.trailBuilder.updateMesh();
            }
        }
        updateTrail() {
            this.trailFrameCount++;
            if (this.trailFrameCount % this.trailUpdateInterval !== 0)
                return;
            const h = this._trailHead;
            const h1 = (h + 1) % this.trailLength;
            this.getTrailTopBottom(this._trailPos[h], this._trailPos[h1]);
            // Advance head, oldest pair is now at the new head position
            this._trailHead = (h + 2) % this.trailLength;
            // Rebuild mesh in chronological order (from oldest to newest) and update alpha
            const len = this.trailLength;
            const head = this._trailHead;
            this.trailBuilder.eraseVertices(0, this.trailBuilder.getVerticesCount());
            for (let i = 0; i < len; i++) {
                const idx = (head + i) % len;
                this._trailCol[idx][3] = i / len;
                this.trailBuilder.appendVertices(this._trailVtx[idx]);
            }
            if (this.trailBuilder.isValid())
                this.trailBuilder.updateMesh();
        }
    };
    __setFunctionName(_classThis, "BallLauncher");
    (() => {
        const _metadata = typeof Symbol === "function" && Symbol.metadata ? Object.create(_classSuper[Symbol.metadata] ?? null) : void 0;
        __esDecorate(null, _classDescriptor = { value: _classThis }, _classDecorators, { kind: "class", name: _classThis.name, metadata: _metadata }, null, _classExtraInitializers);
        BallLauncher = _classThis = _classDescriptor.value;
        if (_metadata) Object.defineProperty(_classThis, Symbol.metadata, { enumerable: true, configurable: true, writable: true, value: _metadata });
        __runInitializers(_classThis, _classExtraInitializers);
    })();
    return BallLauncher = _classThis;
})();
exports.BallLauncher = BallLauncher;
//# sourceMappingURL=BallLauncher.js.map