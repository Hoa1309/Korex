import tkinter as tk
import threading
import time

class KorexHubApp:
    def __init__(self, root):
        self.root = root
        self.root.title("KOREX HUB")
        self.root.geometry("250x130")
        self.root.configure(bg="#0a0a0c")
        self.root.attributes("-topmost", True)
        self.root.resizable(False, False)

        self.hb_on = False

        # Header
        self.header_frame = tk.Frame(self.root, bg="#0a0a0c")
        self.header_frame.pack(fill="x", px=10, py=5)

        self.title_label = tk.Label(
            self.header_frame, 
            text="KOREX HUB", 
            fg="#ffffff", 
            bg="#0a0a0c", 
            font=("Arial", 11, "bold")
        )
        self.title_label.pack(side="left")

        self.min_btn = tk.Button(
            self.header_frame, 
            text="−", 
            fg="#c8c8c8", 
            bg="#19191c", 
            activebackground="#252528", 
            activeforeground="#ffffff", 
            bd=0, 
            font=("Arial", 12, "bold"), 
            command=self.toggle_minimize,
            width=3
        )
        self.min_btn.pack(side="right")

        # Line Separator
        self.line = tk.Frame(self.root, bg="#1e1e23", height=1)
        self.line.pack(fill="x", px=10, py=2)

        # Toggle Button Frame
        self.btn_frame = tk.Frame(self.root, bg="#121214", highlightbackground="#232328", highlightthickness=1)
        self.btn_frame.pack(fill="x", px=10, py=10)

        self.hb_label = tk.Label(
            self.btn_frame, 
            text="Hitbox x7", 
            fg="#96969b", 
            bg="#121214", 
            font=("Arial", 10, "bold")
        )
        self.hb_label.pack(side="left", px=10, py=8)

        self.toggle_btn = tk.Button(
            self.btn_frame, 
            text="OFF", 
            fg="#96969b", 
            bg="#1e1e23", 
            activebackground="#323237", 
            bd=0, 
            font=("Arial", 9, "bold"), 
            command=self.toggle_hitbox,
            width=6
        )
        self.toggle_btn.pack(side="right", px=10)

        # Mini Icon Window
        self.icon_window = None

        # Thread loop cho Hitbox
        self.running = True
        self.loop_thread = threading.Thread(target=self.hitbox_loop, daemon=True)
        self.loop_thread.start()

    def toggle_hitbox(self):
        self.hb_on = not self.hb_on
        if self.hb_on:
            self.toggle_btn.config(text="ON", fg="#ffffff", bg="#323237")
            self.hb_label.config(fg="#ffffff")
            print("[KOREX] Hitbox: ON (Color #5567ff, Size 40x40x40)")
        else:
            self.toggle_btn.config(text="OFF", fg="#96969b", bg="#1e1e23")
            self.hb_label.config(fg="#96969b")
            print("[KOREX] Hitbox: OFF (Reset size)")

    def toggle_minimize(self):
        self.root.withdraw()
        self.icon_window = tk.Toplevel()
        self.icon_window.title("K")
        self.icon_window.geometry("45x45")
        self.icon_window.configure(bg="#0a0a0c")
        self.icon_window.attributes("-topmost", True)
        self.icon_window.resizable(False, False)

        btn = tk.Button(
            self.icon_window, 
            text="K", 
            fg="#ffffff", 
            bg="#0a0a0c", 
            font=("Arial", 14, "bold"), 
            bd=0, 
            command=self.restore_window
        )
        btn.pack(fill="both", expand=True)

    def restore_window(self):
        if self.icon_window:
            self.icon_window.destroy()
        self.root.deiconify()

    def hitbox_loop(self):
        while self.running:
            if self.hb_on:
                # Logic xử lý hitbox bằng Python (Memory write / Hook) đặt ở đây
                pass
            time.sleep(0.1)

if __name__ == "__main__":
    root = tk.Tk()
    app = KorexHubApp(root)
    root.mainloop()
