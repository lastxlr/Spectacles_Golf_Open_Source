"use strict";
/**
 * Specs Inc. 2026
 * Unique identifier generator for tween instances. Provides sequential ID assignment for tracking
 * and managing individual tweens within groups, enabling efficient lookup, removal, and lifecycle
 * management across the animation system.
 */
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Utils
 */
class Sequence {
    static nextId() {
        return Sequence._nextId++;
    }
}
Sequence._nextId = 0;
exports.default = Sequence;
//# sourceMappingURL=Sequence.js.map