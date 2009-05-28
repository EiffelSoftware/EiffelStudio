using System;
using System.Collections.Generic;
using System.Text;

namespace Xebra
{
    /// <summary>
    /// Provides methodes to encode and decode integers with fragments flags.
    /// </summary>
    class XEncoder
    {
        /// <summary>
        /// Converts an array of byte to integer32
        /// </summary>
        /// <param name="b"></param>
        /// <returns></returns>
        public static int byteArrayToInt(byte[] b)
        {
            //return (b[0] << 24) + ((b[1] & 0xFF) << 16) + ((b[2] & 0xFF) << 8) + (b[3]
            //& 0xFF);
            return System.BitConverter.ToInt32(b, 0);
        }

        /// <summary>
        /// Converts an int32 to a byte array
        /// </summary>
        /// <param name="i"></param>
        /// <returns></returns>
        public static byte[] intToByteArray(int i)
        {
            //byte[] bb = { 0, 0, 0, 0 };
            //bb[0] = (byte)(i >> 24);
            //bb[1] = (byte)(i >> 16);
            //bb[2] = (byte)(i >> 8);
            //bb[3] = (byte)i;
            return System.BitConverter.GetBytes(i);
        }

        /// <summary>
        /// Encodes an unsigned int to include a flag
        /// </summary>
        /// <param name="i">The unsigned int</param>
        /// <param name="flag">The flag</param>
        /// <returns>The encoded unsigned int</returns>
        public static uint encodeNatural(uint i, uint flag)
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

        /// <summary>
        /// Extracts the unsigned int from an encoded unsigned int
        /// </summary>
        /// <param name="i">The encoded unsigned int</param>
        /// <returns>The decoded unsigned int</returns>
        public static uint decodeNatural(uint i)
        {
            return (i >> 1);
        }

        /// <summary>
        /// Extracts a flag from an unsigned int
        /// </summary>
        /// <param name="i">The encoded unsigned int</param>
        /// <returns>The flag</returns>
        public static bool decodeFlag(uint i)
        {
            return ((i & (uint)1) == 1);
        }              
    }
}

