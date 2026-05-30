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
exports.GameManager = void 0;
var __selfType = requireType("./GameManager");
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
/**Game Manager controls the game states.
 * Tracks current shots count, level count, level switches, launches UI when level is finished
 * and updates UI texts depending on the score and last/non-last level
 */
let GameManager = (() => {
    let _classDecorators = [component];
    let _classDescriptor;
    let _classExtraInitializers = [];
    let _classThis;
    let _classSuper = BaseScriptComponent;
    var GameManager = _classThis = class extends _classSuper {
        constructor() {
            super();
            this.maxShotsPerLevel = this.maxShotsPerLevel;
            this.ballLauncherComponent = this.ballLauncherComponent;
            this.levelManagerComponent = this.levelManagerComponent;
            this.uiHUD = this.uiHUD;
            this.levelsText = this.levelsText;
            this.shotsText = this.shotsText;
            this.scoreText = this.scoreText;
            this.outOfShotsSound = this.outOfShotsSound;
            this.levelMoverComponent = this.levelMoverComponent;
            this.currentLevel = 0;
            this.shotsOnCurrentLevel = 1;
            this.totalScore = 0;
            this.scorePerLevel = [];
            this.state = "PLAYING";
            this.pendingShot = false;
        }
        __initialize() {
            super.__initialize();
            this.maxShotsPerLevel = this.maxShotsPerLevel;
            this.ballLauncherComponent = this.ballLauncherComponent;
            this.levelManagerComponent = this.levelManagerComponent;
            this.uiHUD = this.uiHUD;
            this.levelsText = this.levelsText;
            this.shotsText = this.shotsText;
            this.scoreText = this.scoreText;
            this.outOfShotsSound = this.outOfShotsSound;
            this.levelMoverComponent = this.levelMoverComponent;
            this.currentLevel = 0;
            this.shotsOnCurrentLevel = 1;
            this.totalScore = 0;
            this.scorePerLevel = [];
            this.state = "PLAYING";
            this.pendingShot = false;
        }
        onAwake() {
            global["GameManager"] = this;
            this.createEvent("OnStartEvent").bind(() => this.onStart());
        }
        onStart() {
            this.startLevel(0);
        }
        getTotalLevels() {
            return this.levelManagerComponent.getTotalLevels();
        }
        onShotStarted() {
            if (this.state !== "PLAYING")
                return;
            this.pendingShot = true;
        }
        /**Updates data after the ball is stopped and triggers game over if it was the last possible shot */
        onBallStopped() {
            if (this.state !== "PLAYING")
                return;
            if (!this.pendingShot)
                return;
            this.pendingShot = false;
            this.shotsOnCurrentLevel++;
            this.updateHUD();
            if (this.shotsOnCurrentLevel > this.maxShotsPerLevel) {
                this.ballLauncherComponent.setInputBlocked(true);
                this.triggerGameOver();
                if (!this.outOfShotsSound.isPlaying())
                    this.outOfShotsSound.play(1);
            }
        }
        /**Handles the event of ball hitting the hole. Calculates level score, updates variables, launches UI between levels */
        onBallInHole() {
            if (this.state !== "PLAYING")
                return;
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
            const ui = global["GameUI"];
            if (ui) {
                ui.showPanel(isLastLevel ? "GAME_OVER" : "BETWEEN_LEVELS", levelScore, this.totalScore, this.shotsOnCurrentLevel, isLastLevel);
            }
            this.uiHUD.enabled = false;
        }
        /** Updates values when ball hit out of bounds and triggers game over if it was the last possible shot */
        onBallOutOfBounds() {
            if (this.state !== "PLAYING")
                return;
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
        onNextLevelPressed() {
            const isLastLevel = this.currentLevel >= this.getTotalLevels() - 1;
            if (isLastLevel) {
                this.onRestartPressed();
            }
            else {
                this.startLevel(this.currentLevel + 1);
            }
        }
        onRestartPressed() {
            this.totalScore = 0;
            this.scorePerLevel = [];
            this.startLevel(0);
        }
        triggerGameOver() {
            this.state = "BALL_IN_HOLE";
            this.levelMoverComponent.onLevelEnded();
            const isLastLevel = this.currentLevel >= this.getTotalLevels() - 1;
            const ui = global["GameUI"];
            if (ui) {
                ui.showPanel("OUT_OF_SHOTS", 0, this.totalScore, this.shotsOnCurrentLevel, isLastLevel);
            }
            this.uiHUD.enabled = false;
        }
        startLevel(index) {
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
        calculateLevelScore() {
            return Math.max(0, (this.maxShotsPerLevel - this.shotsOnCurrentLevel + 2) * 10);
        }
        updateHUD() {
            this.levelsText.text = "LEVEL: " + (this.currentLevel + 1) + "/" + this.getTotalLevels();
            this.shotsText.text = "SHOT: " + this.shotsOnCurrentLevel + "/" + this.maxShotsPerLevel;
            this.scoreText.text = "SCORE: " + this.totalScore;
        }
    };
    __setFunctionName(_classThis, "GameManager");
    (() => {
        const _metadata = typeof Symbol === "function" && Symbol.metadata ? Object.create(_classSuper[Symbol.metadata] ?? null) : void 0;
        __esDecorate(null, _classDescriptor = { value: _classThis }, _classDecorators, { kind: "class", name: _classThis.name, metadata: _metadata }, null, _classExtraInitializers);
        GameManager = _classThis = _classDescriptor.value;
        if (_metadata) Object.defineProperty(_classThis, Symbol.metadata, { enumerable: true, configurable: true, writable: true, value: _metadata });
        __runInitializers(_classThis, _classExtraInitializers);
    })();
    return GameManager = _classThis;
})();
exports.GameManager = GameManager;
//# sourceMappingURL=GameManager.js.map