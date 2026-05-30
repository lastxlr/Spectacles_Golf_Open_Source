/**Script in charge of raising the flag once the ball enters flag collider. Not important and can be skipped. 
 * Just helps with the visuals, but if used must be attached to the flag object with Y-axis as up axis.
 * Flag is raised with the basic lerp
 */

@component
export class FlagController extends BaseScriptComponent {

    @input("float")
    @hint("Speed of lowering-raising the flag")
    lerpSpeed: number = 3.0;

    @input("float")
    @hint("Y-position of the lowered flag")
    loweredY: number = 0.0;

    @input("float")
    @hint("Y-position of the raised flag")
    raisedY: number = 30.0;

    @input("float")
    @hint("Distance to the raised/loweredY after which lerp is stopped (helps with the speed)")
    lerpThreshold: number = 0.1;

    @input("Component.ColliderComponent")
    @hint("Collider component (intangible) of the trigger area. Basically box around the flag by entering which the flag is raised")
    triggerCollider!: ColliderComponent;

    private flagTransform!: Transform;
    private currentY: number = 0.0;
    private targetY: number = 0.0;
    private isMoving: boolean = false;

    onAwake() {
        this.createEvent("OnStartEvent").bind(() => this.onStart());
        this.createEvent("UpdateEvent").bind(() => this.onUpdate());
    }

    private onStart() {
        this.flagTransform = this.sceneObject.getTransform();
        this.currentY = this.loweredY;
        this.targetY = this.loweredY;
        const localPos = this.flagTransform.getLocalPosition();
        this.flagTransform.setLocalPosition(new vec3(localPos.x, this.currentY, localPos.z));


        // Event when ball enters trigger area (used to raise the flag)
        this.triggerCollider.onOverlapEnter.add((e) => {
            const otherBody = e.overlap.collider.sceneObject.getComponent("Physics.BodyComponent") as BodyComponent;
            if (!otherBody) return;
            this.targetY = this.raisedY;
            this.isMoving = true;
        });

        // Event when ball exits trigger area (used to lower the flag)
        this.triggerCollider.onOverlapExit.add((e) => {
            const otherBody = e.overlap.collider.sceneObject.getComponent("Physics.BodyComponent") as BodyComponent;
            if (!otherBody) return;
            this.targetY = this.loweredY;
            this.isMoving = true;
        });
    }

    private onUpdate() {
        if (!this.isMoving) return;

        const dt = getDeltaTime();
        this.currentY += (this.targetY - this.currentY) * this.lerpSpeed * dt;

        if (this.targetY === this.raisedY && this.currentY > this.raisedY - this.lerpThreshold) {
            this.currentY = this.raisedY;
            this.isMoving = false;
        } else if (this.targetY === this.loweredY && this.currentY < this.loweredY + this.lerpThreshold) {
            this.currentY = this.loweredY;
            this.isMoving = false;
        }

        const localPos = this.flagTransform.getLocalPosition();
        this.flagTransform.setLocalPosition(new vec3(localPos.x, this.currentY, localPos.z));

    }
}