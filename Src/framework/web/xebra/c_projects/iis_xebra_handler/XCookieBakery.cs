/*
* description:  "Provides methods to parse a xebra response message in order to add cookies to a html context response."
* date:		"$Date: 2009-05-15 15:41:52 -0700 (Fri, 15 May 2009) $"
* revision:	"$Revision: 78721 $"
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

namespace Xebra
{
    /// <summary>
    /// Provides methods to parse a xebra response message in order to add
    /// cookies to a html context response.
    /// </summary>
    class XCookieBakery
    {
        #region Constants
        /// <summary>
        /// The key in the response message that represents the start of a cookie order
        /// </summary>
        private static string COOKIE_START = "#C#";

        /// <summary>
        /// The key in the repsonse message that represents the end of a cookie order
        /// </summary>
        private static string COOKIE_END = "#CE#";

        /// <summary>
        /// The key in a cookie order for the domain
        /// </summary>
        private static string COOKIE_DOMAIN = "Domain";

        /// <summary>
        /// The key in a cookie order for the max age
        /// </summary>
        private static string COOKIE_MAXAGE = "Max-Age";

        /// <summary>
        /// The key in a cookie order for the path
        /// </summary>
        private static string COOKIE_PATH = "Path";

        /// <summary>
        /// The key in a cookie order for a secure cookie
        /// </summary>
        private static string COOKIE_SECURE = "Secure";

        /// <summary>
        /// The key in a cookie order for the version
        /// </summary>
        private static string COOKIE_VERSION = "Version";

        /// <summary>
        /// Equals symbol in cookie order
        /// </summary>
        private static string EQ = "=";

        /// <summary>
        /// Semicolon symbol in cookie order
        /// </summary>
        private static string SQ = ";";

        #endregion

        /// <summary>
        /// Parses the response message r, extracts the cookie orders and adds them to the html response
        /// The response message is expected to have to following form:
        ///   RESPONSE = {COOKIE_ORDER}*, HTML
        ///   HTML = "#H#", html_code
        ///   COOKIE_ORDER = "#C#", cookie_name, "=", cookie_value, COOKIE_OPT, ";Version=1#CE#"
        ///   COOKIE_OPT = [SQ, "Domain=", cookie_domain],
        ///                [SQ, "Max-Age=", cookie_max_age],
        ///                [SQ, "Path=", cookie_path],
        ///                [SQ, "Secure"]
        ///
        /// </summary>
        /// <param name="r">The response message</param>
        /// <param name="context">The current http context</param>
        /// 
        public static void createCookies(string r, HttpContext context)
        {
            HttpCookie c;
            string name;
            string value;

            while (r.Contains(COOKIE_START) && r.Contains(COOKIE_END))
            {
                r = r.Substring(r.IndexOf(COOKIE_START) + COOKIE_START.Length);
                name = r.Substring(0, r.IndexOf(EQ));
                r = r.Substring(r.IndexOf(EQ));
                value = r.Substring(EQ.Length, r.IndexOf(SQ) - SQ.Length);
                r = r.Substring(r.IndexOf(SQ) + SQ.Length);
                c = new HttpCookie((string)name.Clone(), (string)value.Clone());
                if (r.Contains(EQ))
                {
                    name = r.Substring(0, r.IndexOf(EQ));
                    //Read Domain
                    if (name.Equals(COOKIE_DOMAIN))
                    {
                        r = r.Substring(r.IndexOf(EQ));
                        value = r.Substring(EQ.Length, r.IndexOf(SQ) - SQ.Length);
                        c.Domain = (string)value.Clone();
                        r = r.Substring(r.IndexOf(SQ) + SQ.Length);
                    }
                }
                if (r.Contains(EQ))
                {
                    name = r.Substring(0, r.IndexOf(EQ));
                    //Read Max-Age
                    if (name.Equals(COOKIE_MAXAGE))
                    {
                        r = r.Substring(r.IndexOf(EQ));
                        value = r.Substring(EQ.Length, r.IndexOf(SQ) - SQ.Length);
                        c.Expires = DateTime.Now.AddSeconds(Convert.ToInt32(value));

                        r = r.Substring(r.IndexOf(SQ) + SQ.Length);
                    }
                }
                if (r.Contains(EQ))
                {
                    name = r.Substring(0, r.IndexOf(EQ));
                    //Read Path
                    if (name.Equals(COOKIE_PATH))
                    {
                        r = r.Substring(r.IndexOf(EQ));
                        value = r.Substring(EQ.Length, r.IndexOf(SQ) - SQ.Length);
                        c.Path = (string)value.Clone();
                        r = r.Substring(r.IndexOf(SQ) + SQ.Length);
                    }
                }
                if (r.Contains(SQ))
                {
                    name = r.Substring(0, r.IndexOf(SQ));
                    //Read Secure
                    if (name.Equals(COOKIE_SECURE))
                    {
                        c.Secure = true;
                        r = r.Substring(r.IndexOf(SQ) + SQ.Length);
                    }
                }
                //Version does not apply here              

                context.Response.Cookies.Add(c);

                //Remove COOKIE_END
                r = r.Substring(r.IndexOf(COOKIE_END) + COOKIE_END.Length);
            }
        }
    }
}
