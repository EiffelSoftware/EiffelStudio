

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


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

#ifndef __EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_FWD_DEFINED__
#define __EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_FWD_DEFINED__
typedef interface EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER;
#endif 	/* __EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_FWD_DEFINED__ */


#ifndef __EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__
#define __EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__
typedef interface EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION;
#endif 	/* __EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__ */


#ifndef __EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER_FWD_DEFINED__
#define __EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER_FWD_DEFINED__

#ifdef __cplusplus
typedef class EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER;
#else
typedef struct EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER;
#endif /* __cplusplus */

#endif 	/* __EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER_FWD_DEFINED__ */


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

#ifndef __EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_INTERFACE_DEFINED__
#define __EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_INTERFACE_DEFINED__

/* interface EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER */
/* [object][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("E1FFE14C-4113-40E1-9BCC-E8B0CF3C0F5A")
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER : public IDispatch
    {
    public:
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing7( void) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing8( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE assembly_info_from_assembly( 
            /* [in] */ BSTR a_path,
            /* [retval][out] */ EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION **pRetVal) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing10( void) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing11( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE consume_assembly( 
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE consume_assembly_from_path( 
            /* [in] */ BSTR a_path) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing14( void) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing15( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE initialize( 
            /* [in] */ BSTR a_clr_version) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE initialize_with_path( 
            /* [in] */ BSTR a_path,
            /* [in] */ BSTR a_clr_version) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing18( void) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing19( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE is_initialized( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE _set_is_initialized( 
            /* [in] */ VARIANT_BOOL p1) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE is_successful( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE _set_is_successful( 
            /* [in] */ VARIANT_BOOL p1) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE last_error_message( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE _set_last_error_message( 
            /* [in] */ BSTR p1) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing26( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE relative_folder_name( 
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key,
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE relative_folder_name_from_path( 
            /* [in] */ BSTR a_path,
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE unload( void) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGERVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing7 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing8 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *assembly_info_from_assembly )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_path,
            /* [retval][out] */ EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION **pRetVal);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing10 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing11 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *consume_assembly )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *consume_assembly_from_path )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_path);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing14 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing15 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *initialize )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_clr_version);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *initialize_with_path )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_path,
            /* [in] */ BSTR a_clr_version);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing18 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing19 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *is_initialized )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *_set_is_initialized )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ VARIANT_BOOL p1);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *is_successful )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *_set_is_successful )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ VARIANT_BOOL p1);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *last_error_message )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *_set_last_error_message )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR p1);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing26 )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *relative_folder_name )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_name,
            /* [in] */ BSTR a_version,
            /* [in] */ BSTR a_culture,
            /* [in] */ BSTR a_key,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *relative_folder_name_from_path )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
            /* [in] */ BSTR a_path,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *unload )( 
            EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);
        
        END_INTERFACE
    } EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGERVtbl;

    interface EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER
    {
        CONST_VTBL struct EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGERVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing7(This)	\
    (This)->lpVtbl -> Missing7(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing8(This)	\
    (This)->lpVtbl -> Missing8(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_assembly_info_from_assembly(This,a_path,pRetVal)	\
    (This)->lpVtbl -> assembly_info_from_assembly(This,a_path,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing10(This)	\
    (This)->lpVtbl -> Missing10(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing11(This)	\
    (This)->lpVtbl -> Missing11(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_consume_assembly(This,a_name,a_version,a_culture,a_key)	\
    (This)->lpVtbl -> consume_assembly(This,a_name,a_version,a_culture,a_key)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_consume_assembly_from_path(This,a_path)	\
    (This)->lpVtbl -> consume_assembly_from_path(This,a_path)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing14(This)	\
    (This)->lpVtbl -> Missing14(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing15(This)	\
    (This)->lpVtbl -> Missing15(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_initialize(This,a_clr_version)	\
    (This)->lpVtbl -> initialize(This,a_clr_version)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_initialize_with_path(This,a_path,a_clr_version)	\
    (This)->lpVtbl -> initialize_with_path(This,a_path,a_clr_version)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing18(This)	\
    (This)->lpVtbl -> Missing18(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing19(This)	\
    (This)->lpVtbl -> Missing19(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_is_initialized(This,pRetVal)	\
    (This)->lpVtbl -> is_initialized(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_is_initialized(This,p1)	\
    (This)->lpVtbl -> _set_is_initialized(This,p1)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_is_successful(This,pRetVal)	\
    (This)->lpVtbl -> is_successful(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_is_successful(This,p1)	\
    (This)->lpVtbl -> _set_is_successful(This,p1)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_last_error_message(This,pRetVal)	\
    (This)->lpVtbl -> last_error_message(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_last_error_message(This,p1)	\
    (This)->lpVtbl -> _set_last_error_message(This,p1)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing26(This)	\
    (This)->lpVtbl -> Missing26(This)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_relative_folder_name(This,a_name,a_version,a_culture,a_key,pRetVal)	\
    (This)->lpVtbl -> relative_folder_name(This,a_name,a_version,a_culture,a_key,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_relative_folder_name_from_path(This,a_path,pRetVal)	\
    (This)->lpVtbl -> relative_folder_name_from_path(This,a_path,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_unload(This)	\
    (This)->lpVtbl -> unload(This)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing7_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing7_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing8_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing8_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_assembly_info_from_assembly_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_path,
    /* [retval][out] */ EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION **pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_assembly_info_from_assembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing10_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing10_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing11_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing11_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_consume_assembly_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_name,
    /* [in] */ BSTR a_version,
    /* [in] */ BSTR a_culture,
    /* [in] */ BSTR a_key);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_consume_assembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_consume_assembly_from_path_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_path);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_consume_assembly_from_path_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing14_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing14_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing15_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing15_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_initialize_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_clr_version);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_initialize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_initialize_with_path_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_path,
    /* [in] */ BSTR a_clr_version);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_initialize_with_path_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing18_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing18_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing19_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing19_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_is_initialized_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_is_initialized_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_is_initialized_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ VARIANT_BOOL p1);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_is_initialized_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_is_successful_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_is_successful_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_is_successful_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ VARIANT_BOOL p1);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_is_successful_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_last_error_message_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_last_error_message_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_last_error_message_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR p1);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER__set_last_error_message_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing26_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_Missing26_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_relative_folder_name_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_name,
    /* [in] */ BSTR a_version,
    /* [in] */ BSTR a_culture,
    /* [in] */ BSTR a_key,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_relative_folder_name_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_relative_folder_name_from_path_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This,
    /* [in] */ BSTR a_path,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_relative_folder_name_from_path_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_unload_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_unload_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __EiffelSoftware_MetadataConsumer_COM_CACHE_MANAGER_INTERFACE_DEFINED__ */


#ifndef __EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_INTERFACE_DEFINED__
#define __EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_INTERFACE_DEFINED__

/* interface EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION */
/* [object][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("E1FFE1B6-5067-499A-9A25-E6DDA9076E77")
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION : public IDispatch
    {
    public:
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE consumed_folder_name( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE culture( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing9( void) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing10( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE is_consumed( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [restricted] */ void STDMETHODCALLTYPE Missing12( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE name( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE public_key_token( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE version( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATIONVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *consumed_folder_name )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *culture )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing9 )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing10 )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *is_consumed )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [restricted] */ void ( STDMETHODCALLTYPE *Missing12 )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *name )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *public_key_token )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *version )( 
            EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        END_INTERFACE
    } EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATIONVtbl;

    interface EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION
    {
        CONST_VTBL struct EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATIONVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_consumed_folder_name(This,pRetVal)	\
    (This)->lpVtbl -> consumed_folder_name(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_culture(This,pRetVal)	\
    (This)->lpVtbl -> culture(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing9(This)	\
    (This)->lpVtbl -> Missing9(This)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing10(This)	\
    (This)->lpVtbl -> Missing10(This)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_is_consumed(This,pRetVal)	\
    (This)->lpVtbl -> is_consumed(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing12(This)	\
    (This)->lpVtbl -> Missing12(This)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_name(This,pRetVal)	\
    (This)->lpVtbl -> name(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_public_key_token(This,pRetVal)	\
    (This)->lpVtbl -> public_key_token(This,pRetVal)

#define EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_version(This,pRetVal)	\
    (This)->lpVtbl -> version(This,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_consumed_folder_name_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_consumed_folder_name_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_culture_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_culture_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing9_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing9_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing10_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing10_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_is_consumed_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_is_consumed_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [restricted] */ void STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing12_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_Missing12_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_name_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_name_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_public_key_token_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_public_key_token_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_version_Proxy( 
    EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_version_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __EiffelSoftware_MetadataConsumer_COM_ASSEMBLY_INFORMATION_INTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER;

#ifdef __cplusplus

class DECLSPEC_UUID("E1FFE121-BD03-4F43-B575-655DAC9941A3")
EiffelSoftware_MetadataConsumer_Impl_COM_CACHE_MANAGER;
#endif
#endif /* __EiffelSoftware_MetadataConsumer_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


