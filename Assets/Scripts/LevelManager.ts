/**Script in charge of instantiating and destroying the levels during the game
 * The game MUST have at least one level to work
 */

@component
export class LevelManager extends BaseScriptComponent {

    @input
    @hint("Prefabs of the levels. MUST be at least one, max count is not limited. IMPORTANT: Check REAMDE (child of LevelContainer)")
    levelPrefabs: ObjectPrefab[] = [];

    @input("Component.ScriptComponent")
    @hint("ballLauncher script component from the scene. IMPORTANT: Check REAMDE (child of LevelContainer)")
    ballLauncherComponent!: any;

    @input("SceneObject")
    @hint('Level_Info_Frame object from the scene. IMPORTANT: Check REAMDE (child of LevelContainer)')
    board!: SceneObject;

    private currentLevelObject: SceneObject | null = null;

    onAwake() {
        (global as any)["LevelManager"] = this; 
    }

    public getTotalLevels(): number {
        return this.levelPrefabs.length;
    };

    public loadLevel(index: number) {
        // Destroy current lvl if any
        if (this.currentLevelObject) {
            this.currentLevelObject.destroy();
            this.currentLevelObject = null;
        }

        if (index >= this.levelPrefabs.length) {
            print("LevelManager: level index out of range: " + index);
            return;
        }

        // Spawn new lvl
        this.currentLevelObject = this.levelPrefabs[index].instantiate(
            this.sceneObject
        );

        // Find starting poing and put a ball there
        const startPoint = this.currentLevelObject.getChild(0);
        const boardPosition = this.currentLevelObject.getChild(1).getTransform().getWorldPosition();
        if (startPoint) {
            this.ballLauncherComponent.resetBall(
                startPoint.getTransform().getWorldPosition()
            );
            this.board.getTransform().setWorldPosition(boardPosition);
        } else {
            print("LevelManager: StartPoint not found in level " + index);
        }
    }

    /**Method used to place a board on a board position of the level.
     * Launched at level start and after the level was moved/rotated.
     */
    public syncBoardPosition(): void {
        if (!this.currentLevelObject) return;
        const boardPoint = this.currentLevelObject.getChild(1);
        if (boardPoint) {
            this.board.getTransform().setWorldPosition(
                boardPoint.getTransform().getWorldPosition()
            );
        }
    }
}