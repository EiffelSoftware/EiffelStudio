using System;
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
    class XHandler : IHttpHandler
    {

        XLogger log;
        XServerConnection srv;

        #region IHttpHandler Members

        public bool IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            string requestMsg;
            string response = "";
            HttpRequest request = context.Request;

            log = new XWindowsLogger();

            srv = new XServerConnection(log);
            srv.connect();

            requestMsg = request.RequestType +                  // Method
                " " +                                           // Space
                request.RawUrl +                                // Url
                " HTTP/1.1" +                                   // Encoding
                EncodeHeader(request.Headers, "#HI#") +         // HEADERS_IN
                "#HO##E#" +                                     // (no) HEADERS_OUT
                //  EncodeHeader(request.ServerVariables, "#SE#") + // SUBPROCESS_ENV_VARS
                "";

            if (request.RequestType.Equals("POST"))
                requestMsg += EncodeArgs(request.Form);
            else
                requestMsg += EncodeArgs(request.QueryString);

            log.Debug("Incoming request: " + requestMsg);
            if (srv.sendMessage(requestMsg))
            {
                response = srv.receiveMessage();
                if (response.Equals(""))
                    context.Response.Write(errorResponse);
                else
                    context.Response.Write(response);
            }
            else
                context.Response.Write(errorResponse);

        }
        #endregion

        private string EncodeHeader(NameValueCollection pair, string prefix)
        {
            return EncodePair(pair, prefix, "#$#", "#%#", "#E#");
        }

        private string EncodeArgs(NameValueCollection pair)
        {
            return EncodePair(pair, "#A#", "#$#", "=", "#E#");
        }

        private string EncodePair(NameValueCollection pair, string prefix, string afix, string bfix, string postfix)
        {
            string result = prefix;
            for (int i = 0; i < pair.Count; i++)
            {
                result += afix + pair.GetKey(i) + bfix + pair.Get(i);
            }
            return result + postfix;
        }

        String errorResponse = "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title>Xebra IIS Handler - Error Report</title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><style type=\"text/css\"><!--body,td,th {	font-family: Geneva, Arial, Helvetica, sans-serif;	font-size: 12px;}h1 {	font-size: 18px;	background-color:#000000;	color: #FFFFFF;}h3 {	font-size: 14px;	background-color:#000000;	color: #FFFFFF;}.em {font-size: 14px;background-color:#000000;color: #FFFFFF;margin-right: 10px;font-weight: bold;}--></style></head><body><h1>Xebra Module - Error Report</h1><hr/><p><span class=\"em\">Message: </span>Internal Server Error. See error log.</p><p><img src=\"http://www.yiyinglu.com/failwhale/images/failwhale.gif\" alt=\"fail whale image\" width=\"800\" height=\"432\" /></p><hr /><h3>Xebra IIS Handler</h3></body></html>";
        String fakeRequest = "GET /xebrawebapp/hello.xeb?name=test&pass=123 HTTP/1.1#HI##$#Host#%#localhost#$#User-Agent#%#Mozilla/5.0 (X11; U; Linux x86_64; en; rv:1.9.0.10) Gecko/20080528 Epiphany/2.22 Firefox/3.0#$#Accept#%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#$#Accept-Language#%#en-us,en;q=0.5#$#Accept-Encoding#%#gzip,deflate#$#Accept-Charset#%#ISO-8859-1,utf-8;q=0.7,*;q=0.7#$#Keep-Alive#%#300#$#Connection#%#keep-alive#E##HO##E##SE##E##A#&name=test&pass=123#E#";
        //  String fakeRequest = "ABCDEFGHIJKLMNOP";                
    }



}
