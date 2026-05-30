"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.mainGroup = void 0;
/**
 * Specs Inc. 2026
 * Global default tween group singleton for automatic tween management. Provides shared group
 * instance used by LSTween wrapper methods, enabling immediate tween playback without explicit
 * group creation while maintaining centralized update loop integration.
 */
const Group_1 = require("./Group");
exports.mainGroup = new Group_1.default();
//# sourceMappingURL=mainGroup.js.map