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
// @input int maxShotsPerLevel = 6 {"hint":"Maximum nuber of shots allowed to make per level. If out of shots -> next level with 0 score received"}
// @input Component.ScriptComponent ballLauncherComponent {"hint":"BallLauncher script component from the scene"}
// @input Component.ScriptComponent levelManagerComponent {"hint":"LevelManager script component from the scene"}
// @input SceneObject uiHUD {"hint":"Level_Info board scene object"}
// @input Component.Text levelsText {"hint":"Text object from Level_Info board where level count is shown"}
// @input Component.Text shotsText {"hint":"Text object from Level_Info board where shots left are shown"}
// @input Component.Text scoreText {"hint":"Text object from Level_Info board where current total score is shown"}
// @input Component.AudioComponent outOfShotsSound {"hint":"Sound effect played when player run out of shots"}
// @input Component.ScriptComponent levelMoverComponent {"hint":"LevelManager script component from the scene"}
if (!global.BaseScriptComponent) {
    function BaseScriptComponent() {}
    global.BaseScriptComponent = BaseScriptComponent;
    global.BaseScriptComponent.prototype = Object.getPrototypeOf(script);
    global.BaseScriptComponent.prototype.__initialize = function () {};
    global.BaseScriptComponent.getTypeName = function () {
        throw new Error("Cannot get type name from the class, not decorated with @component");
    };
}
var Module = require("../../../../Modules/Src/Assets/Scripts/GameManager");
Object.setPrototypeOf(script, Module.GameManager.prototype);
script.__initialize();
let awakeEvent = script.createEvent("OnAwakeEvent");
awakeEvent.bind(() => {
    checkUndefined("maxShotsPerLevel", []);
    checkUndefined("ballLauncherComponent", []);
    checkUndefined("levelManagerComponent", []);
    checkUndefined("uiHUD", []);
    checkUndefined("levelsText", []);
    checkUndefined("shotsText", []);
    checkUndefined("scoreText", []);
    checkUndefined("outOfShotsSound", []);
    checkUndefined("levelMoverComponent", []);
    if (script.onAwake) {
       script.onAwake();
    }
});
