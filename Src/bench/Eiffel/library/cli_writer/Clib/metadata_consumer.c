

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0361 */
/* at Tue Sep 21 15:03:38 2004
 */
/* Compiler settings for metadata_consumer.idl:
    Oicf, W1, Zp8, env=Win32 (32b run)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#if !defined(_M_IA64) && !defined(_M_AMD64)


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

MIDL_DEFINE_GUID(IID, LIBID_EiffelSoftware_MetadataConsumer,0x6B69F95D,0xCEF9,0x317E,0x96,0xD9,0x2F,0x5C,0x12,0xF2,0x6F,0xE9);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER,0xE1FFE160,0x8346,0x4145,0xB9,0x94,0x96,0x77,0xFA,0x8E,0x27,0x5A);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION,0xE1FFE194,0xCC9A,0x4E3A,0x9B,0xFE,0x84,0xCC,0x4C,0x87,0x0C,0xD9);


MIDL_DEFINE_GUID(CLSID, CLSID_EiffelSoftware_MetadataConsumer_Interop_Impl_COM_CACHE_MANAGER,0xE1FFE19B,0x24F2,0x4523,0xA7,0xD0,0x5A,0xDF,0x4D,0x2B,0x81,0x46);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/



/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0361 */
/* at Tue Sep 21 15:03:38 2004
 */
/* Compiler settings for metadata_consumer.idl:
    Oicf, W1, Zp8, env=Win64 (32b run,appending)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#if defined(_M_IA64) || defined(_M_AMD64)


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

MIDL_DEFINE_GUID(IID, LIBID_EiffelSoftware_MetadataConsumer,0x6B69F95D,0xCEF9,0x317E,0x96,0xD9,0x2F,0x5C,0x12,0xF2,0x6F,0xE9);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER,0xE1FFE160,0x8346,0x4145,0xB9,0x94,0x96,0x77,0xFA,0x8E,0x27,0x5A);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_Interop_I_COM_ASSEMBLY_INFORMATION,0xE1FFE194,0xCC9A,0x4E3A,0x9B,0xFE,0x84,0xCC,0x4C,0x87,0x0C,0xD9);


MIDL_DEFINE_GUID(CLSID, CLSID_EiffelSoftware_MetadataConsumer_Interop_Impl_COM_CACHE_MANAGER,0xE1FFE19B,0x24F2,0x4523,0xA7,0xD0,0x5A,0xDF,0x4D,0x2B,0x81,0x46);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* defined(_M_IA64) || defined(_M_AMD64)*/

