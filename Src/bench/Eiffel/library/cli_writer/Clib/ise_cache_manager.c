
#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Wed Aug 28 15:33:37 2002
 */
/* Compiler settings for ise_cache_manager.idl:
    Os, W1, Zp8, env=Win32 (32b run)
    protocol : dce , ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#if !defined(_M_IA64) && !defined(_M_AMD64)

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

MIDL_DEFINE_GUID(IID, LIBID_emitter,0xA59E5115,0x65ED,0x3635,0xBD,0xEA,0x6A,0xC3,0x57,0x7E,0x32,0xF4);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ISE_CACHE_MANAGER,0xE3526F85,0xA118,0x3FBC,0xB4,0x45,0x41,0x74,0x52,0xD1,0xAA,0xA5);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ASSEMBLY_INFORMATION,0xFD2F67FF,0xFF44,0x3B67,0xA5,0x5D,0x8E,0xE3,0x08,0x6D,0x39,0x70);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER,0x01BDF738,0x3044,0x3ED6,0xBA,0x7B,0x34,0x63,0x2D,0x67,0xE1,0x45);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION,0x7F6F58E1,0x29FD,0x3FB3,0xB6,0x12,0x72,0x20,0x5F,0xE9,0x07,0xE3);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/


#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Wed Aug 28 15:33:37 2002
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

MIDL_DEFINE_GUID(IID, LIBID_emitter,0xA59E5115,0x65ED,0x3635,0xBD,0xEA,0x6A,0xC3,0x57,0x7E,0x32,0xF4);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ISE_CACHE_MANAGER,0xE3526F85,0xA118,0x3FBC,0xB4,0x45,0x41,0x74,0x52,0xD1,0xAA,0xA5);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ASSEMBLY_INFORMATION,0xFD2F67FF,0xFF44,0x3B67,0xA5,0x5D,0x8E,0xE3,0x08,0x6D,0x39,0x70);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER,0x01BDF738,0x3044,0x3ED6,0xBA,0x7B,0x34,0x63,0x2D,0x67,0xE1,0x45);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION,0x7F6F58E1,0x29FD,0x3FB3,0xB6,0x12,0x72,0x20,0x5F,0xE9,0x07,0xE3);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* defined(_M_IA64) || defined(_M_AMD64)*/

