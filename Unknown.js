// ============================================
// Modern Unknown UI - Multi-Feature Cheat Core
// Github Repo: Hoa1309/Korex
// ============================================

class ModernUnknownCore {
    constructor() {
        this.version = "1.0.0-PROD";
        this.title = "Unknown ∞";
        
        // System Config State
        this.features = {
            // Combat & Visual
            hitbox: { active: false, size: 25, transparency: 0.8 },
            espHighlight: { active: false, color: "#785aff" },
            espTracers: { active: false, color: "#00d2ff" },
            espBoxes: { active: false, color: "#ffffff" },
            
            // Movement
            speedHack: { active: false, multiplier: 1.5, baseSpeed: 16 },
            noclip: { active: false },
            glitchSpeed: { active: false, power: 20, moveBoost: 6, idleBoost: 6 },
            
            // Player & Utility
            infHealthUI: { active: false },
            godMode: { active: false }
        };

        this.listeners = new Map();
        this.initSystem();
    }

    initSystem() {
        console.log(`[${this.title}] Core System Initialized v${this.version}`);
    }

    // Toggle bất kỳ tính năng nào theo name
    toggleFeature(featureKey, customParams = {}) {
        if (!this.features.hasOwnProperty(featureKey)) {
            console.error(`[ERROR] Feature "${featureKey}" K tồn tại!`);
            return false;
        }

        const feat = this.features[featureKey];
        feat.active = !feat.active;
        
        // Merge custom params nếu có
        Object.assign(feat, customParams);

        const status = feat.active ? "ACTIVATED" : "DEACTIVATED";
        console.log(`[TOGGLE] ${featureKey.toUpperCase()} -> ${status}`);

        // Trigger Callback event
        this.emit("featureStateChange", {
            feature: featureKey,
            state: feat.active,
            config: feat
        });

        return feat.active;
    }

    // Set giá trị tham số (ví dụ: đổi tốc độ, kích thước hitbox)
    setFeatureParam(featureKey, paramName, value) {
        if (this.features[featureKey] && this.features[featureKey].hasOwnProperty(paramName)) {
            this.features[featureKey][paramName] = value;
            console.log(`[CONFIG] ${featureKey}.${paramName} = ${value}`);
        }
    }

    // Event Emitter
    on(event, callback) {
        if (!this.listeners.has(event)) {
            this.listeners.set(event, []);
        }
        this.listeners.get(event).push(callback);
    }

    emit(event, data) {
        if (this.listeners.has(event)) {
            this.listeners.get(event).forEach(cb => cb(data));
        }
    }

    // Xuất dữ liệu config JSON
    exportConfig() {
        return JSON.stringify(this.features, null, 2);
    }

    // Load config từ JSON
    importConfig(jsonString) {
        try {
            const parsed = JSON.parse(jsonString);
            Object.assign(this.features, parsed);
            console.log("[CONFIG] Config imported thành công!");
        } catch (e) {
            console.error("[ERROR] Config JSON K hợp lệ!");
        }
    }
}

// Khởi tạo Instance toàn cục
const UnknownExecutor = new ModernUnknownCore();

// Lắng nghe sự kiện thay đổi trạng thái
UnknownExecutor.on("featureStateChange", (data) => {
    console.log(`[EVENT HANDLER] Feature ${data.feature} status: ${data.state}`);
});

// Export module nếu dùng Node.js/Browser
if (typeof module !== 'undefined' && module.exports) {
    module.exports = ModernUnknownCore;
                   }
