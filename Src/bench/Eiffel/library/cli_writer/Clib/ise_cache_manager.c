
#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Thu Jun 27 19:59:10 2002
 */
/* Compiler settings for emitter.idl:
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

MIDL_DEFINE_GUID(IID, LIBID_emitter,0xCD9EACC5,0x4623,0x315A,0x87,0xE5,0xEF,0x3E,0x79,0xA9,0xD2,0xF7);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ISE_CACHE_MANAGER,0xE3526F85,0xA118,0x3FBC,0xB4,0x45,0x41,0x74,0x52,0xD1,0xAA,0xA5);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ASSEMBLY_INFORMATION,0xF48FE226,0xD835,0x346E,0x97,0xD2,0x2A,0xED,0x55,0x95,0xCB,0x9F);


MIDL_DEFINE_GUID(IID, IID_EIFFEL_TYPE_INFO,0xDCF16324,0x925C,0x366D,0xB8,0x87,0x7E,0xD3,0x47,0xC7,0xA6,0x13);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER,0x436996E6,0x9986,0x3E67,0xA1,0x6D,0x8E,0xBE,0x28,0xA7,0xEE,0xFC);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION,0x7EFA46A3,0x45F3,0x3BA4,0x8F,0x4E,0x6C,0xBB,0x5C,0xBF,0x73,0xD7);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/


#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Thu Jun 27 19:59:10 2002
 */
/* Compiler settings for emitter.idl:
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

MIDL_DEFINE_GUID(IID, LIBID_emitter,0xCD9EACC5,0x4623,0x315A,0x87,0xE5,0xEF,0x3E,0x79,0xA9,0xD2,0xF7);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ISE_CACHE_MANAGER,0xE3526F85,0xA118,0x3FBC,0xB4,0x45,0x41,0x74,0x52,0xD1,0xAA,0xA5);


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_COM_ASSEMBLY_INFORMATION,0xF48FE226,0xD835,0x346E,0x97,0xD2,0x2A,0xED,0x55,0x95,0xCB,0x9F);


MIDL_DEFINE_GUID(IID, IID_EIFFEL_TYPE_INFO,0xDCF16324,0x925C,0x366D,0xB8,0x87,0x7E,0xD3,0x47,0xC7,0xA6,0x13);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER,0x436996E6,0x9986,0x3E67,0xA1,0x6D,0x8E,0xBE,0x28,0xA7,0xEE,0xFC);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION,0x7EFA46A3,0x45F3,0x3BA4,0x8F,0x4E,0x6C,0xBB,0x5C,0xBF,0x73,0xD7);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* defined(_M_IA64) || defined(_M_AMD64)*/

