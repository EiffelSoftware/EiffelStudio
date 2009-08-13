/*
 * description: "IIS7 Handler that sends request data to xebra server and receives page to be displayed."
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
using System.Web;
using System.Net.Sockets;
using System.IO;
using System.Diagnostics;
using System.Collections.Specialized;
using System.Collections;

namespace Xebra
{
    /// <summary>
    /// The XHandler handles a http request. It creates a request message that is sent
    /// to the xebra server. Then it receives a response message which contains cookie
    /// orders and the html text that is then forwardet to IIS.
    /// </summary>
    class XHandler : IHttpHandler
    {
        #region Constants

        /// <summary>
        /// The key in the request message that represents the start of the html code
        /// </summary>
        private static string HTML_START = "#H#";

        /// <summary>
        /// The key in the request message that represents the start of the headers_in
        /// </summary>
        private static string HEADERS_IN = "#HI#";

        /// <summary>
        /// The key in the request message that represents the start of the headers_out
        /// </summary>
        private static string HEADERS_OUT = "#HO#";

        /// <summary>
        /// The key in the request message that represents the start of the SUBPROCESS_ENVIRONMENT_VARS
        /// </summary>
        private static string SUBPROCESS_ENVIRONMENT_VARS = "#SE#";

        /// <summary>
        /// The key in the request message that represents the end of a table
        /// </summary>
        private static string END = "#E#";

        /// <summary>
        /// The string for method POST
        /// </summary>
        private static string POST = "POST";

        /// <summary>
        /// The default encoding of the request content
        /// </summary>
        private static string DEFAULT_ENCODING = "HTTP/1.1";

        /// <summary>
        /// The key in the request message that splits two header key/value pairs
        /// </summary>
        private static string HKEY = "#$#";

        /// <summary>
        /// The key in the request message that splits a header key and a header value
        /// </summary>
        private static string HVALUE = "#%#";

        /// <summary>
        /// The key in the request message that represents the start of the arguments
        /// </summary>
        private static string ARGUMENTS = "#A#";

        /// <summary>
        /// The key in the request message that splits two argument key/value pairs
        /// </summary>
        private static string AKEY = "#$#";

        /// <summary>
        /// The key in the request message that splits a argument key and an argument value
        /// </summary>
        private static string AVALUE = "=";

        /// <summary>
        /// The html message that is displayed on an error
        /// </summary>
        private static string ERRORMSG = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title>Xebra Handler - Error Report</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><style type=\"text/css\"><!--body,td,th {	font-family: Geneva, Arial, Helvetica, sans-serif;	font-size: 12px;}h1 {	font-size: 18px;	background-color:#000000;	color: #FFFFFF;}h3 {	font-size: 14px;	background-color:#000000;	color: #FFFFFF;}.em {font-size: 14px;background-color:#000000;color: #FFFFFF;margin-right: 10px;font-weight: bold;}--></style></head><body><h1>Xebra Handler - Error Report</h1><hr/><p><span class=\"em\">Message: </span>Internal Server Error. See error log.</p><hr /><h3>Xebra Handler for IIS7 Pre-Release</h3></body></html>";

        /// <summary>
        /// The Content-Type for file uploads
        /// </summary>
        private static string CT_MULTIPART_FORM_DATA = "multipart/form-data";

        /// <summary>
        /// The Content-Type for form submits
        /// </summary>
        private static string CT_APP_FORM_URLENCODED = "application/x-www-form-urlencoded";

        /// <summary>
        /// This flag is used to tell xebra server that a file was uploaded using IIS and and it has to be processed differently
        /// </summary>
        private static string FILE_UPLOAD_FLAG = "#FUPI#";


        #endregion

        #region Fields

        /// <summary>
        /// The log to write debug and error messages
        /// </summary>
        XLogger log;

        /// <summary>
        /// The connection to the xebra server
        /// </summary>
        XServerConnection srv;

        #endregion

        #region IHttpHandler Members

        /// <summary>
        /// Specifies that this handler does not handle the request exclusively
        /// </summary>
        public bool IsReusable
        {
            get { return true; }
        }

        /// <summary>
        /// The main routine of the handler. Creates a request message and sends it to the server. The request message is of the following format:
        /// REQUEST = HEADER HEADERS_IN HEADERS_OUT SUBPROCESS_ENVIRONMENT_VARS ARGS;
        /// 
        /// HEADER = KEY_METHOD KEY_SPACE url KEY_SPACE KEY_HTTP;
        /// HEADERS_IN = KEY_HI {TABLE_ENTRY}  KEY_END;
        /// HEADERS_OUT = KEY_HO {TABLE_ENTRY} KEY_END;
        /// SUBPROCESS_ENVIRONMENT_VARS = KEY_SE TABLE_ENTRIES KEY_END;
        /// TABLE_ENTRY = KEY_T_NAME item_name KEY_T_VALUE item_value;
        /// ARGS = KEY_ARG args;
        /// 
        /// KEY_METHOD = "GET" | "POST";
        /// KEY_HTTP = "HTTP/1.1" | "HTTP/1.0";
        /// KEY_SPACE = " ";
        /// KEY_HI = "#HI#";
        /// KEY_HO = "#HO#";
        /// KEY_END = "#E#";
        /// KEY_SE = "#SE#";
        /// KEY_T_NAME = "#$#";
        /// KEY_T_VALUE = "#%#";
        /// KEY_ARG = "#A#";
        /// </summary>
        /// <param name="context">The current http context<guer/param>
        public void ProcessRequest(HttpContext context)
        {
            string requestMsg;
            string responseMsg = "";
            HttpRequest request = context.Request;
            log = new XWindowsLogger();

            srv = new XServerConnection(log);
            if (srv.connect())
            {
                requestMsg = request.RequestType +                      // Method
                    " " +                                               // Space
                    request.RawUrl +                                    // Url
                    " " + DEFAULT_ENCODING +                            // Encoding
                    HEADERS_IN + EncodeHeader(request.Headers) + END +  // HEADERS_IN
                    HEADERS_OUT + END +                                 // No HEADERS_OUT
                    SUBPROCESS_ENVIRONMENT_VARS + END +                 // No SUBPROCESS_ENV_VARS
                    ARGUMENTS +                                         // ARGS
                    "";

                /* If there are, read POST or GET parameters into message buffer */
                if (request.RequestType.Equals(POST))
                {
                    /* If the Content-Type is CT_MULTIPART_FORM_DATA save the post data to a file and don't append it to the message */
                    if (request.ContentType.StartsWith(CT_MULTIPART_FORM_DATA))
                    {
                        if (request.Files.Keys.Count == 1)
                        {
                            string tempFileName = getTmpFileName("C:\\tmp\\");
                            requestMsg += FILE_UPLOAD_FLAG + tempFileName;
                            request.Files.Get(0).SaveAs(tempFileName);
                        }
                        else
                        {
                            context.Response.Write(ERRORMSG);
                        }
                    }
                    else
                    {
                        /* If the Content-Type is CT_APP_FORM_URLENCODED encode the data in a form layout */
                        if (request.ContentType.Equals(CT_APP_FORM_URLENCODED))
                        {
                            requestMsg += EncodeArgs(request.Form);
                        }
                        else
                        {
                            if (request.InputStream.CanRead)
                            {
                                byte[] buf = new byte[(int)request.InputStream.Length];
                                request.InputStream.Read(buf, 0, (int)request.InputStream.Length);
                                requestMsg += System.Text.ASCIIEncoding.ASCII.GetString(buf);

                            }
                            else
                            {
                                context.Response.Write(ERRORMSG);
                            }
                        }
                    }
                }
                else
                {
                    /* If its not a POST request, simply append the (GET) args to the message */
                    requestMsg += EncodeArgs(request.QueryString);
                }

                log.Debug("Incoming request: " + requestMsg);
                if (srv.sendMessage(requestMsg))
                {
                    responseMsg = srv.receiveMessage();
                }
            }
            if (responseMsg.Equals(""))
            {
                context.Response.Write(ERRORMSG);
            }
            else
            {
                if (responseMsg.Contains(HTML_START))
                {
                    XCookieBakery.createCookies(responseMsg, context);
                    responseMsg = responseMsg.Substring(responseMsg.IndexOf(HTML_START) + HTML_START.Length);
                    context.Response.Write(responseMsg);
                }
                else
                    context.Response.Write(ERRORMSG);
            }
        }

        /// <summary>
        /// Generates a random file name that does not exist in the specified directory.
        /// </summary>
        /// <param name="dir">The directory in which the file name should be used later</param>
        /// <returns>The generated file name</returns>
        private string getTmpFileName(string dir)
        {
            string prefix = "xebra_upload.";
            Random r = new Random((int)DateTime.Now.Ticks);
            string fm;
            do
            {
                fm = prefix;
                for (int i = 0; i < 6; i++)
                {
                    fm = fm + (char)(97 + Math.Floor(r.NextDouble() * 25));
                }
            } while (File.Exists(dir + fm));
            return dir + fm;
        }

        #endregion

        /// <summary>
        /// Encodes pairs of keys and values with header syntax
        /// </summary>
        /// <param name="pair">The pairs</param>
        /// <returns>The encoded pairs</returns>
        private string EncodeHeader(NameValueCollection pairs)
        {
            return EncodePair(pairs,  HKEY, HVALUE);
        }

        /// <summary>
        /// Encodes pairs of keys and values with argument syntax
        /// </summary>
        /// <param name="pair">The pairs</param>
        /// <returns>The encoded pairs</returns>
        private string EncodeArgs(NameValueCollection pairs)
        {
            return EncodePair(pairs, AKEY, AVALUE);
        }

        /// <summary>
        /// Creates a string out of key value pairs: RESULT = {afix pair.key bfix pair.value}
        /// </summary>
        /// <param name="pair">The pairs</param>
        /// <param name="afix">Is put before keys</param>
        /// <param name="bfix">Is put before values</param>
        /// <returns>The encoded pairs</returns>
        private string EncodePair(NameValueCollection pair,  string afix, string bfix)
        {
            string result = "";
            for (int i = 0; i < pair.Count; i++)
            {
                result += afix + pair.GetKey(i) + bfix + pair.Get(i);
            }
            return result;
        }
    }
}
