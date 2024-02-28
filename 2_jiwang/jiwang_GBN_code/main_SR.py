import os
import socket
import threading
import time
import SR
import SSR

HOST_Send = '127.0.0.1'
HOST_Receive = ''
PORT_Client = 8888
PORT_Server = 9999
ADDR_Send_C = (HOST_Send, PORT_Client)
ADDR_Send_S = (HOST_Send, PORT_Server)
ADDR_Receive_C = (HOST_Receive, PORT_Client)
ADDR_Receive_S = (HOST_Receive, PORT_Server)
CLIENT_DIR = os.path.dirname(__file__) + '/client'
SERVER_DIR = os.path.dirname(__file__) + '/server'

senderSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
client_sender = SSR.GBNSender(senderSocket, ADDR_Send_C)
server_sender = SR.GBNSender(senderSocket, ADDR_Send_S)

receiverSocket_Client = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
receiverSocket_Server = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
receiverSocket_Client.bind(ADDR_Receive_C)
receiverSocket_Server.bind(ADDR_Receive_S)
client_receiver = SSR.GBNReceiver(receiverSocket_Server)
server_receiver = SR.GBNReceiver(receiverSocket_Client)

dataList1 = []
dataList2 = []


def run1_cs():
    client_fp_s = open(CLIENT_DIR + '/0data.jpg', 'rb')
    #   dataList1 = []
    while True:
        data1 = client_fp_s.read(2048)
        if len(data1) <= 0:
            break
        dataList1.append(data1)
    print('Client_Send The total number of data packets: ', len(dataList1))

    pointer1 = 0
    while True:
        while client_sender.next_seq_R < (client_sender.send_base_R + client_sender.window_size):
            if 1 >= len(dataList1):
                break
            # 发送窗口未被占满
            if pointer1 >= len(dataList1):
                break
            data1 = dataList1[pointer1]
            checksum1 = SR.getChecksum(data1)
            if pointer1 < len(dataList1) - 1:
                client_sender.packets[client_sender.next_seq_R] = client_sender.make_pkt(client_sender.next_seq_R,
                                                                                         data1,
                                                                                         checksum1,
                                                                                         stop=False)
            else:
                client_sender.packets[client_sender.next_seq_R] = client_sender.make_pkt(client_sender.next_seq_R,
                                                                                         data1,
                                                                                         checksum1,
                                                                                         stop=True)
            print('Client_Send packet:', pointer1)
            if client_sender.next_seq_R % 4 != 1:
                client_sender.udp_send(client_sender.packets[client_sender.next_seq_R])
            else:
                print("这是我故意让client数据包丢的，丢的Seq是", client_sender.next_seq_R)
            client_sender.next_seq_R = (client_sender.next_seq_R + 1) % 256
            pointer1 += 1
        #   client_sender.wait_ack()
        if pointer1 >= len(dataList1):
            break
    dataList1.clear()
    client_fp_s.close()


def run2_ss():
    server_fp_s = open(SERVER_DIR + '/0data2.jpg', 'rb')
    #   dataList2 = []
    while True:
        data2 = server_fp_s.read(2048)
        if len(data2) <= 0:
            break
        dataList2.append(data2)
    print('Server_Send The total number of data packets: ', len(dataList2))

    pointer2 = 0
    while True:
        while server_sender.next_seq < (server_sender.send_base + server_sender.window_size):
            if 1 >= len(dataList2):
                break
            # 发送窗口未被占满
            if pointer2 >= len(dataList2):
                break
            data2 = dataList2[pointer2]
            checksum2 = SR.getChecksum(data2)
            if pointer2 < len(dataList2) - 1:
                server_sender.packets[server_sender.next_seq] = server_sender.make_pkt(server_sender.next_seq, data2,
                                                                                       checksum2,
                                                                                       stop=False)
            else:
                server_sender.packets[server_sender.next_seq] = server_sender.make_pkt(server_sender.next_seq, data2,
                                                                                       checksum2,
                                                                                       stop=True)
            print('Server_Send packet:', pointer2)
            if server_sender.next_seq % 61 != 5:
                server_sender.udp_send(server_sender.packets[server_sender.next_seq])
            else:
                print("这是我故意让server数据包丢的，丢的Seq是", server_sender.next_seq)
            server_sender.next_seq = (server_sender.next_seq + 1) % 256
            pointer2 += 1
        #   server_sender.wait_ack()
        if pointer2 >= len(dataList2):
            break
    dataList2.clear()
    server_fp_s.close()


def run3_sr():
    server_fp_r = open(SERVER_DIR + '/' + str(int(time.time())) + '.jpg', 'ab')
    #   reset2 = False
    while True:
        data3, reset2 = server_receiver.wait_data()
        if len(data3)/2048 > 0.0:
            for i in range(0, int(len(data3) / 2048) + 1):
                if int(len(data3) / 2048) > 0 and i <= int(len(data3) / 2048) - 1:
                    dd = data3[i * 2048:(i + 1) * 2048]
                    server_fp_r.write(dd)
                else:
                    dd = data3[i * 2048:]
                    if len(dd) != 0:
                        server_fp_r.write(dd)
                print('焯Server_Received Data length:', len(dd))
            #   server_fp_r.write(dd)
        #   else:
        #    print('服务器端_Received Data length:', len(data3))
        #    server_fp_r.write(data3)
        if reset2:
            print("这个崽最后data3长度=", len(data3))
            server_receiver.expect_seq = 0
            server_fp_r.close()
            break


def run4_cr():
    client_fp_r = open(CLIENT_DIR + '/' + str(int(time.time())) + '.jpg', 'ab')
    #   reset4 = False
    while True:
        data4, reset4 = client_receiver.wait_data()
        if len(data4) / 2048 > 0.0:
            for i in range(0, int(len(data4) / 2048) + 1):
                if int(len(data4) / 2048) > 0 and i <= int(len(data4) / 2048) - 1 != 0:
                    d = data4[i * 2048:(i + 1) * 2048]
                    client_fp_r.write(d)
                else:
                    d = data4[i * 2048:]
                    if len(d) != 0:
                        client_fp_r.write(d)
                print('没想到吧Client_Received Data length:', len(d))
                #   client_fp_r.write(d)
        #   else:
        #    print('客户端_Received Data length:', len(data4))
        #    client_fp_r.write(data4)
        if reset4:
            print("data4长度=", len(data4))
            client_receiver.expect_seq = 0
            client_fp_r.close()
            break


def client_wait_ack():
    while True:
        client_sender.wait_ack()
        if client_sender.next_seq_R >= len(dataList1):
            return


def server_wait_ack():
    while True:
        server_sender.wait_ack()
        if server_sender.next_seq >= len(dataList2):
            return


def c2s():
    t_c2s_1 = threading.Thread(target=run1_cs)
    t_c2s_2 = threading.Thread(target=run3_sr)
    tt = threading.Thread(target=client_wait_ack)
    t_c2s_1.start()
    tt.start()
    t_c2s_2.start()


def s2c():
    t_s2c_1 = threading.Thread(target=run2_ss)
    t_s2c_2 = threading.Thread(target=run4_cr)
    ttt = threading.Thread(target=server_wait_ack)
    t_s2c_1.start()
    ttt.start()
    t_s2c_2.start()


if __name__ == '__main__':
    tt1 = threading.Thread(target=c2s)
    tt2 = threading.Thread(target=s2c)

    tt2.start()
    time.sleep(21)
    tt1.start()
