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
exports.LevelManager = void 0;
var __selfType = requireType("./LevelManager");
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
/**Script in charge of instantiating and destroying the levels during the game
 * The game MUST have at least one level to work
 */
let LevelManager = (() => {
    let _classDecorators = [component];
    let _classDescriptor;
    let _classExtraInitializers = [];
    let _classThis;
    let _classSuper = BaseScriptComponent;
    var LevelManager = _classThis = class extends _classSuper {
        constructor() {
            super();
            this.levelPrefabs = this.levelPrefabs;
            this.ballLauncherComponent = this.ballLauncherComponent;
            this.board = this.board;
            this.currentLevelObject = null;
        }
        __initialize() {
            super.__initialize();
            this.levelPrefabs = this.levelPrefabs;
            this.ballLauncherComponent = this.ballLauncherComponent;
            this.board = this.board;
            this.currentLevelObject = null;
        }
        onAwake() {
            global["LevelManager"] = this;
        }
        getTotalLevels() {
            return this.levelPrefabs.length;
        }
        ;
        loadLevel(index) {
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
            this.currentLevelObject = this.levelPrefabs[index].instantiate(this.sceneObject);
            // Find starting poing and put a ball there
            const startPoint = this.currentLevelObject.getChild(0);
            const boardPosition = this.currentLevelObject.getChild(1).getTransform().getWorldPosition();
            if (startPoint) {
                this.ballLauncherComponent.resetBall(startPoint.getTransform().getWorldPosition());
                this.board.getTransform().setWorldPosition(boardPosition);
            }
            else {
                print("LevelManager: StartPoint not found in level " + index);
            }
        }
        /**Method used to place a board on a board position of the level.
         * Launched at level start and after the level was moved/rotated.
         */
        syncBoardPosition() {
            if (!this.currentLevelObject)
                return;
            const boardPoint = this.currentLevelObject.getChild(1);
            if (boardPoint) {
                this.board.getTransform().setWorldPosition(boardPoint.getTransform().getWorldPosition());
            }
        }
    };
    __setFunctionName(_classThis, "LevelManager");
    (() => {
        const _metadata = typeof Symbol === "function" && Symbol.metadata ? Object.create(_classSuper[Symbol.metadata] ?? null) : void 0;
        __esDecorate(null, _classDescriptor = { value: _classThis }, _classDecorators, { kind: "class", name: _classThis.name, metadata: _metadata }, null, _classExtraInitializers);
        LevelManager = _classThis = _classDescriptor.value;
        if (_metadata) Object.defineProperty(_classThis, Symbol.metadata, { enumerable: true, configurable: true, writable: true, value: _metadata });
        __runInitializers(_classThis, _classExtraInitializers);
    })();
    return LevelManager = _classThis;
})();
exports.LevelManager = LevelManager;
//# sourceMappingURL=LevelManager.js.map