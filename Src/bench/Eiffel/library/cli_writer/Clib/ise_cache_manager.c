

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0361 */
/* at Tue Jan 14 19:54:27 2003
 */
/* Compiler settings for ise_cache_manager.idl:
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

MIDL_DEFINE_GUID(IID, LIBID_emitter,0x9D69A826,0x596D,0x3973,0x89,0x81,0x78,0x78,0x81,0x4B,0x50,0x49);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ISE_CACHE_MANAGER,0x5855B757,0x2182,0x4C1B,0x8D,0x26,0xAC,0x4B,0xB3,0x34,0xA7,0xC8);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ASSEMBLY_INFORMATION,0x710EE4B6,0x5067,0x499A,0x9A,0x25,0xE6,0xDD,0xA9,0x07,0x6E,0x77);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER,0x0477E16A,0xFB59,0x4F0C,0x9D,0x85,0xAD,0xDD,0x93,0x66,0xE3,0x59);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/



/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0361 */
/* at Tue Jan 14 19:54:27 2003
 */
/* Compiler settings for ise_cache_manager.idl:
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

MIDL_DEFINE_GUID(IID, LIBID_emitter,0x9D69A826,0x596D,0x3973,0x89,0x81,0x78,0x78,0x81,0x4B,0x50,0x49);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ISE_CACHE_MANAGER,0x5855B757,0x2182,0x4C1B,0x8D,0x26,0xAC,0x4B,0xB3,0x34,0xA7,0xC8);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ASSEMBLY_INFORMATION,0x710EE4B6,0x5067,0x499A,0x9A,0x25,0xE6,0xDD,0xA9,0x07,0x6E,0x77);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER,0x0477E16A,0xFB59,0x4F0C,0x9D,0x85,0xAD,0xDD,0x93,0x66,0xE3,0x59);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* defined(_M_IA64) || defined(_M_AMD64)*/

