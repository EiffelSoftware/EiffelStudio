using System;
using System.Collections.Generic;
using System.Text;

namespace Xebra
{
    interface XLogger
    {
        void Debug(String msg);
        void Error(String msg);
        void Warning(String msg);
        void Info(String msg);            
    }
}
