/** Script in charge of controlling if the ball hits the trap on the level
 * Put it on your trap object in the level prefab. Trap MUST have a Collider Component on it for the script to work.
 * Once the ball hits trap's collider, triggerOutOfBounds function is called from the main BallLauncher script
 * 
 * The collision is detected by collisiong with the object with Body Component. Currently in the lens Ball is the only object with the Body Component.
 */

@component
export class LevelTraps extends BaseScriptComponent {

    private trapCollider!: ColliderComponent;

    onAwake() {
        this.createEvent("OnStartEvent").bind(() => {
            this.trapCollider = this.sceneObject.getComponent(
                "Physics.ColliderComponent"
            ) as ColliderComponent;

            this.trapCollider.onOverlapEnter.add((e) => {
                const body = e.overlap.collider.sceneObject.getComponent(
                    "Physics.BodyComponent"
                ) as BodyComponent;
                if (!body) return;

                const scripts = e.overlap.collider.sceneObject.getComponents(
                    "Component.ScriptComponent"
                ) as any[];
                const bl = scripts.find(
                    s => typeof s.triggerOutOfBounds === "function"
                );
                if (bl) bl.triggerOutOfBounds();
            });
        });
    }
}