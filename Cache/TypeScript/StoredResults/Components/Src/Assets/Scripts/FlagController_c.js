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
// @input float lerpSpeed = 3 {"hint":"Speed of lowering-raising the flag"}
// @input float loweredY {"hint":"Y-position of the lowered flag"}
// @input float raisedY = 30 {"hint":"Y-position of the raised flag"}
// @input float lerpThreshold = 0.1 {"hint":"Distance to the raised/loweredY after which lerp is stopped (helps with the speed)"}
// @input Component.ColliderComponent triggerCollider {"hint":"Collider component (intangible) of the trigger area. Basically box around the flag by entering which the flag is raised"}
if (!global.BaseScriptComponent) {
    function BaseScriptComponent() {}
    global.BaseScriptComponent = BaseScriptComponent;
    global.BaseScriptComponent.prototype = Object.getPrototypeOf(script);
    global.BaseScriptComponent.prototype.__initialize = function () {};
    global.BaseScriptComponent.getTypeName = function () {
        throw new Error("Cannot get type name from the class, not decorated with @component");
    };
}
var Module = require("../../../../Modules/Src/Assets/Scripts/FlagController");
Object.setPrototypeOf(script, Module.FlagController.prototype);
script.__initialize();
let awakeEvent = script.createEvent("OnAwakeEvent");
awakeEvent.bind(() => {
    checkUndefined("lerpSpeed", []);
    checkUndefined("loweredY", []);
    checkUndefined("raisedY", []);
    checkUndefined("lerpThreshold", []);
    checkUndefined("triggerCollider", []);
    if (script.onAwake) {
       script.onAwake();
    }
});
