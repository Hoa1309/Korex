import time
import random

# Giả lập vòng lặp game hiển thị FPS "fake"
def fake_fps_counter():
    print("Đang kích hoạt Fake FPS Turbo Boost...")
        time.sleep(1)
            
                while True:
                        # Tạo số FPS giả từ 240 đến 300
                                fake_fps = random.randint(240, 300)
                                        print(f"\r[TURBO MODE] FPS hiện tại: {fake_fps} FPS | Ping: 5ms", end="")
                                                time.sleep(0.5)

                                                if __name__ == "__main__":
                                                    try:
                                                            fake_fps_counter()
                                                                except KeyboardInterrupt:
                                                                        print("\nĐã tắt Fake FPS.")
                                                                        