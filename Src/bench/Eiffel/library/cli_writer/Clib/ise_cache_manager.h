
#pragma warning( disable: 4049 )  /* more than 64k source lines */

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 6.00.0347 */
/* at Wed Aug 28 18:06:27 2002
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


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 440
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __ise_cache_manager_h__
#define __ise_cache_manager_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __ISE_Cache_COM_ISE_CACHE_MANAGER_FWD_DEFINED__
#define __ISE_Cache_COM_ISE_CACHE_MANAGER_FWD_DEFINED__
typedef interface ISE_Cache_COM_ISE_CACHE_MANAGER ISE_Cache_COM_ISE_CACHE_MANAGER;
#endif 	/* __ISE_Cache_COM_ISE_CACHE_MANAGER_FWD_DEFINED__ */


#ifndef __ISE_Cache_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__
#define __ISE_Cache_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__
typedef interface ISE_Cache_COM_ASSEMBLY_INFORMATION ISE_Cache_COM_ASSEMBLY_INFORMATION;
#endif 	/* __ISE_Cache_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__ */


#ifndef __ISE_Cache_Impl_COM_ISE_CACHE_MANAGER_FWD_DEFINED__
#define __ISE_Cache_Impl_COM_ISE_CACHE_MANAGER_FWD_DEFINED__

#ifdef __cplusplus
typedef class ISE_Cache_Impl_COM_ISE_CACHE_MANAGER ISE_Cache_Impl_COM_ISE_CACHE_MANAGER;
#else
typedef struct ISE_Cache_Impl_COM_ISE_CACHE_MANAGER ISE_Cache_Impl_COM_ISE_CACHE_MANAGER;
#endif /* __cplusplus */

#endif 	/* __ISE_Cache_Impl_COM_ISE_CACHE_MANAGER_FWD_DEFINED__ */


#ifndef __ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__
#define __ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__

#ifdef __cplusplus
typedef class ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION;
#else
typedef struct ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION;
#endif /* __cplusplus */

#endif 	/* __ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION_FWD_DEFINED__ */


#ifdef __cplusplus
extern "C"{
#endif 

void * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void * ); 


#ifndef __emitter_LIBRARY_DEFINED__
#define __emitter_LIBRARY_DEFINED__

/* library emitter */
/* [version][uuid] */ 




EXTERN_C const IID LIBID_emitter;

#ifndef __ISE_Cache_COM_ISE_CACHE_MANAGER_INTERFACE_DEFINED__
#define __ISE_Cache_COM_ISE_CACHE_MANAGER_INTERFACE_DEFINED__

/* interface ISE_Cache_COM_ISE_CACHE_MANAGER */
/* [object][custom][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_ISE_Cache_COM_ISE_CACHE_MANAGER;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("E3526F85-A118-3FBC-B445-417452D1AAA5")
    ISE_Cache_COM_ISE_CACHE_MANAGER : public IDispatch
    {
    public:
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE make( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE is_successful( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE is_initialized( 
            /* [retval][out] */ VARIANT_BOOL *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE last_error_message( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE initialize( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE initialize_with_path( 
            /* [in] */ BSTR a_path) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE consume_gac_assembly( 
            /* [in] */ BSTR aname,
            /* [in] */ BSTR aversion,
            /* [in] */ BSTR aculture,
            /* [in] */ BSTR akey) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE consume_local_assembly( 
            /* [in] */ BSTR apath,
            /* [in] */ BSTR adest) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE relative_folder_name( 
            /* [in] */ BSTR aname,
            /* [in] */ BSTR aversion,
            /* [in] */ BSTR aculture,
            /* [in] */ BSTR akey,
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE assembly_info_from_assembly( 
            /* [in] */ BSTR apath,
            /* [retval][out] */ ISE_Cache_COM_ASSEMBLY_INFORMATION **pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct ISE_Cache_COM_ISE_CACHE_MANAGERVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *make )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *is_successful )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *is_initialized )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [retval][out] */ VARIANT_BOOL *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *last_error_message )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *initialize )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *initialize_with_path )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ BSTR a_path);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *consume_gac_assembly )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ BSTR aname,
            /* [in] */ BSTR aversion,
            /* [in] */ BSTR aculture,
            /* [in] */ BSTR akey);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *consume_local_assembly )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ BSTR apath,
            /* [in] */ BSTR adest);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *relative_folder_name )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ BSTR aname,
            /* [in] */ BSTR aversion,
            /* [in] */ BSTR aculture,
            /* [in] */ BSTR akey,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *assembly_info_from_assembly )( 
            ISE_Cache_COM_ISE_CACHE_MANAGER * This,
            /* [in] */ BSTR apath,
            /* [retval][out] */ ISE_Cache_COM_ASSEMBLY_INFORMATION **pRetVal);
        
        END_INTERFACE
    } ISE_Cache_COM_ISE_CACHE_MANAGERVtbl;

    interface ISE_Cache_COM_ISE_CACHE_MANAGER
    {
        CONST_VTBL struct ISE_Cache_COM_ISE_CACHE_MANAGERVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define ISE_Cache_COM_ISE_CACHE_MANAGER_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define ISE_Cache_COM_ISE_CACHE_MANAGER_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define ISE_Cache_COM_ISE_CACHE_MANAGER_make(This)	\
    (This)->lpVtbl -> make(This)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_is_successful(This,pRetVal)	\
    (This)->lpVtbl -> is_successful(This,pRetVal)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_is_initialized(This,pRetVal)	\
    (This)->lpVtbl -> is_initialized(This,pRetVal)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_last_error_message(This,pRetVal)	\
    (This)->lpVtbl -> last_error_message(This,pRetVal)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_initialize(This)	\
    (This)->lpVtbl -> initialize(This)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_initialize_with_path(This,a_path)	\
    (This)->lpVtbl -> initialize_with_path(This,a_path)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_consume_gac_assembly(This,aname,aversion,aculture,akey)	\
    (This)->lpVtbl -> consume_gac_assembly(This,aname,aversion,aculture,akey)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_consume_local_assembly(This,apath,adest)	\
    (This)->lpVtbl -> consume_local_assembly(This,apath,adest)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_relative_folder_name(This,aname,aversion,aculture,akey,pRetVal)	\
    (This)->lpVtbl -> relative_folder_name(This,aname,aversion,aculture,akey,pRetVal)

#define ISE_Cache_COM_ISE_CACHE_MANAGER_assembly_info_from_assembly(This,apath,pRetVal)	\
    (This)->lpVtbl -> assembly_info_from_assembly(This,apath,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_make_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_make_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_is_successful_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_is_successful_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_is_initialized_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This,
    /* [retval][out] */ VARIANT_BOOL *pRetVal);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_is_initialized_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_last_error_message_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_last_error_message_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_initialize_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_initialize_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_initialize_with_path_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This,
    /* [in] */ BSTR a_path);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_initialize_with_path_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_consume_gac_assembly_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This,
    /* [in] */ BSTR aname,
    /* [in] */ BSTR aversion,
    /* [in] */ BSTR aculture,
    /* [in] */ BSTR akey);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_consume_gac_assembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_consume_local_assembly_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This,
    /* [in] */ BSTR apath,
    /* [in] */ BSTR adest);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_consume_local_assembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_relative_folder_name_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This,
    /* [in] */ BSTR aname,
    /* [in] */ BSTR aversion,
    /* [in] */ BSTR aculture,
    /* [in] */ BSTR akey,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_relative_folder_name_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ISE_CACHE_MANAGER_assembly_info_from_assembly_Proxy( 
    ISE_Cache_COM_ISE_CACHE_MANAGER * This,
    /* [in] */ BSTR apath,
    /* [retval][out] */ ISE_Cache_COM_ASSEMBLY_INFORMATION **pRetVal);


void __RPC_STUB ISE_Cache_COM_ISE_CACHE_MANAGER_assembly_info_from_assembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __ISE_Cache_COM_ISE_CACHE_MANAGER_INTERFACE_DEFINED__ */


#ifndef __ISE_Cache_COM_ASSEMBLY_INFORMATION_INTERFACE_DEFINED__
#define __ISE_Cache_COM_ASSEMBLY_INFORMATION_INTERFACE_DEFINED__

/* interface ISE_Cache_COM_ASSEMBLY_INFORMATION */
/* [object][custom][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_ISE_Cache_COM_ASSEMBLY_INFORMATION;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("FD2F67FF-FF44-3B67-A55D-8EE3086D3970")
    ISE_Cache_COM_ASSEMBLY_INFORMATION : public IDispatch
    {
    public:
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE make( 
            /* [in] */ IUnknown *ass) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE name( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE version( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE culture( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE public_key_token( 
            /* [retval][out] */ BSTR *pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct ISE_Cache_COM_ASSEMBLY_INFORMATIONVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *make )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [in] */ IUnknown *ass);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *name )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *version )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *culture )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE *public_key_token )( 
            ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
            /* [retval][out] */ BSTR *pRetVal);
        
        END_INTERFACE
    } ISE_Cache_COM_ASSEMBLY_INFORMATIONVtbl;

    interface ISE_Cache_COM_ASSEMBLY_INFORMATION
    {
        CONST_VTBL struct ISE_Cache_COM_ASSEMBLY_INFORMATIONVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define ISE_Cache_COM_ASSEMBLY_INFORMATION_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define ISE_Cache_COM_ASSEMBLY_INFORMATION_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define ISE_Cache_COM_ASSEMBLY_INFORMATION_make(This,ass)	\
    (This)->lpVtbl -> make(This,ass)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_name(This,pRetVal)	\
    (This)->lpVtbl -> name(This,pRetVal)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_version(This,pRetVal)	\
    (This)->lpVtbl -> version(This,pRetVal)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_culture(This,pRetVal)	\
    (This)->lpVtbl -> culture(This,pRetVal)

#define ISE_Cache_COM_ASSEMBLY_INFORMATION_public_key_token(This,pRetVal)	\
    (This)->lpVtbl -> public_key_token(This,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ASSEMBLY_INFORMATION_make_Proxy( 
    ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
    /* [in] */ IUnknown *ass);


void __RPC_STUB ISE_Cache_COM_ASSEMBLY_INFORMATION_make_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ASSEMBLY_INFORMATION_name_Proxy( 
    ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB ISE_Cache_COM_ASSEMBLY_INFORMATION_name_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ASSEMBLY_INFORMATION_version_Proxy( 
    ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB ISE_Cache_COM_ASSEMBLY_INFORMATION_version_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ASSEMBLY_INFORMATION_culture_Proxy( 
    ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB ISE_Cache_COM_ASSEMBLY_INFORMATION_culture_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE ISE_Cache_COM_ASSEMBLY_INFORMATION_public_key_token_Proxy( 
    ISE_Cache_COM_ASSEMBLY_INFORMATION * This,
    /* [retval][out] */ BSTR *pRetVal);


void __RPC_STUB ISE_Cache_COM_ASSEMBLY_INFORMATION_public_key_token_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __ISE_Cache_COM_ASSEMBLY_INFORMATION_INTERFACE_DEFINED__ */


EXTERN_C const CLSID CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER;

#ifdef __cplusplus

class DECLSPEC_UUID("01BDF738-3044-3ED6-BA7B-34632D67E145")
ISE_Cache_Impl_COM_ISE_CACHE_MANAGER;
#endif

EXTERN_C const CLSID CLSID_ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION;

#ifdef __cplusplus

class DECLSPEC_UUID("7F6F58E1-29FD-3FB3-B612-72205FE907E3")
ISE_Cache_Impl_COM_ASSEMBLY_INFORMATION;
#endif
#endif /* __emitter_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


