

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0365 */
/* at Mon Dec 31 14:54:43 2012
 */
/* Compiler settings for metadata_consumer.idl:
    Oicf, W1, Zp8, env=Win64 (32b run)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#pragma warning( disable: 4049 )  /* more than 64k source lines */


#ifdef __cplusplus
extern "C"{
#endif 


#include <rpc.h>
#include <rpcndr.h>

#ifdef _MIDL_USE_GUIDDEF_

#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)

#else // !_MIDL_USE_GUIDDEF_

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

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        const type name = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

#endif !_MIDL_USE_GUIDDEF_

MIDL_DEFINE_GUID(IID, LIBID_EiffelSoftware_MetadataConsumer,0x8E61CD57,0x7F8F,0x3AB5,0xB3,0xBB,0x76,0x95,0x22,0x53,0x80,0x2B);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER,0x2C108F65,0x24F1,0x4E93,0xBF,0xAE,0x32,0x62,0x93,0x7B,0x5D,0x31);


MIDL_DEFINE_GUID(CLSID, CLSID_EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER,0x64E0AD08,0x417E,0x4243,0xB5,0x33,0x56,0x1A,0x05,0xF4,0xB5,0xE6);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



