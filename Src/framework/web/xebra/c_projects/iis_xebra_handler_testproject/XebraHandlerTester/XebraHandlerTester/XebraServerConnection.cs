using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.Net.Sockets;

namespace XebraHandlerTester
{
    class XebraServerConnection
    {

        #region Fields

        TcpClient socket;
        int FRAG_SIZE = 15;//65536;

        public delegate void Outputter(String s);
        Outputter outputter;
        #endregion


        public XebraServerConnection(Outputter outputter)
        {
            this.outputter = outputter;
        }

        public bool connect()
        {
            try
            {
                Debug("Creating socket...");
                socket = new TcpClient("localhost", 55000);
                Debug("Connected.");
                return true;
            }
            catch
            {
                Error("Cannot connect the Xebra Server.");
                return false;
            }
        }

        public bool sendMessage(String message)
        {
            if (socket == null)
            {
                Error("Not connected!");
                return false;
            }
            //   char[] msgFrag = new char[FRAG_SIZE + 1];
            byte[] msgFragAndLength = new byte[FRAG_SIZE + 4];
            byte[] encodedMsgLengthByte = new byte[4];
            int bytesSent = 0;
            int numBytes = 0;
            byte[] messageByte = Encoding.UTF8.GetBytes(message);
            uint totalMessageLength = (uint)messageByte.Length;

            Debug("About to send message '" + message + "'. Length is " + totalMessageLength + "bytes");

                
            while (bytesSent < totalMessageLength)
            {
                if ((messageByte.Length - bytesSent) > FRAG_SIZE)
                {
                    encodedMsgLengthByte = System.BitConverter.GetBytes((int)Encoder.encode_natural((uint)FRAG_SIZE, 1));
                    //Convert to bigendian
                    Array.Reverse(encodedMsgLengthByte);

                    System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
                    System.Buffer.BlockCopy(messageByte, bytesSent, msgFragAndLength, encodedMsgLengthByte.Length, FRAG_SIZE);


                    numBytes = socket.Client.Send(msgFragAndLength, bytesSent, msgFragAndLength.Length, SocketFlags.None);
                }
                else
                {
                    encodedMsgLengthByte = System.BitConverter.GetBytes((int)Encoder.encode_natural(totalMessageLength - (uint)bytesSent, 0));
                    //Convert to bigendian
                    Array.Reverse(encodedMsgLengthByte);

                    System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
                    System.Buffer.BlockCopy(messageByte, bytesSent, msgFragAndLength, encodedMsgLengthByte.Length, messageByte.Length - (int)bytesSent);


                    numBytes = socket.Client.Send(msgFragAndLength, bytesSent, msgFragAndLength.Length - bytesSent, SocketFlags.None);
                }
                if (numBytes < 5)
                {
                    Error("Failed to send!");
                    return false;
                }       
                else
                {
                    bytesSent += numBytes - 4;
                }
            }


            //while (bytesSent < totalMessageLength)
            //{
            //    if (message.Length <= FRAG_SIZE)
            //    {
            //        msgFrag = message.ToCharArray();
            //        encodedMsgLengthByte = intToByteArray(encode_natural(msgFrag.Length * SOC, 0));
            //        Debug(" -About to send last fragment. Length is " + msgFrag.Length * SOC + " bytes");
            //    }
            //    else
            //    {
            //        msgFrag = message.Substring(0, FRAG_SIZE).ToCharArray();
            //        message = message.Substring(FRAG_SIZE, message.Length);
            //        encodedMsgLengthByte = intToByteArray(encode_natural(msgFrag.Length, 1));
            //        Debug("-About to send fragment. Length is " + msgFrag.Length * SOC + " bytes");
            //    }
            //    //Debug("-Sending length...");
            //    ////Send msg length
            //    //numBytes = socket.Client.Send(encodedMsgLengthByte, 4, SocketFlags.None);

            //    //if (numBytes < 1)
            //    //{
            //    //    Error("Failed to send encodedMsgLengthByte");
            //    //    return false;
            //    //}
            //    //Debug("Length sent.");
            //    Debug("-Sending fragment...: '" + msgFrag.ToString() + "'");

            //    //Copy length and msg into one byte array
            //    System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
            //    System.Buffer.BlockCopy(msgFrag, 0, msgFragAndLength, encodedMsgLengthByte.Length - 1, msgFrag.Length);


            //    //Send Length and Msg
            //    numBytes = socket.Client.Send(msgFragAndLength, msgFragAndLength.Length, SocketFlags.None);
            //    if (numBytes < 1)
            //    {
            //        Error("Failed to send encodedMsgLengthByte");
            //        return false;
            //    }

            //    bytesSent += msgFrag.Length * SOC;
            //    Debug("Fragment sent.");

            //}
            Debug("Message sent.");
            return true;
        }

        //private String receiveMessage()
        //{
        //    if (socket == void)
        //    {
        //        Error("Not connected!");
        //        return "";
        //    }

        //    int flag = 0;
        //    int numBytes = 0;
        //    byte[] fragLengthEncByte = new Byte[sizeof(int)];
        //    int fragLengthEnc;
        //    int fragLength;
        //    byte[] buf = new Byte[FRAG_SIZE + 1];
        //    char[] fragfragBuf = new Char[FRAG_SIZE + 1];
        //    String fragBuf = "";
        //    int bytesRecv = 0;
        //    String message = "";

        //    Debug("Receiving message...");

        //    do
        //    {
        //        //Receive the fragment length
        //        numBytes = socket.Client.Receive(fragLengthEncByte, sizeof(int), SocketFlags.None);
        //        if (numBytes != sizeof(int))
        //        {
        //            Debug("Failed to receive fragment length. Received " + numBytes + " bytes instead of " + sizeof(int) + " bytes");
        //            return "";
        //        }

        //        fragLengthEnc = byteArrayToInt(fragLengthEncByte);
        //        fragLength = decode_natural(fragLengthEnc);
        //        flag = decode_flag(fragLengthEnc);

        //        Debug("Incoming frag, " + fragLength + " bytes, flag is " + flag);

        //        numBytes = 0;
        //        while (bytesRecv < fragLength)
        //        {
        //            numBytes = socket.Client.Receive(buf, fragLength, SocketFlags.None);
        //            if (numBytes < 1)
        //            {
        //                Debug("Failed to receive message. numbytes=" + numBytes);
        //                return "";
        //            }
        //            fragfragBuf = UnicodeEncoding.UTF8.GetChars(buf);
        //            fragfragBuf[numBytes] = '\0';

        //            fragBuf = fragBuf + fragfragBuf.ToString();
        //            bytesRecv += numBytes;
        //        }

        //        if (bytesRecv != fragLength)
        //        {
        //            Debug("ERROR, received bytes=" + bytesRecv + ", fragLengh is " + fragLength);
        //            return "";
        //        }

        //        Debug("Recieved " + bytesRecv + " bytes:'" + fragBuf + "'");
        //        message = message + fragBuf;

        //    } while (flag == 1);

        //    Debug("Completed recieving message.");
        //    return message;
        //}      

        private void Error(String msg)
        {
            Log(msg, EventLogEntryType.Error);
        }

        private void Warning(String msg)
        {
            Log(msg, EventLogEntryType.Warning);
        }

        private void Debug(String msg)
        {
            Log(msg, EventLogEntryType.Information);
        }

        private void Log(String msg, EventLogEntryType type)
        {
            outputter(msg);
        }
    }
}
