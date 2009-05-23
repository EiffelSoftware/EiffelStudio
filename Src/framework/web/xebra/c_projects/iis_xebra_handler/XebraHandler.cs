using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Net.Sockets;
using System.IO;
using System.Diagnostics;

namespace Xebra
{
    class XebraHandler : IHttpHandler
    {
        #region IHttpHandler Members

        public bool IsReusable
        {
            get { return true; }
        }
        
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
            EventLog.WriteEntry("XebraHandler", msg, type);
        }
        
        public void ProcessRequest(HttpContext context)
        {
            TcpClient socket;

            context.Response.Write("hello i'm xebra handler");


            try
            {
                Debug("Creating socket...");
                socket = new TcpClient("localhost", 55000);
                Debug("Connected.");
            }
            catch
            {
                Error("Cannot connect the Xebra Server.");
                return;
            }

            if (sendMessage(socket, fakeRequest, context))
            {
                //context.Response.Write(receiveMessage(socket, context));

            }

          
            Debug("Hi this is IIS7 XebraHandler, connection ok");



            socket.Close();
            //Debug(error_msg);
            //String.Format("<h1>{0}</h1>",
            //               dt.ToLongTimeString()
            //               ));
        }

        #endregion

        String error_msg = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title>Xebra Module - Error Report</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><style type=\"text/css\"><!--body,td,th {	font-family: Geneva, Arial, Helvetica, sans-serif;	font-size: 12px;}h1 {	font-size: 18px;	background-color:#000000;	color: #FFFFFF;}h3 {	font-size: 14px;	background-color:#000000;	color: #FFFFFF;}.em {font-size: 14px;background-color:#000000;color: #FFFFFF;margin-right: 10px;font-weight: bold;}--></style></head><body><h1>Xebra Module - Error Report</h1><hr/><p><span class=\"em\">Message: </span>Not implemented</p><p><img src=\"http://www.yiyinglu.com/failwhale/images/failwhale.gif\" alt=\"fail whale image\" width=\"800\" height=\"432\" /></p><hr /><h3>Xebra Module $Revision: 78721 $</h3></body></html>";
      //  String fakeRequest = "GET /xebrawebapp/hello.xeb?name=test&pass=123 HTTP/1.1#HI##$#Host#%#localhost#$#User-Agent#%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.10) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#$#Accept-Language#%#en-us,en;q=0.5#$#Accept-Encoding#%#gzip,deflate#$#Accept-Charset#%#ISO-8859-1,utf-8;q=0.7,*;q=0.7#$#Keep-Alive#%#300#$#Connection#%#keep-alive#E##HO##E##SE##E##A#&name=test&pass=123#E#";
        String fakeRequest = "ABCDEFGHIJKLMNOP";          
        int FRAG_SIZE = 65536;



        private bool sendMessage(TcpClient socket, String message, HttpContext context)
        {
        //   char[] msgFrag = new char[FRAG_SIZE + 1];
            byte[] msgFragAndLength = new byte[FRAG_SIZE + 5];
            byte[] encodedMsgLengthByte = new byte[4];
            int bytesSent = 0;
            int numBytes = 0;
            byte[] messageByte = Encoding.UTF8.GetBytes(message);
            int totalMessageLength = messageByte.Length;

            Debug("About to send message '" + message + "'. Length is " + totalMessageLength + "bytes");


            encodedMsgLengthByte = intToByteArray(encode_natural(totalMessageLength, 0));

            System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
            System.Buffer.BlockCopy(messageByte, 0, msgFragAndLength, encodedMsgLengthByte.Length - 1, messageByte.Length);
            

            numBytes = socket.Client.Send(msgFragAndLength, msgFragAndLength.Length, SocketFlags.None);
            if (numBytes < 1)
            {
                Error("Failed to send encodedMsgLengthByte");
                return false;
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

        private String receiveMessage(TcpClient socket, HttpContext context)
        {
            int flag = 0;
            int numBytes = 0;
            byte[] fragLengthEncByte = new Byte[sizeof(int)];
            int fragLengthEnc;
            int fragLength;
            byte[] buf = new Byte[FRAG_SIZE  + 1];
            char[] fragfragBuf = new Char[FRAG_SIZE  + 1];
            String fragBuf = "";
            int bytesRecv = 0;
            String message = "";

            Debug("Receiving message...");

            do
            {
                //Receive the fragment length
                numBytes = socket.Client.Receive(fragLengthEncByte, sizeof(int), SocketFlags.None);
                if (numBytes != sizeof(int))
                {
                    Debug("Failed to receive fragment length. Received " + numBytes + " bytes instead of " + sizeof(int) + " bytes");
                    return "";
                }
                                
                fragLengthEnc = byteArrayToInt(fragLengthEncByte);
                fragLength = decode_natural(fragLengthEnc);
                flag = decode_flag(fragLengthEnc);

                 Debug ("Incoming frag, "+fragLength+" bytes, flag is "+flag);

                numBytes = 0;
                while (bytesRecv < fragLength)
                {
                    numBytes = socket.Client.Receive(buf, fragLength, SocketFlags.None);
                    if (numBytes < 1)
                    {
                        Debug("Failed to receive message. numbytes=" + numBytes);
                        return "";
                    }
                     fragfragBuf = UnicodeEncoding.UTF8.GetChars(buf);
                    fragfragBuf[numBytes] = '\0';

                    fragBuf = fragBuf + fragfragBuf.ToString();
                    bytesRecv += numBytes;
                }

                if (bytesRecv != fragLength)
                {
                    Debug("ERROR, received bytes=" + bytesRecv + ", fragLengh is " + fragLength);
                    return "";
                }

                Debug("Recieved " + bytesRecv + " bytes:'" + fragBuf + "'");
                message = message + fragBuf;

            } while (flag == 1);

            Debug("Completed recieving message.");
            return message;
        }

       

        //private int byteArrayToInt(byte[] b)
        //{
        //    return (b[0] << 24) + ((b[1] & 0xFF) << 16) + ((b[2] & 0xFF) << 8) + (b[3]
        //    & 0xFF);
        //}

        //private byte[] intToByteArray(int i)
        //{
        //    byte[] bb = { 0, 0, 0, 0 };
        //    bb[0] = (byte)(i >> 24);
        //    bb[1] = (byte)(i >> 16);
        //    bb[2] = (byte)(i >> 8);
        //    bb[3] = (byte)i;
        //    return bb;
        //}

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
