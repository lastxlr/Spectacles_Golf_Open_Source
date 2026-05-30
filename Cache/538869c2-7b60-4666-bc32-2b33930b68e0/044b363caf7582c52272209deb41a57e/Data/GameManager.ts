/**Game Manager controls the game states.
 * Tracks current shots count, level count, level switches, launches UI when level is finished
 * and updates UI texts depending on the score and last/non-last level
 */
@component
export class GameManager extends BaseScriptComponent {

    @input("int")
    @hint("Maximum nuber of shots allowed to make per level. If out of shots -> next level with 0 score received")
    maxShotsPerLevel: number = 6;

    @input("Component.ScriptComponent")
    @hint("BallLauncher script component from the scene")
    ballLauncherComponent!: any;

    @input("Component.ScriptComponent")
    @hint("LevelManager script component from the scene")
    levelManagerComponent!: any;

    @input("SceneObject")
    @hint("Level_Info board scene object")
    uiHUD!: SceneObject;

    @input("Component.Text")
    @hint("Text object from Level_Info board where level count is shown")
    levelsText!: Text;

    @input("Component.Text")
    @hint("Text object from Level_Info board where shots left are shown")
    shotsText!: Text;

    @input("Component.Text")
    @hint("Text object from Level_Info board where current total score is shown")
    scoreText!: Text;

    @input("Component.AudioComponent")
    @hint("Sound effect played when player run out of shots")
    outOfShotsSound!: AudioComponent;

    @input("Component.ScriptComponent")
    @hint("LevelManager script component from the scene")
    levelMoverComponent!: any;

    private currentLevel: number = 0;
    private shotsOnCurrentLevel: number = 1;
    private totalScore: number = 0;
    private scorePerLevel: number[] = [];
    private state: "PLAYING" | "BALL_IN_HOLE" | "GAME_OVER" = "PLAYING";
    private pendingShot: boolean = false;

    onAwake() {

        (global as any)["GameManager"] = this;
        
        this.createEvent("OnStartEvent").bind(() => this.onStart());
    }

    private onStart() {
        this.startLevel(0);
    }

    private getTotalLevels(): number {
        return this.levelManagerComponent.getTotalLevels();
    }

    public onShotStarted() {
        if (this.state !== "PLAYING") return;
        this.pendingShot = true;
    }

    /**Updates data after the ball is stopped and triggers game over if it was the last possible shot */
    public onBallStopped() {
        if (this.state !== "PLAYING") return;
        if (!this.pendingShot) return;

        this.pendingShot = false;
        this.shotsOnCurrentLevel++;
        this.updateHUD();

        if (this.shotsOnCurrentLevel > this.maxShotsPerLevel) {
            this.ballLauncherComponent.setInputBlocked(true);
            this.triggerGameOver();
            if (!this.outOfShotsSound.isPlaying()) this.outOfShotsSound.play(1);
        }
    }

    /**Handles the event of ball hitting the hole. Calculates level score, updates variables, launches UI between levels */
    public onBallInHole() {
        if (this.state !== "PLAYING") return;

        if (this.pendingShot) {
            this.pendingShot = false;
            this.shotsOnCurrentLevel++;
        }

        this.state = "BALL_IN_HOLE";
        this.levelMoverComponent.onLevelEnded();
        this.ballLauncherComponent.setInputBlocked(true);

        const levelScore = this.calculateLevelScore();
        this.scorePerLevel.push(levelScore);
        this.totalScore += levelScore;

        const isLastLevel = this.currentLevel >= this.getTotalLevels() - 1;

        const ui = (global as any)["GameUI"];
        if (ui) {
            ui.showPanel(
                isLastLevel ? "GAME_OVER" : "BETWEEN_LEVELS",
                levelScore,
                this.totalScore,
                this.shotsOnCurrentLevel,
                isLastLevel
            );
        }

        this.uiHUD.enabled = false;

    }

    /** Updates values when ball hit out of bounds and triggers game over if it was the last possible shot */
    public onBallOutOfBounds() {
        if (this.state !== "PLAYING") return;

        if (this.pendingShot) {
            this.pendingShot = false;
            this.shotsOnCurrentLevel++;
            this.updateHUD();

            if (this.shotsOnCurrentLevel > this.maxShotsPerLevel) {
                this.ballLauncherComponent.setInputBlocked(true);
                this.triggerGameOver();
                return;
            }
        }
    }

    public onNextLevelPressed() {
        const isLastLevel = this.currentLevel >= this.getTotalLevels() - 1;
        if (isLastLevel) {
            this.onRestartPressed();
        } else {
            this.startLevel(this.currentLevel + 1);
        }
    }

    public onRestartPressed() {
        this.totalScore = 0;
        this.scorePerLevel = [];
        this.startLevel(0);
    }

    private triggerGameOver() {
        this.state = "BALL_IN_HOLE";

        this.levelMoverComponent.onLevelEnded();

        const isLastLevel = this.currentLevel >= this.getTotalLevels() - 1;

        const ui = (global as any)["GameUI"];
        if (ui) {
            ui.showPanel(
                "OUT_OF_SHOTS",
                0,
                this.totalScore,
                this.shotsOnCurrentLevel,
                isLastLevel
            );
        }

        this.uiHUD.enabled = false;
    }

    public startLevel(index: number) {
        this.currentLevel = index;
        this.shotsOnCurrentLevel = 1;
        this.pendingShot = false;
        this.state = "PLAYING";
        this.levelMoverComponent.onLevelStarted();
        
        this.ballLauncherComponent.setInputBlocked(false);
        this.levelManagerComponent.loadLevel(index);

        this.uiHUD.enabled = true;
        this.updateHUD();
    }

    private calculateLevelScore(): number {
        return Math.max(0, (this.maxShotsPerLevel - this.shotsOnCurrentLevel + 2) * 10);
    }

    private updateHUD() {
        this.levelsText.text = "LEVEL: " + (this.currentLevel + 1) + "/" + this.getTotalLevels();
        this.shotsText.text = "SHOT: " + this.shotsOnCurrentLevel + "/" + this.maxShotsPerLevel;
        this.scoreText.text = "SCORE: " + this.totalScore;
    }
}