import tkinter as tk

root = tk.Tk()
root.title("Unknown ∞")
root.geometry("260x360")
root.configure(bg="#0f111a")

# Title
title = tk.Label(root, text="Unknown ∞", font=("Segoe UI", 14, "bold"), fg="#ffffff", bg="#0f111a")
title.pack(pady=15)

# Toggles
features = ["Hitbox x7", "ESP Highlight", "Speed x1.5", "Inf Health UI", "Glitch Speed"]
states = {}

def toggle_feature(name):
    states[name] = not states[name]
    status = "ON" if states[name] else "OFF"
    print(f"[{name}] -> {status}")

for feature in features:
    states[feature] = False
    btn = tk.Button(
        root, 
        text=feature, 
        font=("Segoe UI", 10), 
        fg="#a2a7c8", 
        bg="#161926", 
        activebackground="#1c2032",
        activeforeground="#ffffff",
        bd=0, 
        relief="flat",
        command=lambda f=feature: toggle_feature(f)
    )
    btn.pack(fill="x", padx=15, pady=5, ipady=6)

root.mainloop()
