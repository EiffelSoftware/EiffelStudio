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
