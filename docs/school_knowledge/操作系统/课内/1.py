import threading

# 定义信号量
semA = threading.Semaphore(0)
semB = threading.Semaphore(0)
semD = threading.Semaphore(0)
semE = threading.Semaphore(0)

def P1():
    print("A")
    semA.release()  # A完成后，释放信号量semA
    semA.acquire()  # 等待A完成
    semA.release()  # A完成后，释放信号量semA
    semD.acquire()  # 等待D完成
    print("B")
    semB.release()  # B完成后，释放信号量semB
    semB.acquire()  # 等待B完成
    print("C")

def P2():
    print("D")
    semD.release()  # D完成后，释放信号量semD
    semA.acquire()  # 等待A完成
    semB.acquire()  # 等待B完成
    semB.release()  # B完成后，释放信号量semB
    print("E")
    print("F")

if __name__ == '__main__':
    P1_thread = threading.Thread(target=P1)
    P2_thread = threading.Thread(target=P2)
    P1_thread.start()
    P2_thread.start()
    P1_thread.join()
    P2_thread.join()