"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Specs Inc. 2026
 * Time utility function for tween system providing millisecond-precision timestamps. Wraps Lens
 * Studio's getTime() function and converts seconds to milliseconds for consistent timing across
 * all animation calculations and frame updates.
 */
const now = () => getTime() * 1000;
exports.default = now;
//# sourceMappingURL=Now.js.map