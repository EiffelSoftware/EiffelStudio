
#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Thu Jun 27 18:02:27 2002
 */
/* Compiler settings for emitter.IDL:
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


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_ISE_COM_CACHE_MANAGER,0x6209E9C6,0x3165,0x3438,0x90,0x1F,0x76,0x46,0x41,0xE4,0x3E,0x3A);


MIDL_DEFINE_GUID(IID, IID__ISE_Cache_Impl_ISE_COM_CACHE_MANAGER,0xB0FAE776,0xC582,0x322D,0xAB,0xC4,0x1E,0x4A,0x6C,0xA5,0x13,0xBD);


MIDL_DEFINE_GUID(IID, IID_EIFFEL_TYPE_INFO,0xDCF16324,0x925C,0x366D,0xB8,0x87,0x7E,0xD3,0x47,0xC7,0xA6,0x13);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_ISE_COM_CACHE_MANAGER,0xCF974296,0x37DC,0x3E1A,0x97,0x1A,0xAF,0x1F,0x1B,0xA4,0xFE,0x10);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/


#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Thu Jun 27 18:02:27 2002
 */
/* Compiler settings for emitter.IDL:
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


MIDL_DEFINE_GUID(IID, IID_ISE_Cache_ISE_COM_CACHE_MANAGER,0x6209E9C6,0x3165,0x3438,0x90,0x1F,0x76,0x46,0x41,0xE4,0x3E,0x3A);


MIDL_DEFINE_GUID(IID, IID__ISE_Cache_Impl_ISE_COM_CACHE_MANAGER,0xB0FAE776,0xC582,0x322D,0xAB,0xC4,0x1E,0x4A,0x6C,0xA5,0x13,0xBD);


MIDL_DEFINE_GUID(IID, IID_EIFFEL_TYPE_INFO,0xDCF16324,0x925C,0x366D,0xB8,0x87,0x7E,0xD3,0x47,0xC7,0xA6,0x13);


MIDL_DEFINE_GUID(CLSID, CLSID_ISE_Cache_Impl_ISE_COM_CACHE_MANAGER,0xCF974296,0x37DC,0x3E1A,0x97,0x1A,0xAF,0x1F,0x1B,0xA4,0xFE,0x10);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* defined(_M_IA64) || defined(_M_AMD64)*/

