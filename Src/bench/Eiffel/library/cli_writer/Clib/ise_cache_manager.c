/* this file contains the actual definitions of */
/* the IIDs and CLSIDs */

/* link this file in with the server and any clients */


/* File created by MIDL compiler version 5.01.0164 */
/* at Wed Aug 28 18:50:53 2002
 */
/* Compiler settings for ise_cache_manager.idl:
    Os (OptLev=s), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )
#ifdef __cplusplus
extern "C"{
#endif 


#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

const IID LIBID_emitter = {0xA59E5115,0x65ED,0x3635,{0xBD,0xEA,0x6A,0xC3,0x57,0x7E,0x32,0xF4}};


const IID IID_ISE_Cache_COM_ISE_CACHE_MANAGER = {0xE3526F85,0xA118,0x3FBC,{0xB4,0x45,0x41,0x74,0x52,0xD1,0xAA,0xA5}};


const IID IID_ISE_Cache_COM_ASSEMBLY_INFORMATION = {0xFD2F67FF,0xFF44,0x3B67,{0xA5,0x5D,0x8E,0xE3,0x08,0x6D,0x39,0x70}};


const CLSID CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER = {0x01BDF738,0x3044,0x3ED6,{0xBA,0x7B,0x34,0x63,0x2D,0x67,0xE1,0x45}};


#ifdef __cplusplus
}
#endif

