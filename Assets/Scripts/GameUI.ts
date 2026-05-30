/** Script in charge of showing the UI between levels.
 * Controls the UI animation, data update (current score, total score, if-else last level) and "next" button tap.
 * Pretty straightforward
 */

import { CapsuleButton } from 'SpectaclesUIKit.lspkg/Scripts/Components/Button/CapsuleButton';

@component
export class GameUI extends BaseScriptComponent {

    @input("SceneObject")
    @hint("Root object of the UI panel")
    panelRoot!: SceneObject;

    @input("Component.Text")
    @hint("Text component of the field where 'after-level' message will be shown")
    messageText!: Text;

    @input("Component.Text")
    @hint("Text component of the field where 'after-level' current level score will be shown")
    levelScoreText!: Text;

    @input("Component.Text")
    @hint("Text component of the field where 'after-level' current score will be shown")
    totalScoreText!: Text;

    @input("Component.Text")
    @hint("Text component of the 'Next Level/Play Again' button")
    buttonText!: Text;

    @input("SceneObject")
    @hint("'Next Level/Play Again' button")
    buttonObject!: SceneObject;

    @input("Component.AudioComponent")
    @hint("Sound effect played when 'Next Level/Play Again' button is tapped")
    buttonSound!: AudioComponent;

    @input("float")
    @hint("The board will be still shown for this amount of seconds after 'Next Level/Play Again' button is tapped")
    dismissDelay: number = 0.4;

    @input("float")
    @hint("Speed of revealing/hiding the UI")
    animSpeed: number = 8.0;

    private panelTransform!: Transform;
    private baseScale!: vec3;
    private currentScale: number = 0;
    private targetScale: number = 0;
    private animState: "IDLE" | "SHOWING" | "HIDING" = "IDLE";
    private buttonLocked: boolean = false;

    private readonly OVERSHOOT = 1.1;

    onAwake() {
        (global as any)["GameUI"] = this;
        
        this.createEvent("OnStartEvent").bind(() => this.onStart());
        this.createEvent("UpdateEvent").bind(() => this.onUpdate());
    }

    private onStart() {
        this.panelTransform = this.panelRoot.getTransform();
        this.baseScale = this.panelTransform.getLocalScale();
        this.panelTransform.setLocalScale(vec3.zero());
        this.panelRoot.enabled = false;

        const capsuleButton = this.buttonObject.getComponent(
            CapsuleButton.getTypeName()
        ) as CapsuleButton;

        if (capsuleButton) {
            capsuleButton.onTriggerUp.add(() => {
                if (this.buttonLocked) return;
                    this.onButtonPressed();
                });
        } else {
            print("GameUI: CapsuleButton not found");
        }
    }

    public showPanel(
        type: "BETWEEN_LEVELS" | "GAME_OVER" | "OUT_OF_SHOTS",
        levelScore: number,
        totalScore: number,
        shots: number,
        isLastLevel: boolean
    ) {
        this.levelScoreText.text = "LEVEL SCORE: +" + levelScore;
        this.totalScoreText.text = "TOTAL SCORE: " + totalScore;
        this.buttonText.text = isLastLevel ? "Play Again" : "Next Level";

        if (type === "GAME_OVER") {
            this.messageText.text = "GAME OVER";
        } else if (type === "OUT_OF_SHOTS") {
            this.messageText.text = "OUT OF SHOTS";
        } else if (shots === 1) {
            this.messageText.text = "HOLE IN ONE!";
        } else if (shots <= 3) {
            this.messageText.text = "GREAT SHOT!";
        } else {
            this.messageText.text = "LEVEL COMPLETE";
        };

        this.buttonLocked = false;

        this.currentScale = 0;
        this.targetScale = this.OVERSHOOT;
        this.panelRoot.enabled = true;
        this.animState = "SHOWING";
    }

    private onButtonPressed() {
        if (this.buttonLocked) return;
        this.buttonLocked = true;

        if (!this.buttonSound.isPlaying()) this.buttonSound.play(1);

        const delay = this.createEvent("DelayedCallbackEvent");
        delay.bind(() => {
            this.animState = "HIDING";
            this.targetScale = 0;
        });
        delay.reset(this.dismissDelay);
    }

    private onDismissComplete() {
        this.panelRoot.enabled = false;
        this.animState = "IDLE";

        const gm = (global as any)["GameManager"];
        if (gm && typeof gm.onNextLevelPressed === "function") {
            gm.onNextLevelPressed();
        }
    }

    private onUpdate() {
        if (this.animState === "IDLE") return;

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

        this.panelTransform.setLocalScale(
            new vec3(
                this.baseScale.x * this.currentScale,
                this.baseScale.y * this.currentScale,
                this.baseScale.z * this.currentScale
            )
        );
    }
}