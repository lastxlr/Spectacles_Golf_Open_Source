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
// @input SceneObject panelRoot {"hint":"Root object of the UI panel"}
// @input Component.Text messageText {"hint":"Text component of the field where 'after-level' message will be shown"}
// @input Component.Text levelScoreText {"hint":"Text component of the field where 'after-level' current level score will be shown"}
// @input Component.Text totalScoreText {"hint":"Text component of the field where 'after-level' current score will be shown"}
// @input Component.Text buttonText {"hint":"Text component of the 'Next Level/Play Again' button"}
// @input SceneObject buttonObject {"hint":"'Next Level/Play Again' button"}
// @input Component.AudioComponent buttonSound {"hint":"Sound effect played when 'Next Level/Play Again' button is tapped"}
// @input float dismissDelay = 0.4 {"hint":"The board will be still shown for this amount of seconds after 'Next Level/Play Again' button is tapped"}
// @input float animSpeed = 8 {"hint":"Speed of revealing/hiding the UI"}
if (!global.BaseScriptComponent) {
    function BaseScriptComponent() {}
    global.BaseScriptComponent = BaseScriptComponent;
    global.BaseScriptComponent.prototype = Object.getPrototypeOf(script);
    global.BaseScriptComponent.prototype.__initialize = function () {};
    global.BaseScriptComponent.getTypeName = function () {
        throw new Error("Cannot get type name from the class, not decorated with @component");
    };
}
var Module = require("../../../../Modules/Src/Assets/Scripts/GameUI");
Object.setPrototypeOf(script, Module.GameUI.prototype);
script.__initialize();
let awakeEvent = script.createEvent("OnAwakeEvent");
awakeEvent.bind(() => {
    checkUndefined("panelRoot", []);
    checkUndefined("messageText", []);
    checkUndefined("levelScoreText", []);
    checkUndefined("totalScoreText", []);
    checkUndefined("buttonText", []);
    checkUndefined("buttonObject", []);
    checkUndefined("buttonSound", []);
    checkUndefined("dismissDelay", []);
    checkUndefined("animSpeed", []);
    if (script.onAwake) {
       script.onAwake();
    }
});
