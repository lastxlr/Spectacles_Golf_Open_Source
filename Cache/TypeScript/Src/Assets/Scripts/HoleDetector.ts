/** Script in charge of detecting if the ball has got in hole.
 * Sends info to the Game Manager once hit is detected (to end the level)
 * Shall be assigned to a SceneObject with collider component (which shall be inside the hole)
 * 
 * The collision is detected by collisiong with the object with Body Component. Currently in the lens Ball is the only object with the Body Component
 */

@component
export class HoleDetector extends BaseScriptComponent {

    @input("Component.AudioComponent")
    @hint("Sound effect played when ball hits the hole")
    holeSound!: AudioComponent;

    @input("SceneObject")
    @hint("SceneObject with material with animated texture (animation is played once ball hits the hole)")
    holeVFXBox!: SceneObject;

    private holeCollider!: ColliderComponent;

    onAwake() {
        this.createEvent("OnStartEvent").bind(() => this.onStart());
    }

    private onStart() {
        this.holeCollider = this.sceneObject.getComponent("Physics.ColliderComponent") as ColliderComponent;
        
        this.holeVFXBox.enabled = false;

        this.holeCollider.onOverlapEnter.add((e) => {
            const otherBody = e.overlap.collider.sceneObject.getComponent("Physics.BodyComponent") as BodyComponent;
            if (!otherBody) return;

            if (!this.holeSound.isPlaying()) this.holeSound.play(1);

            this.playHoleVFX();
        });
    }

    private playHoleVFX() {
        const vfxMaterial = this.holeVFXBox.getComponent("Component.RenderMeshVisual").getMaterial(0)
        const anim = (vfxMaterial.mainPass.baseTex as any).control;
        const duration = anim.getDuration() as number;

        this.holeVFXBox.enabled = true;
        anim.play(1, 0);

        const endEvent = this.createEvent("DelayedCallbackEvent");
        endEvent.bind(() => {
            this.holeVFXBox.enabled = false;
            const gm = (global as any)["GameManager"];
            if (gm && typeof gm.onBallInHole === "function") {
                gm.onBallInHole();
            } else {
                print("GameManager not found");
            }
        });
        endEvent.reset(duration);
    }
}