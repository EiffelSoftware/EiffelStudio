

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 6.00.0361 */
/* at Thu Jul 15 22:06:07 2004
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

#pragma warning( disable: 4049 )  /* more than 64k source lines */


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__


#ifndef __metadata_consumer_h__
#define __metadata_consumer_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_FWD_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_FWD_DEFINED__
typedef interface EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation;
#endif 	/* __EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_FWD_DEFINED__ */


#ifndef __EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_FWD_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_FWD_DEFINED__
typedef interface EiffelSoftware_MetadataConsumer_Interop_IComCacheManager EiffelSoftware_MetadataConsumer_Interop_IComCacheManager;
#endif 	/* __EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_FWD_DEFINED__ */


#ifndef __EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager_FWD_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager_FWD_DEFINED__

#ifdef __cplusplus
typedef class EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager;
#else
typedef struct EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager;
#endif /* __cplusplus */

#endif 	/* __EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager_FWD_DEFINED__ */


#ifdef __cplusplus
extern "C"{
#endif 

void * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void * ); 


#ifndef __EiffelSoftware_MetadataConsumer_LIBRARY_DEFINED__
#define __EiffelSoftware_MetadataConsumer_LIBRARY_DEFINED__

/* library EiffelSoftware_MetadataConsumer */
/* [version][uuid] */ 




EXTERN_C const IID LIBID_EiffelSoftware_MetadataConsumer;

#ifndef __EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_INTERFACE_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_INTERFACE_DEFINED__

/* interface EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation */
/* [object][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("E1FFE100-F122-4DD9-914E-E37ED8FF236C")
    EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation : public IDispatch
    {
    public:
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE ConsumedFolderName( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE Culture( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE IsConsumed( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE IsInGac( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE Name( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE PublicKeyToken( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE Version( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformationVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *ConsumedFolderName )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *Culture )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *IsConsumed )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *IsInGac )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *Name )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *PublicKeyToken )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *Version )( 
            EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        END_INTERFACE
    } EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformationVtbl;

    interface EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation
    {
        CONST_VTBL struct EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformationVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_ConsumedFolderName(This,pRetVal)	\
    (This)->lpVtbl -> ConsumedFolderName(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Culture(This,pRetVal)	\
    (This)->lpVtbl -> Culture(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_IsConsumed(This,pRetVal)	\
    (This)->lpVtbl -> IsConsumed(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_IsInGac(This,pRetVal)	\
    (This)->lpVtbl -> IsInGac(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Name(This,pRetVal)	\
    (This)->lpVtbl -> Name(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_PublicKeyToken(This,pRetVal)	\
    (This)->lpVtbl -> PublicKeyToken(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Version(This,pRetVal)	\
    (This)->lpVtbl -> Version(This,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_ConsumedFolderName_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_ConsumedFolderName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Culture_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Culture_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_IsConsumed_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_IsConsumed_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_IsInGac_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_IsInGac_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Name_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Name_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_PublicKeyToken_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_PublicKeyToken_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Version_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_Version_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation_INTERFACE_DEFINED__ */


#ifndef __EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_INTERFACE_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_INTERFACE_DEFINED__

/* interface EiffelSoftware_MetadataConsumer_Interop_IComCacheManager */
/* [object][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_EiffelSoftware_MetadataConsumer_Interop_IComCacheManager;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("E1FFE1FC-11B7-4757-88F7-9DAD46A40C44")
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager : public IDispatch
    {
    public:
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE AssemblyInfoFromAssembly( 
            /* [in] */ BSTR a_path,
            /* [retval][out] */ EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation **pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE ClrVersion( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE ConsumeAssembly( 
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE ConsumeAssemblyFromPath( 
            /* [in] */ BSTR a_path) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE EacPath( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE Initialize( 
            /* [in] */ BSTR a_clr_version) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE InitializeWithPath( 
            /* [in] */ BSTR a_path,
            /* [in] */ BSTR a_clr_version) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE IsInitialized( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE IsSuccessful( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE LastErrorMessage( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE RelativeFolderName( 
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key,
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE RelativeFolderNameFromPath( 
            /* [in] */ BSTR a_path,
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE Unload( void) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct EiffelSoftware_MetadataConsumer_Interop_IComCacheManagerVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *AssemblyInfoFromAssembly )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ BSTR a_path,
            /* [retval][out] */ EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation **pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *ClrVersion )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *ConsumeAssembly )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *ConsumeAssemblyFromPath )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ BSTR a_path);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *EacPath )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *Initialize )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ BSTR a_clr_version);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *InitializeWithPath )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ BSTR a_path,
            /* [in] */ BSTR a_clr_version);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *IsInitialized )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *IsSuccessful )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *LastErrorMessage )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *RelativeFolderName )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *RelativeFolderNameFromPath )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
            /* [in] */ BSTR a_path,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *Unload )( 
            EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This);
        
        END_INTERFACE
    } EiffelSoftware_MetadataConsumer_Interop_IComCacheManagerVtbl;

    interface EiffelSoftware_MetadataConsumer_Interop_IComCacheManager
    {
        CONST_VTBL struct EiffelSoftware_MetadataConsumer_Interop_IComCacheManagerVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_AssemblyInfoFromAssembly(This,a_path,pRetVal)	\
    (This)->lpVtbl -> AssemblyInfoFromAssembly(This,a_path,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ClrVersion(This,pRetVal)	\
    (This)->lpVtbl -> ClrVersion(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ConsumeAssembly(This,a_name,a_version,a_culture,a_key)	\
    (This)->lpVtbl -> ConsumeAssembly(This,a_name,a_version,a_culture,a_key)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ConsumeAssemblyFromPath(This,a_path)	\
    (This)->lpVtbl -> ConsumeAssemblyFromPath(This,a_path)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_EacPath(This,pRetVal)	\
    (This)->lpVtbl -> EacPath(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_Initialize(This,a_clr_version)	\
    (This)->lpVtbl -> Initialize(This,a_clr_version)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_InitializeWithPath(This,a_path,a_clr_version)	\
    (This)->lpVtbl -> InitializeWithPath(This,a_path,a_clr_version)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_IsInitialized(This,pRetVal)	\
    (This)->lpVtbl -> IsInitialized(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_IsSuccessful(This,pRetVal)	\
    (This)->lpVtbl -> IsSuccessful(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_LastErrorMessage(This,pRetVal)	\
    (This)->lpVtbl -> LastErrorMessage(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_RelativeFolderName(This,a_name,a_version,a_culture,a_key,pRetVal)	\
    (This)->lpVtbl -> RelativeFolderName(This,a_name,a_version,a_culture,a_key,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_RelativeFolderNameFromPath(This,a_path,pRetVal)	\
    (This)->lpVtbl -> RelativeFolderNameFromPath(This,a_path,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_Unload(This)	\
    (This)->lpVtbl -> Unload(This)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_AssemblyInfoFromAssembly_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [in] */ BSTR a_path,
    /* [retval][out] */ EiffelSoftware_MetadataConsumer_Interop_IComAssemblyInformation **pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_AssemblyInfoFromAssembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ClrVersion_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ClrVersion_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ConsumeAssembly_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [in] */ BSTR a_name,
    /* [in] */ BSTR a_version,
    /* [in] */ BSTR a_culture,
    /* [in] */ BSTR a_key);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ConsumeAssembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ConsumeAssemblyFromPath_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [in] */ BSTR a_path);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_ConsumeAssemblyFromPath_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_EacPath_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_EacPath_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_Initialize_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [in] */ BSTR a_clr_version);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_Initialize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_InitializeWithPath_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [in] */ BSTR a_path,
    /* [in] */ BSTR a_clr_version);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_InitializeWithPath_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_IsInitialized_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_IsInitialized_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_IsSuccessful_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_IsSuccessful_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_LastErrorMessage_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_LastErrorMessage_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_RelativeFolderName_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [in] */ BSTR a_name,
    /* [in] */ BSTR a_version,
    /* [in] */ BSTR a_culture,
    /* [in] */ BSTR a_key,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_RelativeFolderName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_RelativeFolderNameFromPath_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This,
    /* [in] */ BSTR a_path,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_RelativeFolderNameFromPath_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_Unload_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_IComCacheManager * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_Unload_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __EiffelSoftware_MetadataConsumer_Interop_IComCacheManager_INTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager;

#ifdef __cplusplus

class DECLSPEC_UUID("E1FFE1DE-1816-4209-AF21-FC599DAE7CAA")
EiffelSoftware_MetadataConsumer_Interop_Impl_ComCacheManager;
#endif
#endif /* __EiffelSoftware_MetadataConsumer_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


