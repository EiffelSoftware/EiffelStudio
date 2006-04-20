
#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


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


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 440
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __vs_support_h__
#define __vs_support_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __IAssemblyInfo_FWD_DEFINED__
#define __IAssemblyInfo_FWD_DEFINED__
typedef interface IAssemblyInfo IAssemblyInfo;
#endif 	/* __IAssemblyInfo_FWD_DEFINED__ */


#ifndef __IEnumAssemblies_FWD_DEFINED__
#define __IEnumAssemblies_FWD_DEFINED__
typedef interface IEnumAssemblies IEnumAssemblies;
#endif 	/* __IEnumAssemblies_FWD_DEFINED__ */


#ifndef __IFusionSupport_FWD_DEFINED__
#define __IFusionSupport_FWD_DEFINED__
typedef interface IFusionSupport IFusionSupport;
#endif 	/* __IFusionSupport_FWD_DEFINED__ */


#ifndef __AssemblyInfo_FWD_DEFINED__
#define __AssemblyInfo_FWD_DEFINED__

#ifdef __cplusplus
typedef class AssemblyInfo AssemblyInfo;
#else
typedef struct AssemblyInfo AssemblyInfo;
#endif /* __cplusplus */

#endif 	/* __AssemblyInfo_FWD_DEFINED__ */


#ifndef __EnumAssemblies_FWD_DEFINED__
#define __EnumAssemblies_FWD_DEFINED__

#ifdef __cplusplus
typedef class EnumAssemblies EnumAssemblies;
#else
typedef struct EnumAssemblies EnumAssemblies;
#endif /* __cplusplus */

#endif 	/* __EnumAssemblies_FWD_DEFINED__ */


#ifndef __FusionSupport_FWD_DEFINED__
#define __FusionSupport_FWD_DEFINED__

#ifdef __cplusplus
typedef class FusionSupport FusionSupport;
#else
typedef struct FusionSupport FusionSupport;
#endif /* __cplusplus */

#endif 	/* __FusionSupport_FWD_DEFINED__ */


#ifdef __cplusplus
extern "C"{
#endif 

void * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void * ); 


#ifndef __ISE_VS_FusionSupport_LIBRARY_DEFINED__
#define __ISE_VS_FusionSupport_LIBRARY_DEFINED__

/* library ISE_VS_FusionSupport */
/* [helpstring][version][uuid] */ 





EXTERN_C const IID LIBID_ISE_VS_FusionSupport;

#ifndef __IAssemblyInfo_INTERFACE_DEFINED__
#define __IAssemblyInfo_INTERFACE_DEFINED__

/* interface IAssemblyInfo */
/* [object][version][uuid] */ 


EXTERN_C const IID IID_IAssemblyInfo;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("8BE7FCFE-CDFC-4EE8-B0F2-F8D11CC8B468")
    IAssemblyInfo : public IUnknown
    {
    public:
        virtual HRESULT __stdcall AssemblyName( 
            /* [retval][out] */ LPWSTR *pRetVal) = 0;
        
        virtual HRESULT __stdcall Version( 
            /* [retval][out] */ LPWSTR *pRetVal) = 0;
        
        virtual HRESULT __stdcall Culture( 
            /* [retval][out] */ LPWSTR *pRetVal) = 0;
        
        virtual HRESULT __stdcall PublicKeyToken( 
            /* [retval][out] */ LPWSTR *pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IAssemblyInfoVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IAssemblyInfo * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IAssemblyInfo * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IAssemblyInfo * This);
        
        HRESULT ( __stdcall *AssemblyName )( 
            IAssemblyInfo * This,
            /* [retval][out] */ LPWSTR *pRetVal);
        
        HRESULT ( __stdcall *Version )( 
            IAssemblyInfo * This,
            /* [retval][out] */ LPWSTR *pRetVal);
        
        HRESULT ( __stdcall *Culture )( 
            IAssemblyInfo * This,
            /* [retval][out] */ LPWSTR *pRetVal);
        
        HRESULT ( __stdcall *PublicKeyToken )( 
            IAssemblyInfo * This,
            /* [retval][out] */ LPWSTR *pRetVal);
        
        END_INTERFACE
    } IAssemblyInfoVtbl;

    interface IAssemblyInfo
    {
        CONST_VTBL struct IAssemblyInfoVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IAssemblyInfo_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IAssemblyInfo_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IAssemblyInfo_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IAssemblyInfo_AssemblyName(This,pRetVal)	\
    (This)->lpVtbl -> AssemblyName(This,pRetVal)

#define IAssemblyInfo_Version(This,pRetVal)	\
    (This)->lpVtbl -> Version(This,pRetVal)

#define IAssemblyInfo_Culture(This,pRetVal)	\
    (This)->lpVtbl -> Culture(This,pRetVal)

#define IAssemblyInfo_PublicKeyToken(This,pRetVal)	\
    (This)->lpVtbl -> PublicKeyToken(This,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT __stdcall IAssemblyInfo_AssemblyName_Proxy( 
    IAssemblyInfo * This,
    /* [retval][out] */ LPWSTR *pRetVal);


void __RPC_STUB IAssemblyInfo_AssemblyName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT __stdcall IAssemblyInfo_Version_Proxy( 
    IAssemblyInfo * This,
    /* [retval][out] */ LPWSTR *pRetVal);


void __RPC_STUB IAssemblyInfo_Version_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT __stdcall IAssemblyInfo_Culture_Proxy( 
    IAssemblyInfo * This,
    /* [retval][out] */ LPWSTR *pRetVal);


void __RPC_STUB IAssemblyInfo_Culture_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT __stdcall IAssemblyInfo_PublicKeyToken_Proxy( 
    IAssemblyInfo * This,
    /* [retval][out] */ LPWSTR *pRetVal);


void __RPC_STUB IAssemblyInfo_PublicKeyToken_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IAssemblyInfo_INTERFACE_DEFINED__ */


#ifndef __IEnumAssemblies_INTERFACE_DEFINED__
#define __IEnumAssemblies_INTERFACE_DEFINED__

/* interface IEnumAssemblies */
/* [object][version][uuid] */ 


EXTERN_C const IID IID_IEnumAssemblies;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("311C80AE-545A-43B1-9D06-9FBF0BD85B1E")
    IEnumAssemblies : public IUnknown
    {
    public:
        virtual /* [propget] */ HRESULT __stdcall get_Current( 
            /* [retval][out] */ IAssemblyInfo **pRetVal) = 0;
        
        virtual HRESULT __stdcall Reset( void) = 0;
        
        virtual HRESULT __stdcall MoveNext( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [propget] */ HRESULT __stdcall get_Count( 
            /* [retval][out] */ long *pRetVal) = 0;
        
        virtual HRESULT __stdcall IthItem( 
            /* [in] */ long index,
            /* [retval][out] */ IAssemblyInfo **pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IEnumAssembliesVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IEnumAssemblies * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IEnumAssemblies * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IEnumAssemblies * This);
        
        /* [propget] */ HRESULT ( __stdcall *get_Current )( 
            IEnumAssemblies * This,
            /* [retval][out] */ IAssemblyInfo **pRetVal);
        
        HRESULT ( __stdcall *Reset )( 
            IEnumAssemblies * This);
        
        HRESULT ( __stdcall *MoveNext )( 
            IEnumAssemblies * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [propget] */ HRESULT ( __stdcall *get_Count )( 
            IEnumAssemblies * This,
            /* [retval][out] */ long *pRetVal);
        
        HRESULT ( __stdcall *IthItem )( 
            IEnumAssemblies * This,
            /* [in] */ long index,
            /* [retval][out] */ IAssemblyInfo **pRetVal);
        
        END_INTERFACE
    } IEnumAssembliesVtbl;

    interface IEnumAssemblies
    {
        CONST_VTBL struct IEnumAssembliesVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IEnumAssemblies_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IEnumAssemblies_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IEnumAssemblies_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IEnumAssemblies_get_Current(This,pRetVal)	\
    (This)->lpVtbl -> get_Current(This,pRetVal)

#define IEnumAssemblies_Reset(This)	\
    (This)->lpVtbl -> Reset(This)

#define IEnumAssemblies_MoveNext(This,pRetVal)	\
    (This)->lpVtbl -> MoveNext(This,pRetVal)

#define IEnumAssemblies_get_Count(This,pRetVal)	\
    (This)->lpVtbl -> get_Count(This,pRetVal)

#define IEnumAssemblies_IthItem(This,index,pRetVal)	\
    (This)->lpVtbl -> IthItem(This,index,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [propget] */ HRESULT __stdcall IEnumAssemblies_get_Current_Proxy( 
    IEnumAssemblies * This,
    /* [retval][out] */ IAssemblyInfo **pRetVal);


void __RPC_STUB IEnumAssemblies_get_Current_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT __stdcall IEnumAssemblies_Reset_Proxy( 
    IEnumAssemblies * This);


void __RPC_STUB IEnumAssemblies_Reset_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT __stdcall IEnumAssemblies_MoveNext_Proxy( 
    IEnumAssemblies * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB IEnumAssemblies_MoveNext_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [propget] */ HRESULT __stdcall IEnumAssemblies_get_Count_Proxy( 
    IEnumAssemblies * This,
    /* [retval][out] */ long *pRetVal);


void __RPC_STUB IEnumAssemblies_get_Count_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT __stdcall IEnumAssemblies_IthItem_Proxy( 
    IEnumAssemblies * This,
    /* [in] */ long index,
    /* [retval][out] */ IAssemblyInfo **pRetVal);


void __RPC_STUB IEnumAssemblies_IthItem_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IEnumAssemblies_INTERFACE_DEFINED__ */


#ifndef __IFusionSupport_INTERFACE_DEFINED__
#define __IFusionSupport_INTERFACE_DEFINED__

/* interface IFusionSupport */
/* [object][version][uuid] */ 


EXTERN_C const IID IID_IFusionSupport;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("071C5850-5C74-4C53-887B-F8183591D684")
    IFusionSupport : public IUnknown
    {
    public:
        virtual HRESULT __stdcall GetGacAssemblies( 
            /* [retval][out] */ IEnumAssemblies **pRetVal) = 0;
        
        virtual HRESULT __stdcall IsAssemblySigned( 
            /* [in] */ BSTR path,
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual HRESULT __stdcall GetAssemblyInfoFromAssembly( 
            /* [in] */ BSTR path,
            /* [retval][out] */ IAssemblyInfo **pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IFusionSupportVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IFusionSupport * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IFusionSupport * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IFusionSupport * This);
        
        HRESULT ( __stdcall *GetGacAssemblies )( 
            IFusionSupport * This,
            /* [retval][out] */ IEnumAssemblies **pRetVal);
        
        HRESULT ( __stdcall *IsAssemblySigned )( 
            IFusionSupport * This,
            /* [in] */ BSTR path,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        HRESULT ( __stdcall *GetAssemblyInfoFromAssembly )( 
            IFusionSupport * This,
            /* [in] */ BSTR path,
            /* [retval][out] */ IAssemblyInfo **pRetVal);
        
        END_INTERFACE
    } IFusionSupportVtbl;

    interface IFusionSupport
    {
        CONST_VTBL struct IFusionSupportVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IFusionSupport_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IFusionSupport_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IFusionSupport_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IFusionSupport_GetGacAssemblies(This,pRetVal)	\
    (This)->lpVtbl -> GetGacAssemblies(This,pRetVal)

#define IFusionSupport_IsAssemblySigned(This,path,pRetVal)	\
    (This)->lpVtbl -> IsAssemblySigned(This,path,pRetVal)

#define IFusionSupport_GetAssemblyInfoFromAssembly(This,path,pRetVal)	\
    (This)->lpVtbl -> GetAssemblyInfoFromAssembly(This,path,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



HRESULT __stdcall IFusionSupport_GetGacAssemblies_Proxy( 
    IFusionSupport * This,
    /* [retval][out] */ IEnumAssemblies **pRetVal);


void __RPC_STUB IFusionSupport_GetGacAssemblies_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT __stdcall IFusionSupport_IsAssemblySigned_Proxy( 
    IFusionSupport * This,
    /* [in] */ BSTR path,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB IFusionSupport_IsAssemblySigned_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


HRESULT __stdcall IFusionSupport_GetAssemblyInfoFromAssembly_Proxy( 
    IFusionSupport * This,
    /* [in] */ BSTR path,
    /* [retval][out] */ IAssemblyInfo **pRetVal);


void __RPC_STUB IFusionSupport_GetAssemblyInfoFromAssembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IFusionSupport_INTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_AssemblyInfo;

#ifdef __cplusplus

class DECLSPEC_UUID("3D7EFB7F-2E27-4306-ACE4-1B4AE339F6B9")
AssemblyInfo;
#endif

EXTERN_C const CLSID CLSID_EnumAssemblies;

#ifdef __cplusplus

class DECLSPEC_UUID("3C45BBE3-F41E-43C3-AEFF-642552FA6771")
EnumAssemblies;
#endif

EXTERN_C const CLSID CLSID_FusionSupport;

#ifdef __cplusplus

class DECLSPEC_UUID("8D21B190-37B7-4C68-8003-DC3DA41C56AC")
FusionSupport;
#endif
#endif /* __ISE_VS_FusionSupport_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


