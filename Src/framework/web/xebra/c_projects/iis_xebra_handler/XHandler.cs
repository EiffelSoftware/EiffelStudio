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
using System.Web;
using System.IO;
using System.Collections.Specialized;


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
        /// The string for method GET
        /// </summary>
        private static string GET = "GET";

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
        private static string AKEY = "&";

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

        /// <summary>
        /// This key is put before the original filename
        /// </summary>
        private static string FILE_NAME = "#FN#";

        /// <summary>
        /// The Content-Type string in the input stream of a file upload request
        /// </summary>
        private static string UPLOAD_CONTENT_TYPE = "Content-Type";



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

        /// <summary>
        /// The config info read from the web.config file
        /// </summary>
        XConfig config;

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
        /// The main routine of the handler. Creates a request message and sends it to the server. 
        /// </summary>
        /// <param name="context">The current http context<guer/param>
        public void ProcessRequest(HttpContext context)
        {          
            string requestMsg;
            bool ok = false;
            string responseMsg;
            HttpRequest request = context.Request;
            log = new XWindowsLogger();
            config = new XConfig(request, log);
            srv = new XServerConnection(log, config);
            

            if (buildRequestMessage(out requestMsg, request))
            {
                if (srv.connect())
                {
                    if (srv.sendMessage(requestMsg))
                    {
                        if (srv.receiveMessage(out responseMsg))
                        {
                            if (processResponse(ref responseMsg, context))
                            {
                                context.Response.Write(responseMsg);
                                ok = true;
                            }
                        }
                    }
                }
            }

            if (!ok)
            {
                context.Response.Write(ERRORMSG);
            }
        }

        /// <summary>
        /// Parses the request object and generated a request message string that can be sent to the xebra server.
        /// The request message is of the following format:
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
        /// <param name="requestMsg">The string to store the request message </param>
        /// <param name="request">The request object</param>
        /// <returns>Returns true on success</returns>
        private bool buildRequestMessage(out string requestMsg, HttpRequest request)
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

            //Check if ContentLength does not exceed MaxUploadSize
            if (request.ContentLength > config.MaxUploadSize)
            {
                log.Error("Error parsing uploaded file InputStream: Giving up finding filename.");
                return false;
            }

            /* If there are, read POST or GET parameters into message buffer */
            if (request.RequestType.Equals(POST))
            {
                /* If the Content-Type is CT_MULTIPART_FORM_DATA save the post data to a file and don't append it to the message */
                if (request.ContentType.StartsWith(CT_MULTIPART_FORM_DATA))
                {
                    if (request.Files.Keys.Count == 1)
                    {                      
                        // Save file to tmp file
                        string tempFileName = getTmpFileName(config.UploadSavePath);
                        requestMsg += FILE_UPLOAD_FLAG + tempFileName;
                        request.Files.Get(0).SaveAs(tempFileName);

                        //Parse header and append filename to requestMsg
                        int bufSize = 100;
                        int maxSize = 2000;
                        byte[] buf = new byte[bufSize];
                        string header = "";
                        string[] lines;
                        string[] lineFragments;
                        string filename;

                        do
                        {
                            request.InputStream.Read(buf, 0, bufSize);
                            header += System.Text.ASCIIEncoding.ASCII.GetString(buf);
                            if (header.Length > maxSize)
                            {
                                log.Error("Error parsing uploaded file InputStream: Giving up finding filename.");
                                return false;
                            }
                        } while (!header.Contains(UPLOAD_CONTENT_TYPE));

                        lines = header.Split('\n');

                        if (lines.Length >= 2)
                        {
                            lineFragments = lines[1].Split('"');
                            if (lineFragments.Length >= 4)
                            {
                                filename = lineFragments[3];
                                requestMsg += FILE_NAME + filename;
                                return true;
                            }
                            else
                            {
                                log.Error("Error parsing uploaded file InputStream: Unknown formatting.");
                                return false;
                            }
                        }
                        else
                        {
                            log.Error("Error parsing uploaded file InputStream: Not enough lines.");
                            return false;
                        }
                    }
                    else
                    {
                        log.Error("Expected uploaded files 1, actual " + request.Files.Keys.Count.ToString() + ".");
                        return false;
                    }
                }
                else
                {
                    /* If the Content-Type is CT_APP_FORM_URLENCODED encode the data in a form layout */
                    if (request.ContentType.Equals(CT_APP_FORM_URLENCODED))
                    {
                        requestMsg += EncodeArgs(request.Form);
                        return true;
                    }
                    else
                    {
                        /* In all other cases we just append the whole request body to the message */
                        byte[] buf = new byte[(int)request.InputStream.Length];
                        request.InputStream.Read(buf, 0, (int)request.InputStream.Length);
                        requestMsg += System.Text.ASCIIEncoding.ASCII.GetString(buf);
                        return true;
                    }
                }
            }
            else if (request.RequestType.Equals(GET))
            {
                /* If its a GET request simply append the args to the message */
                requestMsg += EncodeArgs(request.QueryString);
                return true;
            }
            else
            {
                /* If the method is not POST or GET we don't add any arguments */
                return true;
            }
        }

        /// <summary>
        /// Processes the received response message. Extracts cookies.
        /// </summary>
        /// <param name="responseMsg">The response mssage</param>
        /// <param name="context">The context</param>
        /// <returns>Returns true on success</returns>
        private bool processResponse(ref string responseMsg, HttpContext context)
        {
            if (responseMsg.Contains(HTML_START))
            {
                XCookieBakery.createCookies(responseMsg, context);
                responseMsg = responseMsg.Substring(responseMsg.IndexOf(HTML_START) + HTML_START.Length);
                return true;
            }
            else
            {
                log.Error("Received response message does not contain HTML_START.");
                return false;
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
            return EncodePair(pairs, HKEY, HVALUE);
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
        private string EncodePair(NameValueCollection pair, string afix, string bfix)
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
