class UnknownUI {
    constructor() {
        this.title = "Unknown ∞";
        this.features = {
            hitbox: false,
            esp: false,
            speed: false,
            infHealth: false,
            glitchSpeed: false
        };
    }

    toggle(featureName) {
        if (this.features.hasOwnProperty(featureName)) {
            this.features[featureName] = !this.features[featureName];
            console.log(`[${featureName}] state: ${this.features[featureName] ? "ON" : "OFF"}`);
        } else {
            console.log("K tìm thấy tính năng!");
        }
    }
}

// Demo chạy
const ui = new UnknownUI();
ui.toggle("hitbox");
ui.toggle("speed");
