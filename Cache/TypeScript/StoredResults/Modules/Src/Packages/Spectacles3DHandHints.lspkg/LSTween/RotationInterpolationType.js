"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RotationInterpolationType = void 0;
/**
 * Specs Inc. 2026
 * Rotation interpolation type enum for quaternion animation. Defines LERP (linear interpolation)
 * for faster but non-spherical rotation, and SLERP (spherical linear interpolation) for smooth
 * constant-velocity rotation along the shortest arc between quaternions.
 */
var RotationInterpolationType;
(function (RotationInterpolationType) {
    RotationInterpolationType[RotationInterpolationType["LERP"] = 0] = "LERP";
    RotationInterpolationType[RotationInterpolationType["SLERP"] = 1] = "SLERP";
})(RotationInterpolationType || (exports.RotationInterpolationType = RotationInterpolationType = {}));
//# sourceMappingURL=RotationInterpolationType.js.map