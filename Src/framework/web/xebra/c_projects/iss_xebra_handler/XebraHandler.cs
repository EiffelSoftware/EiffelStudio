using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Net.Sockets;
using System.IO;


namespace Xebra
{
    class XebraHandler : IHttpHandler
    {
        #region IHttpHandler Members

        public bool IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            TcpClient socket;
            try
            {
                socket = new TcpClient("localHost", 55005);
            }
            catch
            {
                Console.WriteLine(
                "Failed to connect to server at {0}:999", "localhost");
                return;
            }



            socket.Close();
            context.Response.Write(error_msg);
            //String.Format("<h1>{0}</h1>",
            //               dt.ToLongTimeString()
            //               ));
        }

        #endregion

        String error_msg = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title>Xebra Module - Error Report</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><style type=\"text/css\"><!--body,td,th {	font-family: Geneva, Arial, Helvetica, sans-serif;	font-size: 12px;}h1 {	font-size: 18px;	background-color:#000000;	color: #FFFFFF;}h3 {	font-size: 14px;	background-color:#000000;	color: #FFFFFF;}.em {font-size: 14px;background-color:#000000;color: #FFFFFF;margin-right: 10px;font-weight: bold;}--></style></head><body><h1>Xebra Module - Error Report</h1><hr/><p><span class=\"em\">Message: </span>Not implemented</p><p><img src=\"http://www.yiyinglu.com/failwhale/images/failwhale.gif\" alt=\"fail whale image\" width=\"800\" height=\"432\" /></p><hr /><h3>Xebra Module $Revision: 78721 $</h3></body></html>";

        int SOC = sizeof(char);
        int FRAG_SIZE = 65536;

        private String receiveMessage(TcpClient socket)
        {
            int flag = 0;
            int numBytes = 0;
            byte[] fragLengthEncByte = new Byte[sizeof(int)];
            int fragLengthEnc;
            int fragLength;
            byte[] buf = new Byte[FRAG_SIZE * SOC + 1];
            char[] fragfragBuf = new Char[FRAG_SIZE * SOC + 1];
            String fragBuf = "";
            int bytesRecv = 0;
            String message = "";

            Console.WriteLine("Receiving message...");

            do
            {
                //Receive the fragment length
                numBytes = socket.Client.Receive(fragLengthEncByte, sizeof(int), SocketFlags.None);
                if (numBytes != sizeof(int))
                {
                    Console.WriteLine("Failed to receive fragment length. Received " + numBytes + " bytes instead of " + sizeof(int) + " bytes");
                    return "";
                }
                                
                fragLengthEnc = byteArrayToInt(fragLengthEncByte);
                fragLength = decode_natural(fragLengthEnc);
                flag = decode_flag(fragLengthEnc);

                 Console.WriteLine ("Incoming frag, "+fragLength+" bytes, flag is "+flag);

                numBytes = 0;
                while (bytesRecv < fragLength)
                {
                    numBytes = socket.Client.Receive(buf, fragLength, SocketFlags.None);
                    if (numBytes < 1)
                    {
                        Console.WriteLine("Failed to receive message. numbytes=" + numBytes);
                        return "";
                    }
                    fragfragBuf = UnicodeEncoding.UTF8.GetChars(buf);
                    fragfragBuf[numBytes] = '\0';

                    fragBuf = fragBuf + fragfragBuf.ToString();
                    bytesRecv += numBytes;
                }

                if (bytesRecv != fragLength)
                {
                    Console.WriteLine("ERROR, received bytes=" + bytesRecv + ", fragLengh is " + fragLength);
                    return "";
                }

                Console.WriteLine("Recieved " + bytesRecv + " bytes:'" + fragBuf + "'");
                message = message + fragBuf;

            } while (flag == 1);

            Console.WriteLine("Completed recieving message.");
            return message;
        }

        private bool sendMessage(TcpClient socket, String message)
        {
            char[] msgFrag = new char[FRAG_SIZE + 1];
            byte[] encodedMsgLengthByte;
            int bytesSent = 0;
            int numBytes = 0;
            int totalMessageLength = message.Length * SOC;

            Console.WriteLine("About to send message. Length is " + totalMessageLength + "bytes");

            while (bytesSent < totalMessageLength)
            {
                if (message.Length * SOC <= FRAG_SIZE)
                {
                    msgFrag = message.ToCharArray();
                    encodedMsgLengthByte = intToByteArray(encode_natural(msgFrag.Length * SOC, 0));
                    Console.WriteLine(" -About to send last fragment. Length is " + msgFrag.Length * SOC + " bytes");
                }
                else
                {
                    msgFrag = message.Substring(0, FRAG_SIZE).ToCharArray();
                    message = message.Substring(FRAG_SIZE, message.Length);
                    encodedMsgLengthByte = intToByteArray(encode_natural(msgFrag.Length, 1));
                    Console.WriteLine("-About to send fragment. Length is " + msgFrag.Length * SOC + " bytes");
                }
                Console.WriteLine("-Sending...:'" + msgFrag + "'");
                //Send msg length
                numBytes = socket.Client.Send(encodedMsgLengthByte, sizeof(int), SocketFlags.None);

                if (numBytes < 1)
                {
                    Console.WriteLine("ERROR, failed to send encodedMsgLengthByte");
                    return false;
                }


                //Send length
                numBytes = socket.Client.Send(UnicodeEncoding.UTF8.GetBytes(msgFrag), msgFrag.Length * SOC, SocketFlags.None);
                if (numBytes < 1)
                {
                    Console.WriteLine("failed to send encodedMsgLengthByte");
                    return false;
                }

                bytesSent += msgFrag.Length * SOC;
                
            }
            return true;
        }

        private int byteArrayToInt(byte[] b)
        {
            return (b[0] << 24) + ((b[1] & 0xFF) << 16) + ((b[2] & 0xFF) << 8) + (b[3]
            & 0xFF);
        }

        private byte[] intToByteArray(int i)
        {
            byte[] bb = { 0, 0, 0, 0 };
            bb[0] = (byte)(i >> 24);
            bb[1] = (byte)(i >> 16);
            bb[2] = (byte)(i >> 8);
            bb[3] = (byte)i;
            return bb;
        }

        private int encode_natural(int i, int flag)
        {
            if (i > 0x7FFFFFFF)
            {
                return 0;
            }
            else
            {
                return (int)((i << 1) + flag);
            }
        }

        private int decode_natural(int i)
        {
            return (i >> 1);
        }

        private int decode_flag(int i)
        {
            return (i & 1);
        }
    }
}
