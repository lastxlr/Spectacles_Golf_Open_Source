if (script.onAwake) {
    script.onAwake();
    return;
}
function checkUndefined(property, showIfData) {
    for (var i = 0; i < showIfData.length; i++) {
        if (showIfData[i][0] && script[showIfData[i][0]] != showIfData[i][1]) {
            return;
        }
    }
    if (script[property] == undefined) {
        throw new Error("Input " + property + " was not provided for the object " + script.getSceneObject().name);
    }
}
// @input Asset.ObjectPrefab[] levelPrefabs = {} {"hint":"Prefabs of the levels. MUST be at least one, max count is not limited. IMPORTANT: Check REAMDE (child of LevelContainer)"}
// @input Component.ScriptComponent ballLauncherComponent {"hint":"ballLauncher script component from the scene. IMPORTANT: Check REAMDE (child of LevelContainer)"}
// @input SceneObject board {"hint":"Level_Info_Frame object from the scene. IMPORTANT: Check REAMDE (child of LevelContainer)"}
if (!global.BaseScriptComponent) {
    function BaseScriptComponent() {}
    global.BaseScriptComponent = BaseScriptComponent;
    global.BaseScriptComponent.prototype = Object.getPrototypeOf(script);
    global.BaseScriptComponent.prototype.__initialize = function () {};
    global.BaseScriptComponent.getTypeName = function () {
        throw new Error("Cannot get type name from the class, not decorated with @component");
    };
}
var Module = require("../../../../Modules/Src/Assets/Scripts/LevelManager");
Object.setPrototypeOf(script, Module.LevelManager.prototype);
script.__initialize();
let awakeEvent = script.createEvent("OnAwakeEvent");
awakeEvent.bind(() => {
    checkUndefined("levelPrefabs", []);
    checkUndefined("ballLauncherComponent", []);
    checkUndefined("board", []);
    if (script.onAwake) {
       script.onAwake();
    }
});
