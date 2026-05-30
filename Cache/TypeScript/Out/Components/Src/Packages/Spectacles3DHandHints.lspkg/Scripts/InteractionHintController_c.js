if (script.onAwake) {
    script.onAwake();
    return;
}
/*
@typedef HintAnimation
@property {int} handType {"widget":"combobox", "values":[{"label":"Left", "value":0}, {"label":"Right", "value":1}, {"label":"Both", "value":2}]}
@property {string} oneHandedAnimation_l = "pinch_near" {"widget":"combobox", "values":[{"label":"Pinch Near", "value":"pinch_near"}, {"label":"Pinch Far", "value":"pinch_far"}, {"label":"Pinch Move X", "value":"pinch_move_x"}, {"label":"Pinch Move Y", "value":"pinch_move_y"}, {"label":"Pinch Move Z", "value":"pinch_move_z"}, {"label":"Pinch Rotate X", "value":"pinch_rotate_x"}, {"label":"Pinch Rotate Y", "value":"pinch_rotate_y"}, {"label":"Pinch Rotate Z", "value":"pinch_rotate_z"}, {"label":"Pinch Swipe X", "value":"pinch_swipe_x"}, {"label":"Pinch Swipe Y", "value":"pinch_swipe_y"}, {"label":"Finger Tap Near", "value":"finger_tap_near"}, {"label":"Finger Tap Surface", "value":"finger_tap_surface"}, {"label":"Finger Swipe X", "value":"finger_swipe_x"}, {"label":"Finger Swipe Y", "value":"finger_swipe_y"}, {"label":"Finger Scroll Mirco", "value":"finger_scroll_micro"}, {"label":"Palm Touch Near", "value":"palm_touch_near"}, {"label":"Palm Touch Surface", "value":"palm_touch_surface"}, {"label":"Palm Swipe X", "value":"palm_swipe_x"}, {"label":"Palm Grab X", "value":"palm_grab_x"}, {"label":"Palm Grab Y", "value":"palm_grab_y"}], "showIf":"handType", "showIfValue":0}
@property {string} oneHandedAnimation_r = "pinch_near" {"widget":"combobox", "values":[{"label":"Pinch Near", "value":"pinch_near"}, {"label":"Pinch Far", "value":"pinch_far"}, {"label":"Pinch Move X", "value":"pinch_move_x"}, {"label":"Pinch Move Y", "value":"pinch_move_y"}, {"label":"Pinch Move Z", "value":"pinch_move_z"}, {"label":"Pinch Rotate X", "value":"pinch_rotate_x"}, {"label":"Pinch Rotate y", "value":"pinch_rotate_y"}, {"label":"Pinch Rotate Z", "value":"pinch_rotate_z"}, {"label":"Pinch Swipe X", "value":"pinch_swipe_x"}, {"label":"Pinch Swipe Y", "value":"pinch_swipe_y"}, {"label":"Finger Tap Near", "value":"finger_tap_near"}, {"label":"Finger Tap Surface", "value":"finger_tap_surface"}, {"label":"Finger Swipe X", "value":"finger_swipe_x"}, {"label":"Finger Swipe Y", "value":"finger_swipe_y"}, {"label":"Finger Scroll Mirco", "value":"finger_scroll_micro"}, {"label":"Palm Touch Near", "value":"palm_touch_near"}, {"label":"Palm Touch Surface", "value":"palm_touch_surface"}, {"label":"Palm Swipe X", "value":"palm_swipe_x"}, {"label":"Palm Grab X", "value":"palm_grab_x"}, {"label":"Palm Grab Y", "value":"palm_grab_y"}], "showIf":"handType", "showIfValue":1}
@property {string} twoHandedAnimation = "two_hands_pinch_scale" {"widget":"combobox", "values":[{"label":"System Tap Settings", "value":"system_tap_settings"}, {"label":"System Tap Rotate Down", "value":"system_tap_rotate_down"}, {"label":"System Tap Rotate Up", "value":"system_tap_rotate_up"}, {"label":"System Tap Watch", "value":"system_tap_watch"}, {"label":"System Tap Exit", "value":"system_tap_exit"}, {"label":"Two Hands Pinch Scale", "value":"two_hands_pinch_scale"}, {"label":"Two Hands Pinch Rotate Y", "value":"two_hands_pinch_rotate_y"}, {"label":"Two Hands Pinch Rotate Z", "value":"two_hands_pinch_rotate_z"}, {"label":"Two Hands Palm Grab X", "value":"two_hands_palm_grab_x"}, {"label":"Two Hands Palm Grab Y", "value":"two_hands_palm_grab_y"}], "showIf":"handType", "showIfValue":2}
@property {vec3} position
*/
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
// @ui {"widget":"separator"}
// @ui {"widget":"label", "label":"<span style=\"color: #60A5FA;\">Playback Configuration</span>"}
// @ui {"widget":"label", "label":"<span style=\"color: #94A3B8; font-size: 11px;\">Animation speed, looping, and autoplay settings</span>"}
// @input bool autoPlay
// @input float animationSpeed = 1 {"widget":"slider", "min":0.5, "max":3, "step":0.1}
// @input int numberOfLoops = 1 {"widget":"slider", "min":1, "max":10, "step":1, "showIf":"loop", "showIfValue":true}
// @ui {"widget":"separator"}
// @ui {"widget":"label", "label":"<span style=\"color: #60A5FA;\">Animation Sequence</span>"}
// @ui {"widget":"label", "label":"<span style=\"color: #94A3B8; font-size: 11px;\">Hint animations to play in sequence</span>"}
// @input HintAnimation[] hintAnimations {"showIf":"sequence", "showIfValue":true}
// @ui {"widget":"separator"}
// @ui {"widget":"label", "label":"<span style=\"color: #60A5FA;\">Logging Configuration</span>"}
// @ui {"widget":"label", "label":"<span style=\"color: #94A3B8; font-size: 11px;\">Control logging output for this script instance</span>"}
// @input bool enableLogging {"hint":"Enable general logging (animation cycles, events, etc.)"}
// @input bool enableLoggingLifecycle {"hint":"Enable lifecycle logging (onAwake, onStart, onUpdate, onDestroy, etc.)"}
if (!global.BaseScriptComponent) {
    function BaseScriptComponent() {}
    global.BaseScriptComponent = BaseScriptComponent;
    global.BaseScriptComponent.prototype = Object.getPrototypeOf(script);
    global.BaseScriptComponent.prototype.__initialize = function () {};
    global.BaseScriptComponent.getTypeName = function () {
        throw new Error("Cannot get type name from the class, not decorated with @component");
    };
}
var Module = require("../../../../../Modules/Src/Packages/Spectacles3DHandHints.lspkg/Scripts/InteractionHintController");
Object.setPrototypeOf(script, Module.InteractionHintController.prototype);
script.__initialize();
let awakeEvent = script.createEvent("OnAwakeEvent");
awakeEvent.bind(() => {
    checkUndefined("autoPlay", []);
    checkUndefined("animationSpeed", []);
    checkUndefined("numberOfLoops", [["loop",true]]);
    checkUndefined("hintAnimations", [["sequence",true]]);
    checkUndefined("enableLogging", []);
    checkUndefined("enableLoggingLifecycle", []);
    if (script.onAwake) {
       script.onAwake();
    }
});
