/* this ALWAYS GENERATED file contains the definitions for the interfaces */


/* File created by MIDL compiler version 5.01.0164 */
/* at Mon Jul 08 15:01:52 2002
 */
/* Compiler settings for ISE.VS.FusionSupport.IDL:
    Os (OptLev=s), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: allocation ref bounds_check enum stub_data 
*/
//@@MIDL_FILE_HEADING(  )


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 440
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __header_h__
#define __header_h__

#ifdef __cplusplus
extern "C"{
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


#ifndef ___Fusion_FWD_DEFINED__
#define ___Fusion_FWD_DEFINED__
typedef interface _Fusion _Fusion;
#endif 	/* ___Fusion_FWD_DEFINED__ */


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


#ifndef __Fusion_FWD_DEFINED__
#define __Fusion_FWD_DEFINED__

#ifdef __cplusplus
typedef class Fusion Fusion;
#else
typedef struct Fusion Fusion;
#endif /* __cplusplus */

#endif 	/* __Fusion_FWD_DEFINED__ */


#ifndef __FusionSupport_FWD_DEFINED__
#define __FusionSupport_FWD_DEFINED__

#ifdef __cplusplus
typedef class FusionSupport FusionSupport;
#else
typedef struct FusionSupport FusionSupport;
#endif /* __cplusplus */

#endif 	/* __FusionSupport_FWD_DEFINED__ */


void __RPC_FAR * __RPC_USER MIDL_user_allocate(size_t);
void __RPC_USER MIDL_user_free( void __RPC_FAR * ); 


#ifndef __ISE_VS_FusionSupport_LIBRARY_DEFINED__
#define __ISE_VS_FusionSupport_LIBRARY_DEFINED__

/* library ISE_VS_FusionSupport */
/* [helpstring][version][uuid] */ 






EXTERN_C const IID LIBID_ISE_VS_FusionSupport;

#ifndef __IAssemblyInfo_INTERFACE_DEFINED__
#define __IAssemblyInfo_INTERFACE_DEFINED__

/* interface IAssemblyInfo */
/* [object][custom][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_IAssemblyInfo;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("8BE7FCFE-CDFC-4EE8-B0F2-F8D11CC8B468")
    IAssemblyInfo : public IDispatch
    {
    public:
        virtual /* [propget][id] */ HRESULT STDMETHODCALLTYPE get_AssemblyName( 
            /* [retval][out] */ BSTR __RPC_FAR *pRetVal) = 0;
        
        virtual /* [propget][id] */ HRESULT STDMETHODCALLTYPE get_Version( 
            /* [retval][out] */ BSTR __RPC_FAR *pRetVal) = 0;
        
        virtual /* [propget][id] */ HRESULT STDMETHODCALLTYPE get_Culture( 
            /* [retval][out] */ BSTR __RPC_FAR *pRetVal) = 0;
        
        virtual /* [propget][id] */ HRESULT STDMETHODCALLTYPE get_PublicKeyToken( 
            /* [retval][out] */ BSTR __RPC_FAR *pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IAssemblyInfoVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            IAssemblyInfo __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            IAssemblyInfo __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        /* [propget][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_AssemblyName )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pRetVal);
        
        /* [propget][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Version )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pRetVal);
        
        /* [propget][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Culture )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pRetVal);
        
        /* [propget][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_PublicKeyToken )( 
            IAssemblyInfo __RPC_FAR * This,
            /* [retval][out] */ BSTR __RPC_FAR *pRetVal);
        
        END_INTERFACE
    } IAssemblyInfoVtbl;

    interface IAssemblyInfo
    {
        CONST_VTBL struct IAssemblyInfoVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IAssemblyInfo_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IAssemblyInfo_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IAssemblyInfo_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IAssemblyInfo_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define IAssemblyInfo_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define IAssemblyInfo_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define IAssemblyInfo_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define IAssemblyInfo_get_AssemblyName(This,pRetVal)	\
    (This)->lpVtbl -> get_AssemblyName(This,pRetVal)

#define IAssemblyInfo_get_Version(This,pRetVal)	\
    (This)->lpVtbl -> get_Version(This,pRetVal)

#define IAssemblyInfo_get_Culture(This,pRetVal)	\
    (This)->lpVtbl -> get_Culture(This,pRetVal)

#define IAssemblyInfo_get_PublicKeyToken(This,pRetVal)	\
    (This)->lpVtbl -> get_PublicKeyToken(This,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [propget][id] */ HRESULT STDMETHODCALLTYPE IAssemblyInfo_get_AssemblyName_Proxy( 
    IAssemblyInfo __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pRetVal);


void __RPC_STUB IAssemblyInfo_get_AssemblyName_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [propget][id] */ HRESULT STDMETHODCALLTYPE IAssemblyInfo_get_Version_Proxy( 
    IAssemblyInfo __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pRetVal);


void __RPC_STUB IAssemblyInfo_get_Version_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [propget][id] */ HRESULT STDMETHODCALLTYPE IAssemblyInfo_get_Culture_Proxy( 
    IAssemblyInfo __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pRetVal);


void __RPC_STUB IAssemblyInfo_get_Culture_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [propget][id] */ HRESULT STDMETHODCALLTYPE IAssemblyInfo_get_PublicKeyToken_Proxy( 
    IAssemblyInfo __RPC_FAR * This,
    /* [retval][out] */ BSTR __RPC_FAR *pRetVal);


void __RPC_STUB IAssemblyInfo_get_PublicKeyToken_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IAssemblyInfo_INTERFACE_DEFINED__ */


#ifndef __IEnumAssemblies_INTERFACE_DEFINED__
#define __IEnumAssemblies_INTERFACE_DEFINED__

/* interface IEnumAssemblies */
/* [object][custom][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_IEnumAssemblies;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("311C80AE-545A-43B1-9D06-9FBF0BD85B1E")
    IEnumAssemblies : public IDispatch
    {
    public:
        virtual /* [propget][id] */ HRESULT STDMETHODCALLTYPE get_Current( 
            /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE Reset( void) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE MoveNext( 
            /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pRetVal) = 0;
        
        virtual /* [propget][id] */ HRESULT STDMETHODCALLTYPE get_Count( 
            /* [retval][out] */ long __RPC_FAR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE IthItem( 
            /* [in] */ long index,
            /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IEnumAssembliesVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            IEnumAssemblies __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            IEnumAssemblies __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        /* [propget][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Current )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Reset )( 
            IEnumAssemblies __RPC_FAR * This);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *MoveNext )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pRetVal);
        
        /* [propget][id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *get_Count )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [retval][out] */ long __RPC_FAR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *IthItem )( 
            IEnumAssemblies __RPC_FAR * This,
            /* [in] */ long index,
            /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal);
        
        END_INTERFACE
    } IEnumAssembliesVtbl;

    interface IEnumAssemblies
    {
        CONST_VTBL struct IEnumAssembliesVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IEnumAssemblies_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IEnumAssemblies_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IEnumAssemblies_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IEnumAssemblies_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define IEnumAssemblies_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define IEnumAssemblies_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define IEnumAssemblies_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


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



/* [propget][id] */ HRESULT STDMETHODCALLTYPE IEnumAssemblies_get_Current_Proxy( 
    IEnumAssemblies __RPC_FAR * This,
    /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal);


void __RPC_STUB IEnumAssemblies_get_Current_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE IEnumAssemblies_Reset_Proxy( 
    IEnumAssemblies __RPC_FAR * This);


void __RPC_STUB IEnumAssemblies_Reset_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE IEnumAssemblies_MoveNext_Proxy( 
    IEnumAssemblies __RPC_FAR * This,
    /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pRetVal);


void __RPC_STUB IEnumAssemblies_MoveNext_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [propget][id] */ HRESULT STDMETHODCALLTYPE IEnumAssemblies_get_Count_Proxy( 
    IEnumAssemblies __RPC_FAR * This,
    /* [retval][out] */ long __RPC_FAR *pRetVal);


void __RPC_STUB IEnumAssemblies_get_Count_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE IEnumAssemblies_IthItem_Proxy( 
    IEnumAssemblies __RPC_FAR * This,
    /* [in] */ long index,
    /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal);


void __RPC_STUB IEnumAssemblies_IthItem_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IEnumAssemblies_INTERFACE_DEFINED__ */


#ifndef __IFusionSupport_INTERFACE_DEFINED__
#define __IFusionSupport_INTERFACE_DEFINED__

/* interface IFusionSupport */
/* [object][custom][oleautomation][dual][version][uuid] */ 


EXTERN_C const IID IID_IFusionSupport;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("071C5850-5C74-4C53-887B-F8183591D684")
    IFusionSupport : public IDispatch
    {
    public:
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE GetGacAssemblies( 
            /* [retval][out] */ IEnumAssemblies __RPC_FAR *__RPC_FAR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE IsAssemblySigned( 
            /* [in] */ BSTR path,
            /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pRetVal) = 0;
        
        virtual /* [id] */ HRESULT STDMETHODCALLTYPE GetAssemblyInfoFromAssembly( 
            /* [in] */ BSTR path,
            /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IFusionSupportVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            IFusionSupport __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            IFusionSupport __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            IFusionSupport __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            IFusionSupport __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            IFusionSupport __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            IFusionSupport __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            IFusionSupport __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetGacAssemblies )( 
            IFusionSupport __RPC_FAR * This,
            /* [retval][out] */ IEnumAssemblies __RPC_FAR *__RPC_FAR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *IsAssemblySigned )( 
            IFusionSupport __RPC_FAR * This,
            /* [in] */ BSTR path,
            /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pRetVal);
        
        /* [id] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetAssemblyInfoFromAssembly )( 
            IFusionSupport __RPC_FAR * This,
            /* [in] */ BSTR path,
            /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal);
        
        END_INTERFACE
    } IFusionSupportVtbl;

    interface IFusionSupport
    {
        CONST_VTBL struct IFusionSupportVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IFusionSupport_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define IFusionSupport_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define IFusionSupport_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define IFusionSupport_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define IFusionSupport_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define IFusionSupport_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define IFusionSupport_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#define IFusionSupport_GetGacAssemblies(This,pRetVal)	\
    (This)->lpVtbl -> GetGacAssemblies(This,pRetVal)

#define IFusionSupport_IsAssemblySigned(This,path,pRetVal)	\
    (This)->lpVtbl -> IsAssemblySigned(This,path,pRetVal)

#define IFusionSupport_GetAssemblyInfoFromAssembly(This,path,pRetVal)	\
    (This)->lpVtbl -> GetAssemblyInfoFromAssembly(This,path,pRetVal)

#endif /* COBJMACROS */


#endif 	/* C style interface */



/* [id] */ HRESULT STDMETHODCALLTYPE IFusionSupport_GetGacAssemblies_Proxy( 
    IFusionSupport __RPC_FAR * This,
    /* [retval][out] */ IEnumAssemblies __RPC_FAR *__RPC_FAR *pRetVal);


void __RPC_STUB IFusionSupport_GetGacAssemblies_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE IFusionSupport_IsAssemblySigned_Proxy( 
    IFusionSupport __RPC_FAR * This,
    /* [in] */ BSTR path,
    /* [retval][out] */ VARIANT_BOOL __RPC_FAR *pRetVal);


void __RPC_STUB IFusionSupport_IsAssemblySigned_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);


/* [id] */ HRESULT STDMETHODCALLTYPE IFusionSupport_GetAssemblyInfoFromAssembly_Proxy( 
    IFusionSupport __RPC_FAR * This,
    /* [in] */ BSTR path,
    /* [retval][out] */ IAssemblyInfo __RPC_FAR *__RPC_FAR *pRetVal);


void __RPC_STUB IFusionSupport_GetAssemblyInfoFromAssembly_Stub(
    IRpcStubBuffer *This,
    IRpcChannelBuffer *_pRpcChannelBuffer,
    PRPC_MESSAGE _pRpcMessage,
    DWORD *_pdwStubPhase);



#endif 	/* __IFusionSupport_INTERFACE_DEFINED__ */


#ifndef ___Fusion_INTERFACE_DEFINED__
#define ___Fusion_INTERFACE_DEFINED__

/* interface _Fusion */
/* [object][custom][oleautomation][dual][hidden][uuid] */ 


EXTERN_C const IID IID__Fusion;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("7AAA073D-616D-3654-8442-F62183D2CCEB")
    _Fusion : public IDispatch
    {
    public:
    };
    
#else 	/* C style interface */

    typedef struct _FusionVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( 
            _Fusion __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [iid_is][out] */ void __RPC_FAR *__RPC_FAR *ppvObject);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( 
            _Fusion __RPC_FAR * This);
        
        ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( 
            _Fusion __RPC_FAR * This);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( 
            _Fusion __RPC_FAR * This,
            /* [out] */ UINT __RPC_FAR *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( 
            _Fusion __RPC_FAR * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( 
            _Fusion __RPC_FAR * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR __RPC_FAR *rgszNames,
            /* [in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID __RPC_FAR *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( 
            _Fusion __RPC_FAR * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS __RPC_FAR *pDispParams,
            /* [out] */ VARIANT __RPC_FAR *pVarResult,
            /* [out] */ EXCEPINFO __RPC_FAR *pExcepInfo,
            /* [out] */ UINT __RPC_FAR *puArgErr);
        
        END_INTERFACE
    } _FusionVtbl;

    interface _Fusion
    {
        CONST_VTBL struct _FusionVtbl __RPC_FAR *lpVtbl;
    };

    

#ifdef COBJMACROS


#define _Fusion_QueryInterface(This,riid,ppvObject)	\
    (This)->lpVtbl -> QueryInterface(This,riid,ppvObject)

#define _Fusion_AddRef(This)	\
    (This)->lpVtbl -> AddRef(This)

#define _Fusion_Release(This)	\
    (This)->lpVtbl -> Release(This)


#define _Fusion_GetTypeInfoCount(This,pctinfo)	\
    (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo)

#define _Fusion_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo)

#define _Fusion_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)

#define _Fusion_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)


#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* ___Fusion_INTERFACE_DEFINED__ */


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

EXTERN_C const CLSID CLSID_Fusion;

#ifdef __cplusplus

class DECLSPEC_UUID("366C5251-C4CF-344B-809B-362E6A20263E")
Fusion;
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
