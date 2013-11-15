/*
 * description: "Provides methods to connect to a xebra server, to send and receive string messages."
 * date:	"$Date: 2009-05-01 11:33:29 -0700 (Fri, 01 May 2009) $"
 * revision:	"$Revision: 78473 $"
 * copyright:	"Copyright (c) 1985-2007, Eiffel Software."
 * license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
 * licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
 * copying: ""
 * source: 	"[
 * 			Eiffel Software
 * 			5949 Hollister Ave #B, Goleta, CA 93117
 * 			Telephone 805-685-1006, Fax 805-685-6869
 * 			Website http://www.eiffel.com
 * 			Customer support http://support.eiffel.com
 * 			]"
 */

﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Diagnostics;
using System.Net.Sockets;

namespace Xebra
{
    /// <summary>
    /// Provides methods to connect to a xebra server, to send and receive string messages.
    /// </summary>
    class XServerConnection
    {

        #region Fields
        /// <summary>
        /// The Socket
        /// </summary>
        TcpClient socket;

        /// <summary>
        /// The logger to store debug and error messages
        /// </summary>
        XLogger log;

        /// <summary>
        /// The config info read from the web.config file
        /// </summary>
        XConfig config;
  
        #endregion
        
        #region Constants
        /// <summary>
        /// The maximal size of a message fragment
        /// </summary>
        private static int FRAG_SIZE = 65536;

        /// <summary>
        /// The maximal number of fragments of a message
        /// </summary>
        private static int MAX_FRAGS = 1000;

        #endregion


        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="log">A logger to write debug and error messages</param>     
        /// <param name="config">A configuration</param>
        public XServerConnection(XLogger log, XConfig config)
        {
            this.config = config;
            this.log = log;
        }

        /// <summary>
        /// Connects to the server
        /// </summary>
        /// <returns>Returns true if a connection could be established</returns>
        public bool connect()
        {
            try
            {
                socket = new TcpClient(config.Host, config.Port);
                return true;
            }
            catch
            {
                log.Error("Cannot connect the Xebra Server.");
                return false;
            }
        }

        /// <summary>
        /// Sends a string to the server
        /// </summary>
        /// <param name="message">The message</param>
        /// <returns>Returns true if there was no error</returns>
        public bool sendMessage(String message)
        {
            if (socket == null)
            {
                log.Error("Not connected!");
                return false;
            }
            byte[] msgFragAndLength = new byte[FRAG_SIZE + 4];
            byte[] encodedMsgLengthByte = new byte[4];
            int bytesSent = 0;
            int numBytes = 0;
            byte[] messageByte = Encoding.UTF8.GetBytes(message);
            uint totalMessageLength = (uint)messageByte.Length;
            string oute;

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
                    numBytes = socket.Client.Send(msgFragAndLength, msgFragAndLength.Length, SocketFlags.None);                    
                }
                else
                {
                    encodedMsgLengthByte = System.BitConverter.GetBytes((int)XEncoder.encodeNatural(totalMessageLength - (uint)bytesSent, 0));
                    //Convert to bigendian
                    Array.Reverse(encodedMsgLengthByte);

                    System.Buffer.BlockCopy(encodedMsgLengthByte, 0, msgFragAndLength, 0, encodedMsgLengthByte.Length);
                    System.Buffer.BlockCopy(messageByte, bytesSent, msgFragAndLength, encodedMsgLengthByte.Length, (int)totalMessageLength - (int)bytesSent);

                    oute = System.Text.ASCIIEncoding.ASCII.GetString(msgFragAndLength);                    
                    numBytes = socket.Client.Send(msgFragAndLength, (int)totalMessageLength - (int)bytesSent + 4, SocketFlags.None);
                   
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
            return true;
        }
        
        /// <summary>
        /// Waits to receive a string from the server
        /// </summary>
        /// <param name="responseMessage">Used to store the received message</param>
        /// <returns>Returns true if no error occurred during receiving</returns>
        public bool receiveMessage(out string responseMessage)
        {
            bool flag = false;
            byte[] encodedLengthByte = new byte[4];
            uint encodedLength;
            uint length;
            int fragCounter = 0;
            int numBytes;
            string message = "";
            byte[] msgBuf = new byte[FRAG_SIZE + 4];
            responseMessage = "";
            do
            {
                //Read Length
                numBytes = socket.Client.Receive(encodedLengthByte, 4, SocketFlags.None);
                if (numBytes != 4)
                {
                    log.Error("Could not receive 4 bytes for length.");
                    return false;
                }
                //Convert to littleEndian
                Array.Reverse(encodedLengthByte);

                encodedLength = System.BitConverter.ToUInt32(encodedLengthByte, 0);
                length = XEncoder.decodeNatural(encodedLength);
                flag = XEncoder.decodeFlag(encodedLength);

       
                if (length < 1 || length > FRAG_SIZE)
                {
                    log.Error("Illegal msg length " + length);
                    return false;
                }

                //Read Msg
                numBytes = socket.Client.Receive(msgBuf, (int)length, SocketFlags.None);
                message += System.Text.ASCIIEncoding.ASCII.GetString(msgBuf).Substring(0,numBytes);

                if (fragCounter > MAX_FRAGS)
                {
                    log.Error ("Maximum fragments reached, aborting.");
                    return false;
                }

                fragCounter++;
            } while (flag);
            responseMessage = message;
            return true;
        }         
    }
}
