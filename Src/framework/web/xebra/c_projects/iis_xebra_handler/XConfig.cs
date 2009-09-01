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


using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace Xebra
{
    class XConfig
    {

        public XConfig(HttpRequest request, XLogger log)
        {
            System.Configuration.Configuration confg =
                           System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration(request.ApplicationPath);
            if (confg.AppSettings.Settings.Count > 0)
            {
                System.Configuration.KeyValueConfigurationElement portPair =
                    confg.AppSettings.Settings["XebraServerPort"];

                if (null != portPair)
                {
                    this.port = int.Parse(portPair.Value);
                }
                else
                {
                    log.Error("Missing property in web.config: XebraServerPort");
                }

                System.Configuration.KeyValueConfigurationElement hostPair =
                    confg.AppSettings.Settings["XebraServerHost"];

                if (null != hostPair)
                {
                    this.host = hostPair.Value;
                }
                else
                {
                    log.Error("Missing property in web.config: XebraServerHost");
                }

                System.Configuration.KeyValueConfigurationElement maxUploadSizePair =
                    confg.AppSettings.Settings["MaxUploadSize"];

                if (null != maxUploadSizePair)
                {
                    this.maxUploadSize = int.Parse(maxUploadSizePair.Value);
                }
                else
                {
                    log.Error("Missing property in web.config: MaxUploadSize");
                }

                System.Configuration.KeyValueConfigurationElement uploadSavePathPair =
                    confg.AppSettings.Settings["UploadSavePath"];

                if (null != uploadSavePathPair)
                {
                    this.uploadSavePath = uploadSavePathPair.Value;
                    if (!this.uploadSavePath.EndsWith("\\"))
                    {
                        this.uploadSavePath += "\\";
                    }
                }
                else
                {
                    log.Error("Missing property in web.config: UploadSavePath");
                }
            }
            else
            {
                log.Error("No properties found in web.config");
            }         
        }

        #region Properties

        /// <summary>
        /// The port on which the xebra server listens
        /// </summary>
        public int Port
        {
            get { return port; }
        }

        /// <summary>
        /// The host address of xebra server
        /// </summary>
        public string Host
        {
            get { return host; }
        }

        /// <summary>
        /// The maximum file upload size
        /// </summary>
        public int MaxUploadSize
        {
            get { return maxUploadSize; }
        }

        /// <summary>
        /// The location where uploaded files are temporarily stored
        /// </summary>
        public string UploadSavePath
        {
            get { return uploadSavePath; }
        }

        #endregion

        #region Fields

        private string uploadSavePath;

        private int maxUploadSize;

        private int port;

        private string host;

        #endregion
    }
}
