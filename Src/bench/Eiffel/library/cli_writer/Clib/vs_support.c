
#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Mon Jun 03 15:46:54 2002
 */
/* Compiler settings for ISE.VS.FusionSupport.IDL:
    Oicf, W1, Zp8, env=Win32 (32b run)
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

MIDL_DEFINE_GUID(IID, LIBID_ISE_VS_FusionSupport,0xA145DCF8,0x153F,0x364F,0xB1,0x1D,0xF4,0x26,0xE0,0xFF,0xE0,0x8C);


MIDL_DEFINE_GUID(IID, IID_IAssemblyInfo,0x8BE7FCFE,0xCDFC,0x4EE8,0xB0,0xF2,0xF8,0xD1,0x1C,0xC8,0xB4,0x68);


MIDL_DEFINE_GUID(IID, IID_IEnumAssemblies,0x311C80AE,0x545A,0x43B1,0x9D,0x06,0x9F,0xBF,0x0B,0xD8,0x5B,0x1E);


MIDL_DEFINE_GUID(IID, IID_IFusionSupport,0x071C5850,0x5C74,0x4C53,0x88,0x7B,0xF8,0x18,0x35,0x91,0xD6,0x84);


MIDL_DEFINE_GUID(CLSID, CLSID_AssemblyInfo,0x3D7EFB7F,0x2E27,0x4306,0xAC,0xE4,0x1B,0x4A,0xE3,0x39,0xF6,0xB9);


MIDL_DEFINE_GUID(CLSID, CLSID_EnumAssemblies,0x3C45BBE3,0xF41E,0x43C3,0xAE,0xFF,0x64,0x25,0x52,0xFA,0x67,0x71);


MIDL_DEFINE_GUID(CLSID, CLSID_FusionSupport,0x8D21B190,0x37B7,0x4C68,0x80,0x03,0xDC,0x3D,0xA4,0x1C,0x56,0xAC);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/


#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Mon Jun 03 15:46:54 2002
 */
/* Compiler settings for ISE.VS.FusionSupport.IDL:
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

MIDL_DEFINE_GUID(IID, LIBID_ISE_VS_FusionSupport,0xA145DCF8,0x153F,0x364F,0xB1,0x1D,0xF4,0x26,0xE0,0xFF,0xE0,0x8C);


MIDL_DEFINE_GUID(IID, IID_IAssemblyInfo,0x8BE7FCFE,0xCDFC,0x4EE8,0xB0,0xF2,0xF8,0xD1,0x1C,0xC8,0xB4,0x68);


MIDL_DEFINE_GUID(IID, IID_IEnumAssemblies,0x311C80AE,0x545A,0x43B1,0x9D,0x06,0x9F,0xBF,0x0B,0xD8,0x5B,0x1E);


MIDL_DEFINE_GUID(IID, IID_IFusionSupport,0x071C5850,0x5C74,0x4C53,0x88,0x7B,0xF8,0x18,0x35,0x91,0xD6,0x84);


MIDL_DEFINE_GUID(CLSID, CLSID_AssemblyInfo,0x3D7EFB7F,0x2E27,0x4306,0xAC,0xE4,0x1B,0x4A,0xE3,0x39,0xF6,0xB9);


MIDL_DEFINE_GUID(CLSID, CLSID_EnumAssemblies,0x3C45BBE3,0xF41E,0x43C3,0xAE,0xFF,0x64,0x25,0x52,0xFA,0x67,0x71);


MIDL_DEFINE_GUID(CLSID, CLSID_FusionSupport,0x8D21B190,0x37B7,0x4C68,0x80,0x03,0xDC,0x3D,0xA4,0x1C,0x56,0xAC);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



#endif /* defined(_M_IA64) || defined(_M_AMD64)*/

