/**Script in charge of handling movement and rotation of the level by player.
 * Uses some BallLauncher and GameManger data so level moving/rotating is only possible
 * if the ball is not moving (in order not to affect physics) and the level is currently playing.
 * Supports both hand input and simulation mode.
 * Do not forget to disable simulation mode before testing on Specs since only 1 mode can be active at a time
 */

import { SIK } from 'SpectaclesInteractionKit.lspkg/SIK';

@component
export class LevelMover extends BaseScriptComponent {

    @input("Component.ScriptComponent")
    @hint("Button script component of the toggle button from the scene")
    toggleButton!: any;

    @input("Component.ScriptComponent")
    @hint("BallLauncher script component from the scene")
    ballLauncherComponent!: any;

    @input("Component.ScriptComponent")
    @hint("LevelManager script component from the scene")
    levelManagerComponent!: any;

    @input("SceneObject")
    @hint("Ball object script component from the scene")
    ballObject!: SceneObject;

    @input("SceneObject")
    @hint("Root of the leve (Level_Container). This object is moved and rotated with this script")
    levelRoot!: SceneObject;

    @input("SceneObject")
    @hint("Grab cube object: the area around the level which player uses to move-rotate level")
    grabCube!: SceneObject;

    @input("SceneObject")
    @hint("Instruction object from the scene. Appears when toggle is on")
    instructionLabel!: SceneObject;

    @input("float")
    @hint("Sensitivity for translating player's hand movement to amount of level move")
    moveSensitivity: number = 1.0;

    @input("float")
    @hint("Sensitivity for translating player's hands movement to amount of level rotate")
    rotateSensitivity: number = 1.0;

    @input("boolean")
    @hint("Enables testing the level in Lens Studio preview with mouse")
    simulatorMode: boolean = false;

    @input("Component.Camera")
    @hint("Camera object from which mouse movement on screen is translated to moving/rotating level")
    @showIf("simulatorMode")
    simulatorCamera!: Camera;

    @input("float")
    @hint("Sensitivity for translating mouse movement to amount of level move. First touch used to move, next to rotate, etc")
    @showIf("simulatorMode")
    simMoveScale: number = 80.0;

    @input("float")
    @hint("Sensitivity for translating mouse movement to amount of level rotate. First touch used to move, next to rotate, etc")
    @showIf("simulatorMode")
    simRotateScale: number = 6.0;

    // Private state

    private ballBody!:        BodyComponent;
    private levelTransform!:  Transform;

    private levelEnded:  boolean = false;
    private toggleIsOn:  boolean = false;
    private ballIsIdle:  boolean = true;

    // Hand-tracking grab state & data
    private grabMode: "NONE" | "MOVE" | "ROTATE" = "NONE";
    private lastRightPinch: vec3 = vec3.zero();
    private lastHandsAngle: number = 0;
    private _rightHand: any;
    private _leftHand: any;
    private _rightPinching: boolean = false;
    private _leftPinching: boolean = false;

    // Simulator state
    private simIsTouching:  boolean = false;
    private simLastTouchPos: vec2 = vec2.zero();
    private simActiveMode:  "MOVE" | "ROTATE"  = "MOVE";   // mode of the current drag
    private simNextMode:    "MOVE" | "ROTATE"  = "MOVE";   // mode for the NEXT touch-start

    onAwake() {
        (global as any)["LevelMover"] = this;
        
        this.createEvent("OnStartEvent").bind(() => this.onStart());
        this.createEvent("UpdateEvent").bind(() => this.onUpdate());
    }

    private onStart() {

        this.ballBody       = this.ballObject.getComponent("Physics.BodyComponent") as BodyComponent;
        this.levelTransform = this.levelRoot.getTransform();
        this.grabCube.enabled         = false;
        this.instructionLabel.enabled = false;
        

        // Subscribe to toggle's onValueChange.
        // Silent isOn setter is used for force-off so this callback is not re-entered.
        if (this.toggleButton?.onValueChange) {
            this.toggleButton.onValueChange.add((_value: number) => {
                this.handleToggleChange(this.toggleButton.isOn as boolean);
            });
        }

        const previousCallback = this.ballLauncherComponent.onStateChanged;

        // Track ball state so we can refuse toggle activation mid-movement.
        this.ballLauncherComponent.onStateChanged =
            (s: "IDLE" | "AIMING" | "FIRED" | "MOVING") => {
                previousCallback?.(s);
                this.ballIsIdle = (s === "IDLE");
                this.toggleButton.setIsToggleable?.(this.ballIsIdle && !this.levelEnded);
            };

            if (this.simulatorMode) {
                this.setupMouseInput();
            } else {
                this.setupHandInput();
            }
    }

    // ------------------ Toggle handling -------------------------------

    private handleToggleChange(isOn: boolean): void {
        if (isOn) {
            if (this.levelEnded || !this.ballIsIdle) {
                try {
                    // Refuse — silent setter resets visual without firing onValueChange.
                    this.toggleButton.isOn = false;
                    return;
                } catch {
                    print('ToggleButton.isOn in LevelMover failed')
                }
            }
            this.activate();
        } else {
            this.deactivate();
        }
    }

    // ------------ Public API (called from GameManager) -----------------------

    public onLevelEnded(): void {
        this.levelEnded = true;
        this.toggleButton.setIsToggleable?.(false);
        if (this.toggleIsOn) {
            this.deactivate();
            this.toggleButton.isOn = false;
        }
    }

    public onLevelStarted(): void {
        this.levelEnded  = false;
        this.ballIsIdle  = true;
        this.toggleButton.setIsToggleable?.(true);
        this.toggleIsOn  = false;
        this.grabMode    = "NONE";
        this._rightPinching = false;
        this._leftPinching  = false;
        this.simNextMode = "MOVE"; // reset alternation for the new level
        this.grabCube.enabled         = false;
        this.instructionLabel.enabled = false;
    }

    // ------------ Activate / Deactivate ----------------

    private activate(): void {
        this.toggleIsOn = true;

        // Static body: ball follows levelRoot as a child transform;
        // physics engine won't fight the manual transform change.
        this.ballBody.dynamic = false;

        // Block launcher so no shot can start while player repositions level.
        this.ballLauncherComponent.setInputBlocked(true);

        this.grabCube.enabled         = true;
        this.instructionLabel.enabled = true;
        this.grabMode                 = "NONE";
        this.simIsTouching            = false;
    }

    private deactivate(): void {
        this.toggleIsOn    = false;
        this.grabMode      = "NONE";
        this.simIsTouching = false;

        this.grabCube.enabled         = false;
        this.instructionLabel.enabled = false;

        this.ballBody.dynamic = true;
        this.ballLauncherComponent.setInputBlocked(false);
        this.ballLauncherComponent.resetLastShotPosition?.();

        this.levelManagerComponent.syncBoardPosition();
    }

    // ------------- Simulator mouse input -----------------------

    private setupMouseInput(): void {

        this.createEvent("TouchStartEvent").bind((e: TouchStartEvent) => {
            // Only react when toggle is actively on
            if (!this.toggleIsOn) return;

            this.simIsTouching   = true;
            this.simActiveMode   = this.simNextMode;   // lock in which mode this drag uses
            this.simLastTouchPos = e.getTouchPosition();
        });

        this.createEvent("TouchMoveEvent").bind((e: TouchMoveEvent) => {
            if (!this.toggleIsOn || !this.simIsTouching) return;

            const currentPos = e.getTouchPosition();
            const delta = new vec2(
                currentPos.x - this.simLastTouchPos.x,
                currentPos.y - this.simLastTouchPos.y,
            );

            if (this.simActiveMode === "MOVE") {
                this.simApplyTranslation(delta);
            } else {
                this.simApplyRotationY(delta);
            }

            this.simLastTouchPos = currentPos;
        });

        this.createEvent("TouchEndEvent").bind((_e: TouchEndEvent) => {
            if (!this.simIsTouching) return;

            this.simIsTouching = false;

            // Alternate mode for the next touch
            this.simNextMode = (this.simActiveMode === "MOVE") ? "ROTATE" : "MOVE";
        });
    }

    /** Maps 2-D screen drag to world-space XZ translation via the camera axes,
     * matching the BallLauncher convention (camera right -> world right,
     * screen Y inverted -> world forward).
     */
    private simApplyTranslation(screenDelta: vec2): void {
        const camT    = this.simulatorCamera.getTransform();
        const right   = new vec3(camT.right.x,   0, camT.right.z  ).normalize();
        const forward = new vec3(camT.forward.x,  0, camT.forward.z).normalize();

        const worldDelta = right.uniformScale(screenDelta.x * this.simMoveScale)
            .add(forward.uniformScale(-screenDelta.y * this.simMoveScale));

        const current = this.levelTransform.getWorldPosition();
        this.levelTransform.setWorldPosition(current.add(worldDelta));
    }

    /**Maps horizontal screen drag to Y-axis rotation.
     * Vertical drag is intentionally ignored -> only one axis is allowed.
     */
    private simApplyRotationY(screenDelta: vec2): void {
        const angle      = screenDelta.x * this.simRotateScale;
        const yDelta     = quat.fromEulerAngles(0, angle, 0);
        const currentRot = this.levelTransform.getWorldRotation();
        this.levelTransform.setWorldRotation(yDelta.multiply(currentRot));
    }

    // ----- Hand Input Setup-----------------------

    private setupHandInput(): void {
        this._rightHand = SIK.HandInputData.getHand('right');
        this._leftHand  = SIK.HandInputData.getHand('left');

        this._rightHand.onPinchDown.add(() => {
            if (!this.toggleIsOn) return;
            this._rightPinching = true;
            if (this._leftPinching) {
                this.grabMode       = "ROTATE";
                this.lastHandsAngle = this.handsAngleXZ(
                    this._rightHand.indexTip.position as vec3,
                    this._leftHand.indexTip.position  as vec3
                );
            } else {
                this.grabMode       = "MOVE";
                this.lastRightPinch = this._rightHand.indexTip.position as vec3;
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
            if (!this.toggleIsOn) return;
            this._leftPinching = true;
            if (this._rightPinching) {
                this.grabMode       = "ROTATE";
                this.lastHandsAngle = this.handsAngleXZ(
                    this._rightHand.indexTip.position as vec3,
                    this._leftHand.indexTip.position  as vec3
                );
            }
            //Left hand doesn't work w/o right
        });

        this._leftHand.onPinchUp.add(() => {
            this._leftPinching = false;
            if (this._rightPinching && this.grabMode === "ROTATE") {
                this.grabMode       = "MOVE";
                this.lastRightPinch = this._rightHand.indexTip.position as vec3;
            }
        });

        this._leftHand.onHandLost.add(() => {
            this._leftPinching = false;
            if (this._rightPinching && this.grabMode === "ROTATE") {
                this.grabMode       = "MOVE";
                this.lastRightPinch = this._rightHand.indexTip.position as vec3;
            }
        });
    }

    // ---------------- Per-frame update (hand tracking) ---------------

    private onUpdate(): void {
        if (!this.toggleIsOn) return;

        // In simulator mode all interaction is event-driven (touch events above).
        // Nothing to do here per-frame.
        if (this.simulatorMode) return;

        // ------------ Hand tracking ----------------------

        if (this.grabMode === "MOVE" && this._rightPinching) {
            const rPos  = this._rightHand.indexTip.position as vec3;
            const delta = rPos.sub(this.lastRightPinch).uniformScale(this.moveSensitivity);
            this.levelTransform.setWorldPosition(this.levelTransform.getWorldPosition().add(delta));
            this.lastRightPinch = rPos;
        } else if (this.grabMode === "ROTATE" && this._rightPinching && this._leftPinching) {
            const rPos         = this._rightHand.indexTip.position as vec3;
            const lPos         = this._leftHand.indexTip.position  as vec3;
            const currentAngle = this.handsAngleXZ(rPos, lPos);
            const yDelta       = quat.fromEulerAngles(0, (this.lastHandsAngle - currentAngle) * this.rotateSensitivity, 0);
            this.levelTransform.setWorldRotation(yDelta.multiply(this.levelTransform.getWorldRotation()));
            this.lastHandsAngle = currentAngle;
        }
    }

    /** Angle (radians) of the right-to-left vector projected onto XZ-axis */
    private handsAngleXZ(right: vec3, left: vec3): number {
        return Math.atan2(right.z - left.z, right.x - left.x);
    }
}
