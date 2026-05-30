/**Script in charge of showing blinking cylinder object on top of the ball (helps player to see where the ball currently is)
 * Also shows hand hint at start and destroys it after first hit
 */
@component
export class BallIndicator extends BaseScriptComponent {

    //Used to check the state, so the indicator is showed only when the ball state is IDLE
    @input("Component.ScriptComponent")
    @hint("BallLauncher script component from the scene")
    ballLauncher!: ScriptComponent;

    //Used to get world position and move the indicator there
    @input("SceneObject")
    @hint('Ball scene object')
    ballObject!: SceneObject;

    @input("float")
    @hint('Y-axis offset of the indicator - try different values to move indicator higher/lower')
    yOffset: number = 220;

    @input('vec4', '{1, 1, 1, 1}')
    @widget(new ColorWidget())
    indicatorColor!: vec4

    @input("float")
    @hint("Minimum value of the opacity for the blinking animation")
    alphaMin: number = 0;

    @input("float")
    @hint("Maximum value of the opacity for the blinking animation")
    alphaMax: number = 0.75;

    @input("float")
    @hint("Speed of the indicator blinking")
    alphaSpeed: number = 0.75;

    @input("SceneObject")
    @hint("Hand hint object (to destroy it after first hit)")
    handHint!: SceneObject;

    private _mat!: Material;
    private _alpha: number = 0;
    private _alphaDir: number = 1;
    private _isAnimating: boolean = false;
    private _hintDestroyed: boolean = false;

    onAwake() {
        this.createEvent("OnStartEvent").bind(() => this.onStart());
        this.createEvent("UpdateEvent").bind(() => this.onUpdate());
    }

    private onStart() {
        this.handHint.enabled = false;
        const visual = this.sceneObject.getComponent('Component.RenderMeshVisual') as RenderMeshVisual;
        this._mat = visual.mainMaterial;
        this.sceneObject.enabled = false;

        // For performance the ball state is not checked every frame, but the callback event is sent each time state has changed
        // If state is IDLE -> show indicator
        const launcher = this.ballLauncher as any;
        launcher.onStateChanged = (s: string) => {
            if (s === "IDLE") {
                const bp = this.ballObject.getTransform().getWorldPosition();
                this.sceneObject.getTransform().setWorldPosition(new vec3(bp.x, bp.y + this.yOffset, bp.z));
                this._alpha = this.alphaMin;
                this._alphaDir = 1;
                (this._mat as any).mainPass.baseColor = new vec4(1, 0.329412, 0.419608, 0);
                this.sceneObject.enabled = true;
                this._isAnimating = true;

                if (!this._hintDestroyed) {
                    this.handHint.enabled = true;
                }
            } else if (s === "AIMING") {
                this.sceneObject.enabled = false;
                this._isAnimating = false;
                if (!this._hintDestroyed) {
                    this.handHint.destroy();
                    this._hintDestroyed = true;
                }
            } else {
                this.sceneObject.enabled = false;
                this._isAnimating = false;
            }
        };
    }

    private onUpdate() {
        if (!this._isAnimating) return;

        this._alpha += this._alphaDir * this.alphaSpeed * getDeltaTime();
        if (this._alpha >= this.alphaMax) {
            this._alpha = this.alphaMax;
            this._alphaDir = -1;
        } else if (this._alpha <= this.alphaMin) {
            this._alpha = this.alphaMin;
            this._alphaDir = 1;
        }
            (this._mat as any).mainPass.baseColor = new vec4(this.indicatorColor.x, this.indicatorColor.y, this.indicatorColor.z, this._alpha);
        }
}