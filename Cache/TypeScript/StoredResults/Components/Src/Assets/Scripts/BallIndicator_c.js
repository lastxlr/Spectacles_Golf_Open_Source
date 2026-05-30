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
// @input Component.ScriptComponent ballLauncher {"hint":"BallLauncher script component from the scene"}
// @input SceneObject ballObject {"hint":"Ball scene object"}
// @input float yOffset = 220 {"hint":"Y-axis offset of the indicator - try different values to move indicator higher/lower"}
// @input vec4 indicatorColor = "{1, 1, 1, 1}" {"widget":"color"}
// @input float alphaMin {"hint":"Minimum value of the opacity for the blinking animation"}
// @input float alphaMax = 0.75 {"hint":"Maximum value of the opacity for the blinking animation"}
// @input float alphaSpeed = 0.75 {"hint":"Speed of the indicator blinking"}
// @input SceneObject handHint {"hint":"Hand hint object (to destroy it after first hit)"}
if (!global.BaseScriptComponent) {
    function BaseScriptComponent() {}
    global.BaseScriptComponent = BaseScriptComponent;
    global.BaseScriptComponent.prototype = Object.getPrototypeOf(script);
    global.BaseScriptComponent.prototype.__initialize = function () {};
    global.BaseScriptComponent.getTypeName = function () {
        throw new Error("Cannot get type name from the class, not decorated with @component");
    };
}
var Module = require("../../../../Modules/Src/Assets/Scripts/BallIndicator");
Object.setPrototypeOf(script, Module.BallIndicator.prototype);
script.__initialize();
let awakeEvent = script.createEvent("OnAwakeEvent");
awakeEvent.bind(() => {
    checkUndefined("ballLauncher", []);
    checkUndefined("ballObject", []);
    checkUndefined("yOffset", []);
    checkUndefined("indicatorColor", []);
    checkUndefined("alphaMin", []);
    checkUndefined("alphaMax", []);
    checkUndefined("alphaSpeed", []);
    checkUndefined("handHint", []);
    if (script.onAwake) {
       script.onAwake();
    }
});
