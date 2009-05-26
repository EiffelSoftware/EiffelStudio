using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace XebraHandlerTester
{
    class Encoder
    {
        public static int byteArrayToInt(byte[] b)
        {
            //return (b[0] << 24) + ((b[1] & 0xFF) << 16) + ((b[2] & 0xFF) << 8) + (b[3]
            //& 0xFF);
            return System.BitConverter.ToInt32(b, 0);
        }

        public static byte[] intToByteArray(int i)
        {
            //byte[] bb = { 0, 0, 0, 0 };
            //bb[0] = (byte)(i >> 24);
            //bb[1] = (byte)(i >> 16);
            //bb[2] = (byte)(i >> 8);
            //bb[3] = (byte)i;
            return System.BitConverter.GetBytes(i);
        }

        public static uint encode_natural(uint i, uint flag)
        {
            if (i > 0x7FFFFFFF)
            {
                return 0;
            }
            else
            {
                return (uint)((i << 1) + flag);
            }
        }

        public static uint decode_natural(uint i)
        {
            return (i >> 1);
        }

        public static bool decode_flag(uint i)
        {
            return ((i & (uint)1) == 1);
        }

        internal static int decode_natural(object p)
        {
            throw new NotImplementedException();
        }
    }
}
