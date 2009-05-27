using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.Net.Sockets;

namespace Xebra
{
    class XServerConnection
    {

        #region Fields

        TcpClient socket;
        int FRAG_SIZE = 65536;
        int MAX_FRAGS = 1000;

        XLogger log;
  
        #endregion


        public XServerConnection(XLogger log)
        {
            this.log = log;
        }

        public bool connect()
        {
            try
            {
                log.Debug("Creating socket...");
                socket = new TcpClient("localhost", 55000);
                log.Debug("Connected.");
                return true;
            }
            catch
            {
                log.Error("Cannot connect the Xebra Server.");
                return false;
            }
        }

        public bool sendMessage(String message)
        {
            if (socket == null)
            {
                log.Error("Not connected!");
                return false;
            }
            //   char[] msgFrag = new char[FRAG_SIZE + 1];
            byte[] msgFragAndLength = new byte[FRAG_SIZE + 4];
            byte[] encodedMsgLengthByte = new byte[4];
            int bytesSent = 0;
            int numBytes = 0;
            byte[] messageByte = Encoding.UTF8.GetBytes(message);
            uint totalMessageLength = (uint)messageByte.Length;
            string oute;

            log.Debug("About to send message '" + message + "'. Length is " + totalMessageLength + "bytes");

            while (bytesSent < totalMessageLength)
            {
                if ((totalMessageLength - bytesSent) > FRAG_SIZE)
                {
                    encodedMsgLengthByte = System.BitConverter.GetBytes((int)XEncoder.encodeNatural((uint)FRAG_SIZE, 1));
                    //Convert to bigendian
                    Array.Reverse(encodedMsgLengthByte);

                    System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
                    System.Buffer.BlockCopy(messageByte, bytesSent, msgFragAndLength, encodedMsgLengthByte.Length, FRAG_SIZE);

                    oute = System.Text.ASCIIEncoding.ASCII.GetString(msgFragAndLength);
                    log.Debug("--senging fragment " + FRAG_SIZE + " (+4) bytes : '" + oute + "'");
                    numBytes = socket.Client.Send(msgFragAndLength, msgFragAndLength.Length, SocketFlags.None);
                    log.Debug(numBytes + " bytes sent.");
                }
                else
                {
                    encodedMsgLengthByte = System.BitConverter.GetBytes((int)XEncoder.encodeNatural(totalMessageLength - (uint)bytesSent, 0));
                    //Convert to bigendian
                    Array.Reverse(encodedMsgLengthByte);

                    System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
                    System.Buffer.BlockCopy(messageByte, bytesSent, msgFragAndLength, encodedMsgLengthByte.Length, (int)totalMessageLength - (int)bytesSent);

                    oute = System.Text.ASCIIEncoding.ASCII.GetString(msgFragAndLength);
                    log.Debug("--senging LAST fragment " + msgFragAndLength.Length + " (+4) bytes : '" + oute + "'");
                    numBytes = socket.Client.Send(msgFragAndLength, (int)totalMessageLength - (int)bytesSent + 4, SocketFlags.None);
                    log.Debug(numBytes + " bytes sent.");
                }
                if (numBytes < 5)
                {
                    log.Error("Failed to send!");
                    return false;
                }
                else
                {
                    bytesSent += numBytes - 4;
                }
            }
            log.Debug("Message sent.");
            return true;
        }

        public String receiveMessage()
        {
            bool flag = false;
            byte[] encodedLengthByte = new byte[4];
            uint encodedLength;
            uint length;
            int fragCounter = 0;
            int numBytes;
            string message = "";
            byte[] msgBuf = new byte[FRAG_SIZE + 4];

            log.Debug("Receiving message...");
            do
            {
                //Read Length
                log.Debug("Reading msg length...");
                numBytes = socket.Client.Receive(encodedLengthByte, 4, SocketFlags.None);
                if (numBytes != 4)
                {
                    log.Error("Could not receive 4 bytes for length.");
                    return "";
                }
                //Convert to littleEndian
                Array.Reverse(encodedLengthByte);

                encodedLength = System.BitConverter.ToUInt32(encodedLengthByte, 0);
                length = XEncoder.decodeNatural(encodedLength);
                flag = XEncoder.decodeFlag(encodedLength);

                if (flag)
                    log.Debug("Incoming message fragment " + length + " bytes...");
                else
                    log.Debug("Incoming (last) message fragment " + length + " bytes...");


                if (length < 1 || length > FRAG_SIZE)
                {
                    log.Error("Illegal msg length " + length);
                    return "";
                }

                //Read Msg
                log.Debug("Reading msg...");
                numBytes = socket.Client.Receive(msgBuf, (int)length, SocketFlags.None);
                message += System.Text.ASCIIEncoding.ASCII.GetString(msgBuf).Substring(0,numBytes);
                log.Debug("Read: '" + System.Text.ASCIIEncoding.ASCII.GetString(msgBuf) + "'");

                if (fragCounter > MAX_FRAGS)
                {
                    log.Error ("Maximum fragments reached, aborting.");
                    return "";
                }

                fragCounter++;
            } while (flag == true);
            return message;
        }         
    }
}
