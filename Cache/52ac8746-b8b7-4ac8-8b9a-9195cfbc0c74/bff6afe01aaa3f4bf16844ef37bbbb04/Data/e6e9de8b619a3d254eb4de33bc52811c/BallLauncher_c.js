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
// @input float maxPullDistance = 15 {"hint":"How much user needs to pull to charge max force"}
// @input float launchForceMultiplier = 150 {"hint":"Strike force multiplier: higher valuer -> higher ball speed after hit"}
// @input float grabRadius = 6 {"hint":"Distance from the ball where pinch is registered to start aiming"}
// @input float stopThreshold = 0.4 {"hint":"If ball's speed drops lower than that value the ball stops"}
// @input SceneObject slingBase {"hint":"Base of the slingshot. Must be a sibling of the ball to work properly"}
// @input SceneObject slingPart {"hint":"Sling object of the slingshot. Must be a slingbase's child to work properly"}
// @input SceneObject arrowObject {"hint":"SceneObject for showing the direction of the hit. Must be slingbase's child to work properly"}
// @input SceneObject powerBarObject {"hint":"SceneObject showing strength of the hit during aiming. Must be slingbase's child to work properly"}
// @input SceneObject outOfBoundsEffect {"hint":"SceneObject with out of bounds animated texture. Played once the ball goes out of bounds. MUST have material with animated texture"}
// @input Component.ColliderComponent[] outOfBoundsTriggers = {} {"hint":"Collider components of the borders. If ball hits those it is considered out of bounds"}
// @input Component.AudioComponent outOfBoundsSound {"hint":"Sound effect played when ball goes out of bounds"}
// @input Component.AudioComponent wallHitSound {"hint":"Sound effect played when ball hits vertical surface"}
// @input Component.AudioComponent stretchSound {"hint":"Sound effect played when sling is stretched during aiming"}
// @input Component.AudioComponent releaseWeakSound {"hint":"Sound effect played when ball is hit with up to 85% strength"}
// @input Component.AudioComponent releaseStrongSound {"hint":"Sound effect played when ball is hit with >85% strength"}
// @input boolean enableTrail = true {"hint":"Enable trail building of the ball during movement"}
// @input SceneObject trailObject {"hint":"Empty SceneObject which helps to build top and bottom verticies of the trail. MUST be a sibling of LevelConatainer and must be in (0, 0, 0) position to work properly", "showIf":"enableTrail"}
// @input Asset.Material trailMaterial {"hint":"Material which will be assigned to trail", "showIf":"enableTrail"}
// @input vec4 trailColor = "{1, 1, 1, 1}" {"widget":"color", "showIf":"enableTrail"}
// @input float trailWidth = 3 {"showIf":"enableTrail"}
// @input float trailLength = 20 {"showIf":"enableTrail"}
// @input float trailUpdateInterval = 2 {"hint":"The trail will be build every N frame. Helps with performance", "showIf":"enableTrail"}
// @input boolean simulatorMode {"hint":"Enables mouse input similation for development and testing in Lens Studio preview"}
// @input Component.Camera simulatorCamera {"hint":"Camera from the scene used to translate screen input for mouse input simulation", "showIf":"simulatorMode"}
// @input float maxScreenPull = 0.15 {"hint":"How much do you need to pull with the mouse to charge max force", "showIf":"simulatorMode"}
// @input boolean debugMode {"hint":"Enables debug pring messages in the console"}
if (!global.BaseScriptComponent) {
    function BaseScriptComponent() {}
    global.BaseScriptComponent = BaseScriptComponent;
    global.BaseScriptComponent.prototype = Object.getPrototypeOf(script);
    global.BaseScriptComponent.prototype.__initialize = function () {};
    global.BaseScriptComponent.getTypeName = function () {
        throw new Error("Cannot get type name from the class, not decorated with @component");
    };
}
var Module = require("../../../../Modules/Src/Assets/Scripts/BallLauncher");
Object.setPrototypeOf(script, Module.BallLauncher.prototype);
script.__initialize();
let awakeEvent = script.createEvent("OnAwakeEvent");
awakeEvent.bind(() => {
    checkUndefined("maxPullDistance", []);
    checkUndefined("launchForceMultiplier", []);
    checkUndefined("grabRadius", []);
    checkUndefined("stopThreshold", []);
    checkUndefined("slingBase", []);
    checkUndefined("slingPart", []);
    checkUndefined("arrowObject", []);
    checkUndefined("powerBarObject", []);
    checkUndefined("outOfBoundsEffect", []);
    checkUndefined("outOfBoundsTriggers", []);
    checkUndefined("outOfBoundsSound", []);
    checkUndefined("wallHitSound", []);
    checkUndefined("stretchSound", []);
    checkUndefined("releaseWeakSound", []);
    checkUndefined("releaseStrongSound", []);
    checkUndefined("enableTrail", []);
    checkUndefined("trailObject", [["enableTrail",true]]);
    checkUndefined("trailMaterial", [["enableTrail",true]]);
    checkUndefined("trailColor", [["enableTrail",true]]);
    checkUndefined("trailWidth", [["enableTrail",true]]);
    checkUndefined("trailLength", [["enableTrail",true]]);
    checkUndefined("trailUpdateInterval", [["enableTrail",true]]);
    checkUndefined("simulatorMode", []);
    checkUndefined("simulatorCamera", [["simulatorMode",true]]);
    checkUndefined("maxScreenPull", [["simulatorMode",true]]);
    checkUndefined("debugMode", []);
    if (script.onAwake) {
       script.onAwake();
    }
});
