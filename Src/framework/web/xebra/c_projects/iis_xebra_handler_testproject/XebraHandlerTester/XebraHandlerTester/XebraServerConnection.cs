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
        int FRAG_SIZE = 65536;
        int MAX_FRAGS = 1000;

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
            string oute;

            Debug("About to send message '" + message + "'. Length is " + totalMessageLength + "bytes");

            while (bytesSent < totalMessageLength)
            {
                if ((totalMessageLength - bytesSent) > FRAG_SIZE)
                {
                    encodedMsgLengthByte = System.BitConverter.GetBytes((int)Encoder.encode_natural((uint)FRAG_SIZE, 1));
                    //Convert to bigendian
                    Array.Reverse(encodedMsgLengthByte);

                    System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
                    System.Buffer.BlockCopy(messageByte, bytesSent, msgFragAndLength, encodedMsgLengthByte.Length, FRAG_SIZE);

                    oute = System.Text.ASCIIEncoding.ASCII.GetString(msgFragAndLength);
                    Debug("--senging fragment " + FRAG_SIZE + " (+4) bytes : '" + oute + "'");
                    numBytes = socket.Client.Send(msgFragAndLength, msgFragAndLength.Length, SocketFlags.None);
                    Debug(numBytes + " bytes sent.");
                }
                else
                {
                    encodedMsgLengthByte = System.BitConverter.GetBytes((int)Encoder.encode_natural(totalMessageLength - (uint)bytesSent, 0));
                    //Convert to bigendian
                    Array.Reverse(encodedMsgLengthByte);

                    System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
                    System.Buffer.BlockCopy(messageByte, bytesSent, msgFragAndLength, encodedMsgLengthByte.Length, (int)totalMessageLength - (int)bytesSent);

                    oute = System.Text.ASCIIEncoding.ASCII.GetString(msgFragAndLength);
                    Debug("--senging LAST fragment " + msgFragAndLength.Length + " (+4) bytes : '" + oute + "'");
                    numBytes = socket.Client.Send(msgFragAndLength, (int)totalMessageLength - (int)bytesSent + 4, SocketFlags.None);
                    Debug(numBytes + " bytes sent.");
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
            Debug("Message sent.");
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

            Debug("Receiving message...");
            do
            {
                //Read Length
                Debug("Reading msg length...");
                numBytes = socket.Client.Receive(encodedLengthByte, 4, SocketFlags.None);
                if (numBytes != 4)
                {
                    Error("Could not receive 4 bytes for length.");
                    return "";
                }
                //Convert to littleEndian
                Array.Reverse(encodedLengthByte);

                encodedLength = System.BitConverter.ToUInt32(encodedLengthByte, 0);
                length = Encoder.decode_natural(encodedLength);
                flag = Encoder.decode_flag(encodedLength);

                if (flag)
                    Debug("Incoming message fragment " + length + " bytes...");
                else
                    Debug("Incoming (last) message fragment " + length + " bytes...");


                if (length < 1 || length > FRAG_SIZE)
                {
                    Error("Illegal msg length " + length);
                    return "";
                }

                //Read Msg
                Debug("Reading msg...");
                numBytes = socket.Client.Receive(msgBuf, (int)length, SocketFlags.None);
                message += System.Text.ASCIIEncoding.ASCII.GetString(msgBuf).Substring(0,numBytes);
                Debug("Read: '" + System.Text.ASCIIEncoding.ASCII.GetString(msgBuf) + "'");

                if (fragCounter > MAX_FRAGS)
                {
                    Error ("Maximum fragments reached, aborting.");
                    return "";
                }

                fragCounter++;
            } while (flag == true);
            return message;
        }

        //from
        //    l_i := 1
        //    l_frag_counter := 0
        //    l_msg.flag := True
        //    l_error := False
        //until
        //    not l_msg.flag or l_error
        //loop
        //    a_http_socket.read_natural_32
        //    l_msg.length := encoder.decode_natural (a_http_socket.last_natural_32)
        //    l_msg.flag := encoder.decode_flag (a_http_socket.last_natural_32)
        //    if not l_msg.is_length_valid then
        //        l_error := True
        //        o.eprint ("Could not decode msg length", generating_type)
        //    else
        //        l_buf := read_string (a_http_socket, l_msg.length)
        //        l_msg.append_string(l_buf)
        //        l_i := l_i + 1
        //    end
        //    if (l_frag_counter >= Max_fragments) then
        //        l_error := True
        //        o.eprint ("Maximumg fragments reached", generating_type)
        //    end
        //    l_frag_counter := l_frag_counter + 1
        //end

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
