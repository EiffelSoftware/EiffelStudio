

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 6.00.0365 */
/* at Fri Mar 06 20:08:11 2009
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

#ifndef __EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_FWD_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_FWD_DEFINED__
typedef interface EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER;
#endif 	/* __EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_FWD_DEFINED__ */


#ifndef __EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER_FWD_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER_FWD_DEFINED__

#ifdef __cplusplus
typedef class EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER;
#else
typedef struct EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER;
#endif /* __cplusplus */

#endif 	/* __EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER_FWD_DEFINED__ */


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

#ifndef __EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_INTERFACE_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_INTERFACE_DEFINED__

/* interface EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER */
/* [object][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("E1FFE1AC-8466-4E95-9C3F-3FEB392F8F32")
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER : public IDispatch
    {
    public:
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE consume_assembly( 
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key,
            /* [in] */ VARIANT_BOOL a_info_only) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE consume_assembly_from_path( 
            /* [in] */ BSTR a_path,
            /* [in] */ VARIANT_BOOL a_info_only,
            /* [in] */ BSTR a_references) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing9( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE initialize( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE initialize_with_path( 
            /* [in] */ BSTR a_path) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE is_initialized( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE is_successful( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE last_error_message( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE unload( void) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGERVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *consume_assembly )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key,
            /* [in] */ VARIANT_BOOL a_info_only);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *consume_assembly_from_path )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_path,
            /* [in] */ VARIANT_BOOL a_info_only,
            /* [in] */ BSTR a_references);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing9 )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *initialize )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *initialize_with_path )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_path);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *is_initialized )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *is_successful )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *last_error_message )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *unload )( 
            EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This);
        
        END_INTERFACE
    } EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGERVtbl;

    interface EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER
    {
        CONST_VTBL struct EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGERVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_consume_assembly(This,a_name,a_version,a_culture,a_key,a_info_only)	\
    (This)->lpVtbl -> consume_assembly(This,a_name,a_version,a_culture,a_key,a_info_only)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_consume_assembly_from_path(This,a_path,a_info_only,a_references)	\
    (This)->lpVtbl -> consume_assembly_from_path(This,a_path,a_info_only,a_references)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_Missing9(This)	\
    (This)->lpVtbl -> Missing9(This)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_initialize(This)	\
    (This)->lpVtbl -> initialize(This)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_initialize_with_path(This,a_path)	\
    (This)->lpVtbl -> initialize_with_path(This,a_path)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_is_initialized(This,pRetVal)	\
    (This)->lpVtbl -> is_initialized(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_is_successful(This,pRetVal)	\
    (This)->lpVtbl -> is_successful(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_last_error_message(This,pRetVal)	\
    (This)->lpVtbl -> last_error_message(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_unload(This)	\
    (This)->lpVtbl -> unload(This)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_consume_assembly_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_name,
    /* [in] */ BSTR a_version,
    /* [in] */ BSTR a_culture,
    /* [in] */ BSTR a_key,
    /* [in] */ VARIANT_BOOL a_info_only);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_consume_assembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_consume_assembly_from_path_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_path,
    /* [in] */ VARIANT_BOOL a_info_only,
    /* [in] */ BSTR a_references);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_consume_assembly_from_path_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_Missing9_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_Missing9_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_initialize_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_initialize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_initialize_with_path_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_path);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_initialize_with_path_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_is_initialized_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_is_initialized_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_is_successful_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_is_successful_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_last_error_message_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_last_error_message_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_unload_Proxy( 
    EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_unload_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER_INTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER;

#ifdef __cplusplus

class DECLSPEC_UUID("E1FFE1AC-C88F-4CD5-BBCB-1B1B82308654")
EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER;
#endif
#endif /* __EiffelSoftware_MetadataConsumer_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


