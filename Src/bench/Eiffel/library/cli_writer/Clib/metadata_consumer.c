

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0361 */
/* at Tue Jun 08 09:22:50 2004
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

MIDL_DEFINE_GUID(IID, LIBID_EiffelSoftware_MetadataConsumer,0xA2D37C7B,0xB9C0,0x31A5,0x91,0x4A,0x69,0x8D,0x82,0x67,0xD9,0xA2);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER,0xE1FFE14C,0x4113,0x40E1,0x9B,0xCC,0xE8,0xB0,0xCF,0x3C,0x0F,0x5A);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION,0xE1FFE1B6,0x5067,0x499A,0x9A,0x25,0xE6,0xDD,0xA9,0x07,0x6E,0x77);


MIDL_DEFINE_GUID(CLSID, CLSID_EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER,0xE1FFE121,0xBD03,0x4F43,0xB5,0x75,0x65,0x5D,0xAC,0x99,0x41,0xA3);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/



/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0361 */
/* at Tue Jun 08 09:22:50 2004
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

MIDL_DEFINE_GUID(IID, LIBID_EiffelSoftware_MetadataConsumer,0xA2D37C7B,0xB9C0,0x31A5,0x91,0x4A,0x69,0x8D,0x82,0x67,0xD9,0xA2);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER,0xE1FFE14C,0x4113,0x40E1,0x9B,0xCC,0xE8,0xB0,0xCF,0x3C,0x0F,0x5A);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION,0xE1FFE1B6,0x5067,0x499A,0x9A,0x25,0xE6,0xDD,0xA9,0x07,0x6E,0x77);


MIDL_DEFINE_GUID(CLSID, CLSID_EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER,0xE1FFE121,0xBD03,0x4F43,0xB5,0x75,0x65,0x5D,0xAC,0x99,0x41,0xA3);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* defined(_M_IA64) || defined(_M_AMD64)*/

