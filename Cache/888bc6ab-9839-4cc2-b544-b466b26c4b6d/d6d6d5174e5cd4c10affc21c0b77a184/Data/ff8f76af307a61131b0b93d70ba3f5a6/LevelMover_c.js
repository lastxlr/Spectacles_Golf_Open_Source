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
// @input Component.ScriptComponent toggleButton {"hint":"Button script component of the toggle button from the scene"}
// @input Component.ScriptComponent ballLauncherComponent {"hint":"BallLauncher script component from the scene"}
// @input Component.ScriptComponent levelManagerComponent {"hint":"LevelManager script component from the scene"}
// @input SceneObject ballObject {"hint":"Ball object script component from the scene"}
// @input SceneObject levelRoot {"hint":"Root of the leve (Level_Container). This object is moved and rotated with this script"}
// @input SceneObject grabCube {"hint":"Grab cube object: the area around the level which player uses to move-rotate level"}
// @input SceneObject instructionLabel {"hint":"Instruction object from the scene. Appears when toggle is on"}
// @input float moveSensitivity = 1 {"hint":"Sensitivity for translating player's hand movement to amount of level move"}
// @input float rotateSensitivity = 1 {"hint":"Sensitivity for translating player's hands movement to amount of level rotate"}
// @input boolean simulatorMode {"hint":"Enables testing the level in Lens Studio preview with mouse"}
// @input Component.Camera simulatorCamera {"hint":"Camera object from which mouse movement on screen is translated to moving/rotating level", "showIf":"simulatorMode"}
// @input float simMoveScale = 80 {"hint":"Sensitivity for translating mouse movement to amount of level move. First touch used to move, next to rotate, etc", "showIf":"simulatorMode"}
// @input float simRotateScale = 6 {"hint":"Sensitivity for translating mouse movement to amount of level rotate. First touch used to move, next to rotate, etc", "showIf":"simulatorMode"}
if (!global.BaseScriptComponent) {
    function BaseScriptComponent() {}
    global.BaseScriptComponent = BaseScriptComponent;
    global.BaseScriptComponent.prototype = Object.getPrototypeOf(script);
    global.BaseScriptComponent.prototype.__initialize = function () {};
    global.BaseScriptComponent.getTypeName = function () {
        throw new Error("Cannot get type name from the class, not decorated with @component");
    };
}
var Module = require("../../../../Modules/Src/Assets/Scripts/LevelMover");
Object.setPrototypeOf(script, Module.LevelMover.prototype);
script.__initialize();
let awakeEvent = script.createEvent("OnAwakeEvent");
awakeEvent.bind(() => {
    checkUndefined("toggleButton", []);
    checkUndefined("ballLauncherComponent", []);
    checkUndefined("levelManagerComponent", []);
    checkUndefined("ballObject", []);
    checkUndefined("levelRoot", []);
    checkUndefined("grabCube", []);
    checkUndefined("instructionLabel", []);
    checkUndefined("moveSensitivity", []);
    checkUndefined("rotateSensitivity", []);
    checkUndefined("simulatorMode", []);
    checkUndefined("simulatorCamera", [["simulatorMode",true]]);
    checkUndefined("simMoveScale", [["simulatorMode",true]]);
    checkUndefined("simRotateScale", [["simulatorMode",true]]);
    if (script.onAwake) {
       script.onAwake();
    }
});
