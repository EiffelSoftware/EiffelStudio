/////////////////////////////////////////////////////////////////////////////
//
//     WRAPFUNC.H     Copyright (c) 1996 by SiG Computer
//
//     Version:       0.00
//
//     Eiffel OLE 2 Library
//
//     OLE2->Eiffel & Eiffel->OLE2 call support
//
//     Notes:
//       None.
//

#ifndef __WRAPFUNC_H_INC__
#define __WRAPFUNC_H_INC__

/////////////////////////////////////////////////////////////////////////////
//
// IUnknown
//

extern "C" HRESULT E_IUnknown_QueryInterface(
        void* ptr, BOOL incomingCall,
        REFIID riid, LPVOID FAR* ppvObj );
extern "C" ULONG E_IUnknown_AddRef(
        void* ptr, BOOL incomingCall );
extern "C" ULONG E_IUnknown_Release(
        void *ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IAdviseSink
//

//extern "C" void E_IAdviseSink_OnDataChange(
//        void* ptr, BOOL incomingCall,
//        FORMATETC __RPC_FAR *pFormatetc,
//        STGMEDIUM __RPC_FAR *pStgmed );
//extern "C" void E_IAdviseSink_OnViewChange(
//        void* ptr, BOOL incomingCall,
//        DWORD dwAspect, LONG lindex );
//extern "C" void E_IAdviseSink_OnRename(
//        void* ptr, BOOL incomingCall,
//        IMoniker __RPC_FAR *pmk );
//extern "C" void E_IAdviseSink_OnSave(
//        void* ptr, BOOL incomingCall );
//extern "C" void E_IAdviseSink_OnClose(
//        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IAdviseSink2
//

//extern "C" void E_IAdviseSink2_OnLinkSrcChange(
//        void* ptr, BOOL incomingCall,
//        IMoniker __RPC_FAR *pmk );

/////////////////////////////////////////////////////////////////////////////
//
// IBindCtx
//

extern "C" HRESULT E_IBindCtx_RegisterObjectBound(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *punk );
extern "C" HRESULT E_IBindCtx_RevokeObjectBound(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *punk );
extern "C" HRESULT E_IBindCtx_ReleaseBoundObjects(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IBindCtx_SetBindOptions(
        void* ptr, BOOL incomingCall,
        BIND_OPTS __RPC_FAR *pbindopts );
extern "C" HRESULT E_IBindCtx_GetBindOptions(
        void* ptr, BOOL incomingCall,
        BIND_OPTS __RPC_FAR *pbindopts );
extern "C" HRESULT E_IBindCtx_GetRunningObjectTable(
        void* ptr, BOOL incomingCall,
        IRunningObjectTable __RPC_FAR *__RPC_FAR *pprot );
extern "C" HRESULT E_IBindCtx_RegisterObjectParam(
        void* ptr, BOOL incomingCall,
        LPOLESTR pszKey,
        IUnknown __RPC_FAR *punk );
extern "C" HRESULT E_IBindCtx_GetObjectParam(
        void* ptr, BOOL incomingCall,
        LPOLESTR pszKey,
        IUnknown __RPC_FAR *__RPC_FAR *ppunk );
extern "C" HRESULT E_IBindCtx_EnumObjectParam(
        void* ptr, BOOL incomingCall,
        IEnumString __RPC_FAR *__RPC_FAR *ppenum );
extern "C" HRESULT E_IBindCtx_RevokeObjectParam(
        void* ptr, BOOL incomingCall,
        LPOLESTR pszKey );

/////////////////////////////////////////////////////////////////////////////
//
// IClassFactory
//

extern "C" HRESULT E_IClassFactory_CreateInstance(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *pUnkOuter,
        REFIID riid, void __RPC_FAR *__RPC_FAR *ppvObject );
extern "C" HRESULT E_IClassFactory_LockServer(
        void* ptr, BOOL incomingCall,
        BOOL fLock );

/////////////////////////////////////////////////////////////////////////////
//
// IClassFactory2
//

extern "C" HRESULT E_IClassFactory2_GetLicInfo(
        void* ptr, BOOL incomingCall,
        LPLICINFO pLicInfo );
extern "C" HRESULT E_IClassFactory2_RequestLicKey(
        void* ptr, BOOL incomingCall,
        DWORD dwResrved, BSTR FAR* pbstrKey );
extern "C" HRESULT E_IClassFactory2_CreateInstanceLic(
        void* ptr, BOOL incomingCall,
        LPUNKNOWN pUnkOuter,
        LPUNKNOWN pUnkReserved,
        REFIID riid,
        BSTR bstrKey,
        LPVOID FAR* ppvObject );

/////////////////////////////////////////////////////////////////////////////
//
// IConnectionPointContainer
//

extern "C" HRESULT E_IConnectionPointContainer_EnumConnectionPoints(
        void* ptr, BOOL incomingCall,
        LPENUMCONNECTIONPOINTS FAR* ppEnum );
extern "C" HRESULT E_IConnectionPointContainer_FindConnectionPoint(
        void* ptr, BOOL incomingCall,
        REFIID iid,
        LPCONNECTIONPOINT FAR* ppCP );

/////////////////////////////////////////////////////////////////////////////
//
// IConnectionPoint
//

extern "C" HRESULT E_IConnectionPoint_GetConnectionInterface(
        void* ptr, BOOL incomingCall,
        IID* pIID );
extern "C" HRESULT E_IConnectionPoint_GetConnectionPointContainer(
        void* ptr, BOOL incomingCall,
        IConnectionPointContainer FAR* FAR* ppCPC );
extern "C" HRESULT E_IConnectionPoint_Advise(
        void* ptr, BOOL incomingCall,
        LPUNKNOWN pUnkSink, DWORD FAR* pdwCookie );
extern "C" HRESULT E_IConnectionPoint_Unadvise(
        void* ptr, BOOL incomingCall,
        DWORD dwCookie );
extern "C" HRESULT E_IConnectionPoint_EnumConnections(
        void* ptr, BOOL incomingCall,
        LPENUMCONNECTIONS FAR* ppEnum );

/////////////////////////////////////////////////////////////////////////////
//
// ICreateErrorInfo
//

extern "C" HRESULT E_ICreateErrorInfo_SetGUID(
        void* ptr, BOOL incomingCall,
        REFGUID rguid );
extern "C" HRESULT E_ICreateErrorInfo_SetSource(
        void* ptr, BOOL incomingCall,
        LPOLESTR szSource );
extern "C" HRESULT E_ICreateErrorInfo_SetDescription(
        void* ptr, BOOL incomingCall,
        LPOLESTR szDescription );
extern "C" HRESULT E_ICreateErrorInfo_SetHelpFile(
        void* ptr, BOOL incomingCall,
        LPOLESTR szHelpFile );
extern "C" HRESULT E_ICreateErrorInfo_SetHelpContext(
        void* ptr, BOOL incomingCall,
        DWORD dwHelpContext );

/////////////////////////////////////////////////////////////////////////////
//
// ICreateTypeInfo
//

extern "C" HRESULT E_ICreateTypeInfo_SetGuid(
        void* ptr, BOOL incomingCall,
        REFGUID guid );
extern "C" HRESULT E_ICreateTypeInfo_SetTypeFlags(
        void* ptr, BOOL incomingCall,
        UINT uTypeFlags );
extern "C" HRESULT E_ICreateTypeInfo_SetDocString(
        void* ptr, BOOL incomingCall,
        LPOLESTR lpstrDoc );
extern "C" HRESULT E_ICreateTypeInfo_SetHelpContext(
        void* ptr, BOOL incomingCall,
        DWORD dwHelpContext );
extern "C" HRESULT E_ICreateTypeInfo_SetVersion(
        void* ptr, BOOL incomingCall,
        WORD wMajorVerNum, WORD wMinorVerNum );
extern "C" HRESULT E_ICreateTypeInfo_AddRefTypeInfo(
        void* ptr, BOOL incomingCall,
        ITypeInfo __RPC_FAR *ptinfo,
        HREFTYPE __RPC_FAR *phreftype );
extern "C" HRESULT E_ICreateTypeInfo_AddFuncDesc(
        void* ptr, BOOL incomingCall,
        UINT index, FUNCDESC __RPC_FAR *pfuncdesc );
extern "C" HRESULT E_ICreateTypeInfo_AddImplType(
        void* ptr, BOOL incomingCall,
        UINT index, HREFTYPE hreftype );
extern "C" HRESULT E_ICreateTypeInfo_SetImplTypeFlags(
        void* ptr, BOOL incomingCall,
        UINT index, INT impltypeflags );
extern "C" HRESULT E_ICreateTypeInfo_SetAlignment(
        void* ptr, BOOL incomingCall,
        WORD cbAlignment );
extern "C" HRESULT E_ICreateTypeInfo_SetSchema(
        void* ptr, BOOL incomingCall,
        LPOLESTR lpstrSchema );
extern "C" HRESULT E_ICreateTypeInfo_AddVarDesc(
        void* ptr, BOOL incomingCall,
        UINT index, VARDESC __RPC_FAR *pvardesc );
extern "C" HRESULT E_ICreateTypeInfo_SetFuncAndParamNames(
        void* ptr, BOOL incomingCall,
        UINT index,
        LPOLESTR __RPC_FAR *rgszNames,
        UINT cNames );
extern "C" HRESULT E_ICreateTypeInfo_SetVarName(
        void* ptr, BOOL incomingCall,
        UINT index, LPOLESTR szName );
extern "C" HRESULT E_ICreateTypeInfo_SetTypeDescAlias(
        void* ptr, BOOL incomingCall,
        TYPEDESC __RPC_FAR *ptdescAlias );
extern "C" HRESULT E_ICreateTypeInfo_DefineFuncAsDllEntry(
        void* ptr, BOOL incomingCall,
        UINT index, LPOLESTR szDllName,
        LPOLESTR szProcName );
extern "C" HRESULT E_ICreateTypeInfo_SetFuncDocString(
        void* ptr, BOOL incomingCall,
        UINT index, LPOLESTR szDocString );
extern "C" HRESULT E_ICreateTypeInfo_SetVarDocString(
        void* ptr, BOOL incomingCall,
        UINT index, LPOLESTR szDocString );
extern "C" HRESULT E_ICreateTypeInfo_SetFuncHelpContext(
        void* ptr, BOOL incomingCall,
        UINT index, DWORD dwHelpContext );
extern "C" HRESULT E_ICreateTypeInfo_SetVarHelpContext(
        void* ptr, BOOL incomingCall,
        UINT index, DWORD dwHelpContext );
extern "C" HRESULT E_ICreateTypeInfo_SetMops(
        void* ptr, BOOL incomingCall,
        UINT index, BSTR bstrMops );
extern "C" HRESULT E_ICreateTypeInfo_SetTypeIdldesc(
        void* ptr, BOOL incomingCall,
        IDLDESC __RPC_FAR *pidldesc );
extern "C" HRESULT E_ICreateTypeInfo_LayOut(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// ICreateTypeLib
//

extern "C" HRESULT E_ICreateTypeLib_CreateTypeInfo(
        void* ptr, BOOL incomingCall,
        LPOLESTR szName, TYPEKIND tkind,
        ICreateTypeInfo __RPC_FAR *__RPC_FAR *lplpictinfo );
extern "C" HRESULT E_ICreateTypeLib_SetName(
        void* ptr, BOOL incomingCall,
        LPOLESTR szName );
extern "C" HRESULT E_ICreateTypeLib_SetVersion(
        void* ptr, BOOL incomingCall,
        WORD wMajorVerNum, WORD wMinorVerNum );
extern "C" HRESULT E_ICreateTypeLib_SetGuid(
        void* ptr, BOOL incomingCall,
        REFGUID guid );
extern "C" HRESULT E_ICreateTypeLib_SetDocString(
        void* ptr, BOOL incomingCall,
        LPOLESTR szDoc );
extern "C" HRESULT E_ICreateTypeLib_SetHelpFileName(
        void* ptr, BOOL incomingCall,
        LPOLESTR szHelpFileName );
extern "C" HRESULT E_ICreateTypeLib_SetHelpContext(
        void* ptr, BOOL incomingCall,
        DWORD dwHelpContext );
extern "C" HRESULT E_ICreateTypeLib_SetLcid(
        void* ptr, BOOL incomingCall,
        LCID lcid );
extern "C" HRESULT E_ICreateTypeLib_SetLibFlags(
        void* ptr, BOOL incomingCall,
        UINT uLibFlags );
extern "C" HRESULT E_ICreateTypeLib_SaveAllChanges(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IDataAdviseHolder
//

extern "C" HRESULT E_IDataAdviseHolder_Advise(
        void* ptr, BOOL incomingCall,
        IDataObject __RPC_FAR *pDataObject,
        FORMATETC __RPC_FAR *pFetc,
        DWORD advf,
        IAdviseSink __RPC_FAR *pAdvise,
        DWORD __RPC_FAR *pdwConnection );
extern "C" HRESULT E_IDataAdviseHolder_Unadvise(
        void* ptr, BOOL incomingCall,
        DWORD dwConnection );
extern "C" HRESULT E_IDataAdviseHolder_EnumAdvise(
        void* ptr, BOOL incomingCall,
        IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumAdvise );
extern "C" HRESULT E_IDataAdviseHolder_SendOnDataChange(
        void* ptr, BOOL incomingCall,
        IDataObject __RPC_FAR *pDataObject,
        DWORD dwReserved,
        DWORD advf );

/////////////////////////////////////////////////////////////////////////////
//
// IDataObject
//

extern "C" HRESULT E_IDataObject_GetData(
        void* ptr, BOOL incomingCall,
        FORMATETC __RPC_FAR *pformatetcIn,
        STGMEDIUM __RPC_FAR *pmedium);
extern "C" HRESULT E_IDataObject_GetDataHere(
        void* ptr, BOOL incomingCall,
        FORMATETC __RPC_FAR *pformatetc,
        STGMEDIUM __RPC_FAR *pmedium );
extern "C" HRESULT E_IDataObject_QueryGetData(
        void* ptr, BOOL incomingCall,
        FORMATETC __RPC_FAR *pformatetc );
extern "C" HRESULT E_IDataObject_GetCanonicalFormatEtc(
        void* ptr, BOOL incomingCall,
        FORMATETC __RPC_FAR *pformatectIn,
        FORMATETC __RPC_FAR *pformatetcOut );
extern "C" HRESULT E_IDataObject_SetData(
        void* ptr, BOOL incomingCall,
        FORMATETC __RPC_FAR *pformatetc,
        STGMEDIUM __RPC_FAR *pmedium,
        BOOL fRelease );
extern "C" HRESULT E_IDataObject_EnumFormatEtc(
        void* ptr, BOOL incomingCall,
        DWORD dwDirection,
        IEnumFORMATETC __RPC_FAR *__RPC_FAR *ppenumFormatEtc );
extern "C" HRESULT E_IDataObject_DAdvise(
        void* ptr, BOOL incomingCall,
        FORMATETC __RPC_FAR *pformatetc,
        DWORD advf,
        IAdviseSink __RPC_FAR *pAdvSink,
        DWORD __RPC_FAR *pdwConnection );
extern "C" HRESULT E_IDataObject_DUnadvise(
        void* ptr, BOOL incomingCall,
        DWORD dwConnection );
extern "C" HRESULT E_IDataObject_EnumDAdvise(
        void* ptr, BOOL incomingCall,
        IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumAdvise );

/////////////////////////////////////////////////////////////////////////////
//
// IDispatch
//

extern "C" HRESULT E_IDispatch_GetTypeInfoCount(
        void* ptr, BOOL incomingCall,
        UINT __RPC_FAR *pctinfo );
extern "C" HRESULT E_IDispatch_GetTypeInfo(
        void* ptr, BOOL incomingCall,
        UINT itinfo, LCID lcid,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo );
extern "C" HRESULT E_IDispatch_GetIDsOfNames(
        void* ptr, BOOL incomingCall,
        REFIID riid, LPOLESTR __RPC_FAR *rgszNames,
        UINT cNames, LCID lcid, DISPID __RPC_FAR *rgdispid );
extern "C" HRESULT E_IDispatch_Invoke(
        void* ptr, BOOL incomingCall,
        DISPID dispidMember, REFIID riid,
        LCID lcid,
        WORD wFlags,
        DISPPARAMS __RPC_FAR *pdispparams,
        VARIANT __RPC_FAR *pvarResult,
        EXCEPINFO __RPC_FAR *pexcepinfo,
        UINT __RPC_FAR *puArgErr );

/////////////////////////////////////////////////////////////////////////////
//
// IDropTagret
//

extern "C" HRESULT E_IDropTarget_DragEnter(
        void* ptr, BOOL incomingCall,
        IDataObject __RPC_FAR *pDataObj,
        DWORD grfKeyState,
        POINTL pt,
        DWORD __RPC_FAR *pdwEffect );
extern "C" HRESULT E_IDropTarget_DragOver(
        void* ptr, BOOL incomingCall,
        DWORD grfKeyState, POINTL pt,
        DWORD __RPC_FAR *pdwEffect );
extern "C" HRESULT E_IDropTarget_DragLeave(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IDropTarget_Drop(
        void* ptr, BOOL incomingCall,
        IDataObject __RPC_FAR *pDataObj, DWORD grfKeyState,
        POINTL pt, DWORD __RPC_FAR *pdwEffect );

/////////////////////////////////////////////////////////////////////////////
//
// IDropSource
//

extern "C" HRESULT E_IDropSource_QueryContinueDrag(
        void* ptr, BOOL incomingCall,
        BOOL fEscapePressed,
        DWORD grfKeyState );
extern "C" HRESULT E_IDropSource_GiveFeedback(
        void* ptr, BOOL incomingCall,
        DWORD dwEffect );

/////////////////////////////////////////////////////////////////////////////
//
// IErrorInfo
//

extern "C" HRESULT E_IErrorInfo_GetGUID(
        void* ptr, BOOL incomingCall,
        GUID __RPC_FAR *pguid );
extern "C" HRESULT E_IDropSource_GetSource(
        void* ptr, BOOL incomingCall,
        BSTR __RPC_FAR *pbstrSource );
extern "C" HRESULT E_IDropSource_GetDescription(
        void* ptr, BOOL incomingCall,
        BSTR __RPC_FAR *pbstrDescription );
extern "C" HRESULT E_IDropSource_GetHelpFile(
        void* ptr, BOOL incomingCall,
        BSTR __RPC_FAR *pbstrHelpFile );
extern "C" HRESULT E_IDropSource_GetHelpContext(
        void* ptr, BOOL incomingCall,
        DWORD __RPC_FAR *pdwHelpContext );

/////////////////////////////////////////////////////////////////////////////
//
// IExternalConnection
//

extern "C" HRESULT E_IExternalConnection_AddConnection(
        void* ptr, BOOL incomingCall,
        DWORD extconn, DWORD reserved );
extern "C" HRESULT E_IExternalConnection_ReleaseConnection(
        void* ptr, BOOL incomingCall,
        DWORD extconn, DWORD reserved,
        BOOL fLastReleaseCloses );

/////////////////////////////////////////////////////////////////////////////
//
// ILockBytes
//

extern "C" HRESULT E_ILockBytes_ReadAt(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER ulOffset, void __RPC_FAR *pv,
        ULONG cb, ULONG __RPC_FAR *pcbRead );
extern "C" HRESULT E_ILockBytes_WriteAt(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER ulOffset, const void __RPC_FAR *pv,
        ULONG cb, ULONG __RPC_FAR *pcbWritten );
extern "C" HRESULT E_ILockBytes_Flush(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_ILockBytes_SetSize(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER cb );
extern "C" HRESULT E_ILockBytes_LockRegion(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER libOffset, ULARGE_INTEGER cb,
        DWORD dwLockType );
extern "C" HRESULT E_ILockBytes_UnlockRegion(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER libOffset, ULARGE_INTEGER cb,
        DWORD dwLockType);
extern "C" HRESULT E_ILockBytes_Stat(
        void* ptr, BOOL incomingCall,
        STATSTG __RPC_FAR *pstatstg, DWORD grfStatFlag );

/////////////////////////////////////////////////////////////////////////////
//
// IMalloc
//

extern "C" HRESULT E_IMalloc_Alloc(
        void* ptr, BOOL incomingCall,
        ULONG cb );
extern "C" HRESULT E_IMalloc_Realloc(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *pv, ULONG cb );
extern "C" HRESULT E_IMalloc_Free(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *pv );
extern "C" HRESULT E_IMalloc_GetSize(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *pv );
extern "C" HRESULT E_IMalloc_DidAlloc(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *pv );
extern "C" HRESULT E_IMalloc_HeapMinimize(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IMarshal
//

extern "C" HRESULT E_IMarshal_GetUnmarshalClass(
        void* ptr, BOOL incomingCall,
        REFIID riid, void __RPC_FAR *pv,
        DWORD dwDestContext, void __RPC_FAR *pvDestContext,
        DWORD mshlflags, CLSID __RPC_FAR *pCid );
extern "C" HRESULT E_IMarshal_GetMarshalSizeMax(
        void* ptr, BOOL incomingCall,
        REFIID riid, void __RPC_FAR *pv,
        DWORD dwDestContext, void __RPC_FAR *pvDestContext,
        DWORD mshlflags, DWORD __RPC_FAR *pSize );
extern "C" HRESULT E_IMarshal_MarshalInterface(
        void* ptr, BOOL incomingCall,
        IStream __RPC_FAR *pStm,
        REFIID riid, void __RPC_FAR *pv, DWORD dwDestContext,
        void __RPC_FAR *pvDestContext, DWORD mshlflags );
extern "C" HRESULT E_IMarshal_UnmarshalInterface(
        void* ptr, BOOL incomingCall,
        IStream __RPC_FAR *pStm,
        REFIID riid, void __RPC_FAR *__RPC_FAR *ppv );
extern "C" HRESULT E_IMarshal_ReleaseMarshalData(
        void* ptr, BOOL incomingCall,
        IStream __RPC_FAR *pStm );
extern "C" HRESULT E_IMarshal_DisconnectObject(
        void* ptr, BOOL incomingCall,
        DWORD dwReserved );

/////////////////////////////////////////////////////////////////////////////
//
// IMessageFilter
//

extern "C" HRESULT E_IMessageFilter_HandleInComingCall(
        void* ptr, BOOL incomingCall,
        DWORD dwCallType, HTASK htaskCaller,
        DWORD dwTickCount, LPINTERFACEINFO lpInterfaceInfo );
extern "C" HRESULT E_IMessageFilter_RetryRejectedCall(
        void* ptr, BOOL incomingCall,
        HTASK htaskCallee, DWORD dwTickCount,
        DWORD dwRejectType );
extern "C" HRESULT E_IMessageFilter_MessagePending(
        void* ptr, BOOL incomingCall,
        HTASK htaskCallee, DWORD dwTickCount,
        DWORD dwPendingType );

/////////////////////////////////////////////////////////////////////////////
//
// IOleAdviseHolder
//

extern "C" HRESULT E_IOleAdviseHolder_Advise(
        void* ptr, BOOL incomingCall,
        IAdviseSink __RPC_FAR *pAdvise,
        DWORD __RPC_FAR *pdwConnection );
extern "C" HRESULT E_IOleAdviseHolder_Unadvise(
        void* ptr, BOOL incomingCall,
        DWORD dwConnection );
extern "C" HRESULT E_IOleAdviseHolder_EnumAdvise(
        void* ptr, BOOL incomingCall,
        IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumAdvise );
extern "C" HRESULT E_IOleAdviseHolder_SendOnRename(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmk );
extern "C" HRESULT E_IOleAdviseHolder_SendOnSave(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleAdviseHolder_SendOnClose(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IOleCache
//

extern "C" HRESULT E_IOleCache_Cache(
        void* ptr, BOOL incomingCall,
        FORMATETC __RPC_FAR *pformatetc,
        DWORD advf, DWORD __RPC_FAR *pdwConnection );
extern "C" HRESULT E_IOleCache_Uncache(
        void* ptr, BOOL incomingCall,
        DWORD dwConnection );
extern "C" HRESULT E_IOleCache_EnumCache(
        void* ptr, BOOL incomingCall,
        IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumSTATDATA );
extern "C" HRESULT E_IOleCache_InitCache(
        void* ptr, BOOL incomingCall,
        IDataObject __RPC_FAR *pDataObject );
extern "C" HRESULT E_IOleCache_SetData(
        void* ptr, BOOL incomingCall,
        FORMATETC __RPC_FAR *pformatetc,
        STGMEDIUM __RPC_FAR *pmedium, BOOL fRelease );

/////////////////////////////////////////////////////////////////////////////
//
// IOleCache2
//

extern "C" HRESULT E_IOleCache2_UpdateCache(
        void* ptr, BOOL incomingCall,
        LPDATAOBJECT pDataObject, DWORD grfUpdf,
        LPVOID pReserved );
extern "C" HRESULT E_IOleCache2_DiscardCache(
        void* ptr, BOOL incomingCall,
        DWORD dwDiscardOptions );

/////////////////////////////////////////////////////////////////////////////
//
// IOleCacheControl
//

extern "C" HRESULT E_IOleCacheControl_OnRun(
        void* ptr, BOOL incomingCall,
        LPDATAOBJECT pDataObject );
extern "C" HRESULT E_IOleCacheControl_OnStop(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IOleClientSite
//

extern "C" HRESULT E_IOleClientSite_SaveObject(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleClientSite_GetMoniker(
        void* ptr, BOOL incomingCall,
        DWORD dwAssign, DWORD dwWhichMoniker,
        IMoniker __RPC_FAR *__RPC_FAR *ppmk );
extern "C" HRESULT E_IOleClientSite_GetContainer(
        void* ptr, BOOL incomingCall,
        IOleContainer __RPC_FAR *__RPC_FAR *ppContainer );
extern "C" HRESULT E_IOleClientSite_ShowObject(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleClientSite_OnShowWindow(
        void* ptr, BOOL incomingCall,
        BOOL fShow );
extern "C" HRESULT E_IOleClientSite_RequestNewObjectLayout(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IParseDisplayName
//

extern "C" HRESULT E_IParseDisplayName_ParseDisplayName(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc,
        LPOLESTR pszDisplayName, ULONG __RPC_FAR *pchEaten,
        IMoniker __RPC_FAR *__RPC_FAR *ppmkOut );

/////////////////////////////////////////////////////////////////////////////
//
// IOleControl
//

extern "C" HRESULT E_IOleControl_GetControlInfo(
        void* ptr, BOOL incomingCall,
        LPCONTROLINFO pCI );
extern "C" HRESULT E_IOleControl_OnMnemonic(
        void* ptr, BOOL incomingCall,
        LPMSG pMsg );
extern "C" HRESULT E_IOleControl_OnAmbientPropertyChange(
        void* ptr, BOOL incomingCall,
        DISPID dispid );
extern "C" HRESULT E_IOleControl_FreezeEvents(
        void* ptr, BOOL incomingCall,
        BOOL bFreeze );

/////////////////////////////////////////////////////////////////////////////
//
// IOleControlSite
//

extern "C" HRESULT E_IOleControlSite_OnControlInfoChanged(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleControlSite_LockInPlaceActivate(
        void* ptr, BOOL incomingCall,
        BOOL fLock );
extern "C" HRESULT E_IOleControlSite_GetExtendedControl(
        void* ptr, BOOL incomingCall,
        LPDISPATCH FAR* ppDisp );
extern "C" HRESULT E_IOleControlSite_TransformCoords(
        void* ptr, BOOL incomingCall,
        POINTL FAR* lpptlHimetric,
        POINTF FAR* lpptfContainer,
        DWORD flags );
extern "C" HRESULT E_IOleControlSite_TranslateAccelerator(
        void* ptr, BOOL incomingCall,
        LPMSG lpMsg, DWORD grfModifiers);
extern "C" HRESULT E_IOleControlSite_OnFocus(
        void* ptr, BOOL incomingCall,
        BOOL fGotFocus );
extern "C" HRESULT E_IOleControlSite_ShowPropertyFrame(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IOleWindow
//

extern "C" HRESULT E_IOleWindow_GetWindow(
        void* ptr, BOOL incomingCall,
        HWND __RPC_FAR *phwnd );
extern "C" HRESULT E_IOleWindow_ContextSensitiveHelp(
        void* ptr, BOOL incomingCall,
        BOOL fEnterMode );

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceUIWindow
//

extern "C" HRESULT E_IOleInPlaceUIWindow_GetBorder(
        void* ptr, BOOL incomingCall,
        LPRECT lprectBorder );
extern "C" HRESULT E_IOleInPlaceUIWindow_RequestBorderSpace(
        void* ptr, BOOL incomingCall,
        LPCBORDERWIDTHS pborderwidths );
extern "C" HRESULT E_IOleInPlaceUIWindow_SetBorderSpace(
        void* ptr, BOOL incomingCall,
        LPCBORDERWIDTHS pborderwidths );
extern "C" HRESULT E_IOleInPlaceUIWindow_SetActiveObject(
        void* ptr, BOOL incomingCall,
        IOleInPlaceActiveObject __RPC_FAR *pActiveObject,
        LPCOLESTR pszObjName );

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceActiveObject
//

extern "C" HRESULT E_IOleInPlaceActiveObject_TranslateAccelerator(
        void* ptr, BOOL incomingCall,
        LPMSG lpmsg );
extern "C" HRESULT E_IOleInPlaceActiveObject_OnFrameWindowActivate(
        void* ptr, BOOL incomingCall,
        BOOL fActivate );
extern "C" HRESULT E_IOleInPlaceActiveObject_OnDocWindowActivate(
        void* ptr, BOOL incomingCall,
        BOOL fActivate );
extern "C" HRESULT E_IOleInPlaceActiveObject_ResizeBorder(
        void* ptr, BOOL incomingCall,
        LPCRECT prcBorder,
        IOleInPlaceUIWindow __RPC_FAR *pUIWindow,
        BOOL fFrameWindow );
extern "C" HRESULT E_IOleInPlaceActiveObject_EnableModeless(
        void* ptr, BOOL incomingCall,
        BOOL fEnable );

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceFrame
//

extern "C" HRESULT E_IOleInPlaceFrame_InsertMenus(
        void* ptr, BOOL incomingCall,
        HMENU hmenuShared,
        LPOLEMENUGROUPWIDTHS lpMenuWidths );
extern "C" HRESULT E_IOleInPlaceFrame_SetMenu(
        void* ptr, BOOL incomingCall,
        HMENU hmenuShared, HOLEMENU holemenu,
        HWND hwndActiveObject );
extern "C" HRESULT E_IOleInPlaceFrame_RemoveMenus(
        void* ptr, BOOL incomingCall,
        HMENU hmenuShared );
extern "C" HRESULT E_IOleInPlaceFrame_SetStatusText(
        void* ptr, BOOL incomingCall,
        LPCOLESTR pszStatusText );
extern "C" HRESULT E_IOleInPlaceFrame_EnableModeless(
        void* ptr, BOOL incomingCall,
        BOOL fEnable );
extern "C" HRESULT E_IOleInPlaceFrame_TranslateAccelerator(
        void* ptr, BOOL incomingCall,
        LPMSG lpmsg, WORD wID );

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceObject
//

extern "C" HRESULT E_IOleInPlaceObject_InPlaceDeactivate(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleInPlaceObject_UIDeactivate(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleInPlaceObject_SetObjectRects(
        void* ptr, BOOL incomingCall,
        LPCRECT lprcPosRect, LPCRECT lprcClipRect );
extern "C" HRESULT E_IOleInPlaceObject_ReactivateAndUndo(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceSite
//

extern "C" HRESULT E_IOleInPlaceSite_CanInPlaceActivate(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleInPlaceSite_OnInPlaceActivate(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleInPlaceSite_OnUIActivate(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleInPlaceSite_GetWindowContext(
        void* ptr, BOOL incomingCall,
        IOleInPlaceFrame __RPC_FAR *__RPC_FAR *ppFrame,
        IOleInPlaceUIWindow __RPC_FAR *__RPC_FAR *ppDoc,
        LPRECT lprcPosRect,
        LPRECT lprcClipRect,
        LPOLEINPLACEFRAMEINFO lpFrameInfo );
extern "C" HRESULT E_IOleInPlaceSite_Scroll(
        void* ptr, BOOL incomingCall,
        SIZE scrollExtant );
extern "C" HRESULT E_IOleInPlaceSite_OnUIDeactivate(
        void* ptr, BOOL incomingCall,
        BOOL fUndoable );
extern "C" HRESULT E_IOleInPlaceSite_OnInPlaceDeactivate(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleInPlaceSite_DiscardUndoState(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleInPlaceSite_DeactivateAndUndo(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleInPlaceSite_OnPosRectChange(
        void* ptr, BOOL incomingCall,
        LPCRECT lprcPosRect );

/////////////////////////////////////////////////////////////////////////////
//
// IOleItemContainer
//

extern "C" HRESULT E_IOleItemContainer_GetObject(
        void* ptr, BOOL incomingCall,
        LPOLESTR pszItem, DWORD dwSpeedNeeded,
        IBindCtx __RPC_FAR *pbc, REFIID riid,
        void __RPC_FAR *__RPC_FAR *ppvObject );
extern "C" HRESULT E_IOleItemContainer_GetObjectStorage(
        void* ptr, BOOL incomingCall,
        LPOLESTR pszItem, IBindCtx __RPC_FAR *pbc,
        REFIID riid, void __RPC_FAR *__RPC_FAR *ppvStorage );
extern "C" HRESULT E_IOleItemContainer_IsRunning(
        void* ptr, BOOL incomingCall,
        LPOLESTR pszItem );

/////////////////////////////////////////////////////////////////////////////
//
// IOleLink
//

extern "C" HRESULT E_IOleLink_SetUpdateOptions(
        void* ptr, BOOL incomingCall,
        DWORD dwUpdateOpt );
extern "C" HRESULT E_IOleLink_GetUpdateOptions(
        void* ptr, BOOL incomingCall,
        DWORD __RPC_FAR *pdwUpdateOpt );
extern "C" HRESULT E_IOleLink_SetSourceMoniker(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmk,
        REFCLSID rclsid );
extern "C" HRESULT E_IOleLink_GetSourceMoniker(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *__RPC_FAR *ppmk );
extern "C" HRESULT E_IOleLink_SetSourceDisplayName(
        void* ptr, BOOL incomingCall,
        LPCOLESTR pszStatusText );
extern "C" HRESULT E_IOleLink_GetSourceDisplayName(
        void* ptr, BOOL incomingCall,
        LPOLESTR __RPC_FAR *ppszDisplayName );
extern "C" HRESULT E_IOleLink_BindToSource(
        void* ptr, BOOL incomingCall,
        DWORD bindflags,
        IBindCtx __RPC_FAR *pbc );
extern "C" HRESULT E_IOleLink_BindIfRunning(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleLink_GetBoundSource(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *__RPC_FAR *ppunk );
extern "C" HRESULT E_IOleLink_UnbindSource(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleLink_Update(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc );

/////////////////////////////////////////////////////////////////////////////
//
// IOleObject
//

extern "C" HRESULT E_IOleObject_SetClientSite(
        void* ptr, BOOL incomingCall,
        IOleClientSite __RPC_FAR *pClientSite );
extern "C" HRESULT E_IOleObject_GetClientSite(
        void* ptr, BOOL incomingCall,
        IOleClientSite __RPC_FAR *__RPC_FAR *ppClientSite );
extern "C" HRESULT E_IOleObject_SetHostNames(
        void* ptr, BOOL incomingCall,
        LPCOLESTR szContainerApp, LPCOLESTR szContainerObj );
extern "C" HRESULT E_IOleObject_Close(
        void* ptr, BOOL incomingCall,
        DWORD dwSaveOption );
extern "C" HRESULT E_IOleObject_SetMoniker(
        void* ptr, BOOL incomingCall,
        DWORD dwWhichMoniker, IMoniker __RPC_FAR *pmk );
extern "C" HRESULT E_IOleObject_GetMoniker(
        void* ptr, BOOL incomingCall,
        DWORD dwAssign, DWORD dwWhichMoniker,
        IMoniker __RPC_FAR *__RPC_FAR *ppmk );
extern "C" HRESULT E_IOleObject_InitFromData(
        void* ptr, BOOL incomingCall,
        IDataObject __RPC_FAR *pDataObject,
        BOOL fCreation, DWORD dwReserved );
extern "C" HRESULT E_IOleObject_GetClipboardData(
        void* ptr, BOOL incomingCall,
        DWORD dwReserved,
        IDataObject __RPC_FAR *__RPC_FAR *ppDataObject );
extern "C" HRESULT E_IOleObject_DoVerb(
        void* ptr, BOOL incomingCall,
        LONG iVerb, LPMSG lpmsg,
        IOleClientSite __RPC_FAR *pActiveSite,
        LONG lindex, HWND hwndParent,
        LPCRECT lprcPosRect );
extern "C" HRESULT E_IOleObject_EnumVerbs(
        void* ptr, BOOL incomingCall,
        IEnumOLEVERB __RPC_FAR *__RPC_FAR *ppEnumOleVerb );
extern "C" HRESULT E_IOleObject_Update(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleObject_IsUpToDate(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IOleObject_GetUserClassID(
        void* ptr, BOOL incomingCall,
        CLSID __RPC_FAR *pClsid );
extern "C" HRESULT E_IOleObject_GetUserType(
        void* ptr, BOOL incomingCall,
        DWORD dwFormOfType,
        LPOLESTR __RPC_FAR *pszUserType );
extern "C" HRESULT E_IOleObject_SetExtent(
        void* ptr, BOOL incomingCall,
        DWORD dwDrawAspect,
        SIZEL __RPC_FAR *psizel );
extern "C" HRESULT E_IOleObject_GetExtent(
        void* ptr, BOOL incomingCall,
        DWORD dwDrawAspect,
        SIZEL __RPC_FAR *psizel );
extern "C" HRESULT E_IOleObject_Advise(
        void* ptr, BOOL incomingCall,
        IAdviseSink __RPC_FAR *pAdvSink,
        DWORD __RPC_FAR *pdwConnection );
extern "C" HRESULT E_IOleObject_Unadvise(
        void* ptr, BOOL incomingCall,
        DWORD dwConnection );
extern "C" HRESULT E_IOleObject_EnumAdvise(
        void* ptr, BOOL incomingCall,
        IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumAdvise );
extern "C" HRESULT E_IOleObject_GetMiscStatus(
        void* ptr, BOOL incomingCall,
        DWORD dwAspect,
        DWORD __RPC_FAR *pdwStatus );
extern "C" HRESULT E_IOleObject_SetColorScheme(
        void* ptr, BOOL incomingCall,
        LOGPALETTE __RPC_FAR *pLogpal );

/////////////////////////////////////////////////////////////////////////////
//
// IOleUILinkContainer
//

extern "C" DWORD E_IOleUILinkContainer_GetNextLink(
        void* ptr, BOOL incomingCall,
        DWORD dwLink );
extern "C" HRESULT E_IOleUILinkContainer_SetLinkUpdateOptions(
        void* ptr, BOOL incomingCall,
        DWORD dwLink, DWORD dwUpdateOpt );
extern "C" HRESULT E_IOleUILinkContainer_GetLinkUpdateOptions(
        void* ptr, BOOL incomingCall,
        DWORD dwLink,
        DWORD FAR* lpdwUpdateOpt );
extern "C" HRESULT E_IOleUILinkContainer_SetLinkSource(
        void* ptr, BOOL incomingCall,
        DWORD dwLink,
        LPTSTR lpszDisplayName,
        ULONG lenFileName,
        ULONG FAR* pchEaten,
        BOOL fValidateSource );
extern "C" HRESULT E_IOleUILinkContainer_GetLinkSource(
        void* ptr, BOOL incomingCall,
        DWORD dwLink,
        LPTSTR FAR* lplpszDisplayName,
	    ULONG FAR* lplenFileName,
	    LPTSTR FAR* lplpszFullLinkType,
	    LPTSTR FAR* lplpszShortLinkType,
	    BOOL FAR* lpfSourceAvailable,
	    BOOL FAR* lpfIsSelected );
extern "C" HRESULT E_IOleUILinkContainer_OpenLinkSource(
        void* ptr, BOOL incomingCall,
        DWORD dwLink );
extern "C" HRESULT E_IOleUILinkContainer_UpdateLink(
        void* ptr, BOOL incomingCall,
        DWORD dwLink,
        BOOL fErrorMessage,
        BOOL fErrorAction );
extern "C" HRESULT E_IOleUILinkContainer_CancelLink(
        void* ptr, BOOL incomingCall,
        DWORD dwLink );

/////////////////////////////////////////////////////////////////////////////
//
// IPerPropertyBrowsing
//

extern "C" HRESULT E_IPerPropertyBrowsing_GetDisplayString(
        void* ptr, BOOL incomingCall,
        DISPID dispid, BSTR FAR* lpbstr );
extern "C" HRESULT E_IPerPropertyBrowsing_MapPropertyToPage(
        void* ptr, BOOL incomingCall,
        DISPID dispid, LPCLSID lpclsid );
extern "C" HRESULT E_IPerPropertyBrowsing_GetPredefinedStrings(
        void* ptr, BOOL incomingCall,
        DISPID dispid,
        CALPOLESTR FAR* lpcaStringsOut,
        CADWORD FAR* lpcaCookiesOut );
extern "C" HRESULT E_IPerPropertyBrowsing_GetPredefinedValue(
        void* ptr, BOOL incomingCall,
        DISPID dispid, DWORD dwCookie,
        VARIANT FAR* lpvarOut );

/////////////////////////////////////////////////////////////////////////////
//
// IPersist
//

extern "C" HRESULT E_IPersist_GetClassID(
        void* ptr, BOOL incomingCall,
        CLSID __RPC_FAR *pClassID );

/////////////////////////////////////////////////////////////////////////////
//
// IPersistFile
//

extern "C" HRESULT E_IPersistFile_IsDirty(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IPersistFile_Load(
        void* ptr, BOOL incomingCall,
        LPCOLESTR pszFileName,
        DWORD dwMode );
extern "C" HRESULT E_IPersistFile_Save(
        void* ptr, BOOL incomingCall,
        LPCOLESTR pszFileName,
        BOOL fRemember );
extern "C" HRESULT E_IPersistFile_SaveCompleted(
        void* ptr, BOOL incomingCall,
        LPCOLESTR pszFileName );
extern "C" HRESULT E_IPersistFile_GetCurFile(
        void* ptr, BOOL incomingCall,
        LPOLESTR __RPC_FAR *ppszFileName );

/////////////////////////////////////////////////////////////////////////////
//
// IPersistStorage
//

extern "C" HRESULT E_IPersistStorage_IsDirty(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IPersistStorage_InitNew(
        void* ptr, BOOL incomingCall,
        IStorage __RPC_FAR *pStg );
extern "C" HRESULT E_IPersistStorage_Load(
        void* ptr, BOOL incomingCall,
        IStorage __RPC_FAR *pStg );
extern "C" HRESULT E_IPersistStorage_Save(
        void* ptr, BOOL incomingCall,
        IStorage __RPC_FAR *pStgSave, BOOL fSameAsLoad );
extern "C" HRESULT E_IPersistStorage_SaveCompleted(
        void* ptr, BOOL incomingCall,
        IStorage __RPC_FAR *pStgNew );
extern "C" HRESULT E_IPersistStorage_HandsOffStorage(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IPersistStream
//

extern "C" HRESULT E_IPersistStream_IsDirty(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IPersistStream_Load(
        void* ptr, BOOL incomingCall,
        IStream __RPC_FAR *pStm );
extern "C" HRESULT E_IPersistStream_Save(
        void* ptr, BOOL incomingCall,
        IStream __RPC_FAR *pStm, BOOL fClearDirty );
extern "C" HRESULT E_IPersistStream_GetSizeMax(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER __RPC_FAR *pcbSize );

/////////////////////////////////////////////////////////////////////////////
//
// IPersistStreamInit
//

extern "C" HRESULT E_IPersistStreamInit_InitNew(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IMoniker
//

extern "C" HRESULT E_IMoniker_BindToObject(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc,
        IMoniker __RPC_FAR *pmkToLeft,
        REFIID riidResult,
        void __RPC_FAR *__RPC_FAR *ppvResult );
extern "C" HRESULT E_IMoniker_BindToStorage(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc,
        IMoniker __RPC_FAR *pmkToLeft, REFIID riid,
        void __RPC_FAR *__RPC_FAR *ppvObj );
extern "C" HRESULT E_IMoniker_Reduce(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc, DWORD dwReduceHowFar,
        IMoniker __RPC_FAR *__RPC_FAR *ppmkToLeft,
        IMoniker __RPC_FAR *__RPC_FAR *ppmkReduced );
extern "C" HRESULT E_IMoniker_ComposeWith(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmkRight,
        BOOL fOnlyIfNotGeneric,
        IMoniker __RPC_FAR *__RPC_FAR *ppmkComposite );
extern "C" HRESULT E_IMoniker_Enum(
        void* ptr, BOOL incomingCall,
        BOOL fForward,
        IEnumMoniker __RPC_FAR *__RPC_FAR *ppenumMoniker );
extern "C" HRESULT E_IMoniker_IsEqual(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmkOtherMoniker );
extern "C" HRESULT E_IMoniker_Hash(
        void* ptr, BOOL incomingCall,
        DWORD __RPC_FAR *pdwHash );
extern "C" HRESULT E_IMoniker_IsRunning(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc,
        IMoniker __RPC_FAR *pmkToLeft,
        IMoniker __RPC_FAR *pmkNewlyRunning );
extern "C" HRESULT E_IMoniker_GetTimeOfLastChange(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc,
        IMoniker __RPC_FAR *pmkToLeft,
        FILETIME __RPC_FAR *pFileTime );
extern "C" HRESULT E_IMoniker_Inverse(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *__RPC_FAR *ppmk );
extern "C" HRESULT E_IMoniker_CommonPrefixWith(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmkOther,
        IMoniker __RPC_FAR *__RPC_FAR *ppmkPrefix );
extern "C" HRESULT E_IMoniker_RelativePathTo(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmkOther,
        IMoniker __RPC_FAR *__RPC_FAR *ppmkRelPath );
extern "C" HRESULT E_IMoniker_GetDisplayName(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc,
        IMoniker __RPC_FAR *pmkToLeft,
        LPOLESTR __RPC_FAR *ppszDisplayName );
extern "C" HRESULT E_IMoniker_ParseDisplayName(
        void* ptr, BOOL incomingCall,
        IBindCtx __RPC_FAR *pbc,
        IMoniker __RPC_FAR *pmkToLeft,
        LPOLESTR pszDisplayName,
        ULONG __RPC_FAR *pchEaten,
        IMoniker __RPC_FAR *__RPC_FAR *ppmkOut );
extern "C" HRESULT E_IMoniker_IsSystemMoniker(
        void* ptr, BOOL incomingCall,
        DWORD __RPC_FAR *pdwMksys );

/////////////////////////////////////////////////////////////////////////////
//
// IPropertyNotifySink
//

extern "C" HRESULT E_IPropertyNotifySink_OnChanged(
        void* ptr, BOOL incomingCall,
        DISPID dispid );
extern "C" HRESULT E_IPropertyNotifySink_OnRequestEdit(
        void* ptr, BOOL incomingCall,
        DISPID dispid );

/////////////////////////////////////////////////////////////////////////////
//
// IPropertyPage
//

extern "C" HRESULT E_IPropertyPage_SetPageSite(
        void* ptr, BOOL incomingCall,
        LPPROPERTYPAGESITE pPageSite );
extern "C" HRESULT E_IPropertyPage_Activate(
        void* ptr, BOOL incomingCall,
        HWND hwndParent,
        LPCRECT lprc,
        BOOL bModal );
extern "C" HRESULT E_IPropertyPage_Deactivate(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IPropertyPage_GetPageInfo(
        void* ptr, BOOL incomingCall,
        LPPROPPAGEINFO pPageInfo );
extern "C" HRESULT E_IPropertyPage_SetObjects(
        void* ptr, BOOL incomingCall,
        ULONG cObjects, LPUNKNOWN FAR* ppunk );
extern "C" HRESULT E_IPropertyPage_Show(
        void* ptr, BOOL incomingCall,
        UINT nCmdShow);
extern "C" HRESULT E_IPropertyPage_Move(
        void* ptr, BOOL incomingCall,
        LPCRECT prect );
extern "C" HRESULT E_IPropertyPage_IsPageDirty(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IPropertyPage_Apply(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IPropertyPage_Help(
        void* ptr, BOOL incomingCall,
        LPCOLESTR lpszHelpDir );
extern "C" HRESULT E_IPropertyPage_TranslateAccelerator(
        void* ptr, BOOL incomingCall,
        LPMSG lpMsg );

/////////////////////////////////////////////////////////////////////////////
//
// IPropertyPage2
//

extern "C" HRESULT E_IPropertyPage2_EditProperty(
        void* ptr, BOOL incomingCall,
        DISPID dispid );

/////////////////////////////////////////////////////////////////////////////
//
// IPropertyPageSite
//

extern "C" HRESULT E_IPropertyPageSite_OnStatusChange(
        void* ptr, BOOL incomingCall,
        DWORD flags );
extern "C" HRESULT E_IPropertyPageSite_GetLocaleID(
        void* ptr, BOOL incomingCall,
        LCID FAR* pLocaleID );
extern "C" HRESULT E_IPropertyPageSite_GetPageContainer(
        void* ptr, BOOL incomingCall,
        LPUNKNOWN FAR* ppUnk );
extern "C" HRESULT E_IPropertyPageSite_TranslateAccelerator(
        void* ptr, BOOL incomingCall,
        LPMSG lpMsg );

/////////////////////////////////////////////////////////////////////////////
//
// IProvideClassInfo
//

extern "C" HRESULT E_IProvideClassInfo_GetClassInfo(
        void* ptr, BOOL incomingCall,
        LPTYPEINFO FAR* ppTI );

/////////////////////////////////////////////////////////////////////////////
//
// IPSFactoryBuffer
//

extern "C" HRESULT E_IPSFactoryBuffer_CreateProxy(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *pUnkOuter,
        REFIID riid,
        IRpcProxyBuffer __RPC_FAR *__RPC_FAR *ppProxy,
        void __RPC_FAR *__RPC_FAR *ppv );

extern "C" HRESULT E_IPSFactoryBuffer_CreateStub(
        void* ptr, BOOL incomingCall,
        REFIID riid,
        IUnknown __RPC_FAR *pUnkServer,
        IRpcStubBuffer __RPC_FAR *__RPC_FAR *ppStub );

/////////////////////////////////////////////////////////////////////////////
//
// IRootStorage
//

extern "C" HRESULT E_IRootStorage_SwitchToFile(
        void* ptr, BOOL incomingCall,
        LPOLESTR pszFile );

/////////////////////////////////////////////////////////////////////////////
//
// IROTData
//

extern "C" HRESULT E_IROTData_GetComparisonData(
        void* ptr, BOOL incomingCall,
        byte __RPC_FAR *pbData,
        ULONG cbMax,
        ULONG __RPC_FAR *pcbData );

/////////////////////////////////////////////////////////////////////////////
//
// IRpcChannelBuffer
//

extern "C" HRESULT E_IRpcChannelBuffer_GetBuffer(
        void* ptr, BOOL incomingCall,
        RPCOLEMESSAGE __RPC_FAR *pMessage,
        REFIID riid );
extern "C" HRESULT E_IRpcChannelBuffer_SendReceive(
        void* ptr, BOOL incomingCall,
        RPCOLEMESSAGE __RPC_FAR *pMessage,
        ULONG __RPC_FAR *pStatus );
extern "C" HRESULT E_IRpcChannelBuffer_FreeBuffer(
        void* ptr, BOOL incomingCall,
        RPCOLEMESSAGE __RPC_FAR *pMessage );
extern "C" HRESULT E_IRpcChannelBuffer_GetDestCtx(
        void* ptr, BOOL incomingCall,
        DWORD __RPC_FAR *pdwDestContext,
        void __RPC_FAR *__RPC_FAR *ppvDestContext );
extern "C" HRESULT E_IRpcChannelBuffer_IsConnected(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IRpcProxyBuffer
//

extern "C" HRESULT E_IRpcProxyBuffer_Connect(
        void* ptr, BOOL incomingCall,
        IRpcChannelBuffer __RPC_FAR *pRpcChannelBuffer );
extern "C" HRESULT E_IRpcProxyBuffer_Disconnect(
        void* ptr, BOOL incomingCall );

/////////////////////////////////////////////////////////////////////////////
//
// IRpcStubBuffer
//

extern "C" HRESULT E_IRpcStubBuffer_Connect(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *pUnkServer );
extern "C" HRESULT E_IRpcStubBuffer_Disconnect(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IRpcStubBuffer_Invoke(
        void* ptr, BOOL incomingCall,
        RPCOLEMESSAGE __RPC_FAR *_prpcmsg,
        IRpcChannelBuffer __RPC_FAR *_pRpcChannelBuffer );
extern "C" IRpcStubBuffer __RPC_FAR * E_IRpcStubBuffer_IsIIDSupported(
        void* ptr, BOOL incomingCall,
        REFIID riid );
extern "C" ULONG E_IRpcStubBuffer_CountRefs(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IRpcStubBuffer_DebugServerQueryInterface(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *__RPC_FAR *ppv );
extern "C" HRESULT E_IRpcStubBuffer_DebugServerRelease(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *pv );

/////////////////////////////////////////////////////////////////////////////
//
// IRunnableObject
//

extern "C" HRESULT E_IRunnableObject_GetRunningClass(
        void* ptr, BOOL incomingCall,
        LPCLSID lpClsid );
extern "C" HRESULT E_IRunnableObject_Run(
        void* ptr, BOOL incomingCall,
        LPBINDCTX pbc );
extern "C" HRESULT E_IRunnableObject_IsRunning(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IRunnableObject_LockRunning(
        void* ptr, BOOL incomingCall,
        BOOL fLock, BOOL fLastUnlockCloses );
extern "C" HRESULT E_IRunnableObject_SetContainedObject(
        void* ptr, BOOL incomingCall,
        BOOL fContained );

/////////////////////////////////////////////////////////////////////////////
//
// IRunningObjectTable
//

extern "C" HRESULT E_IRunningObjectTable_Register(
        void* ptr, BOOL incomingCall,
        DWORD grfFlags,
        IUnknown __RPC_FAR *punkObject,
        IMoniker __RPC_FAR *pmkObjectName,
        DWORD __RPC_FAR *pdwRegister );
extern "C" HRESULT E_IRunningObjectTable_Revoke(
        void* ptr, BOOL incomingCall,
        WORD dwRegister );
extern "C" HRESULT E_IRunningObjectTable_IsRunning(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmkObjectName );
extern "C" HRESULT E_IRunningObjectTable_GetObject(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmkObjectName,
        IUnknown __RPC_FAR *__RPC_FAR *ppunkObject );
extern "C" HRESULT E_IRunningObjectTable_NoteChangeTime(
        void* ptr, BOOL incomingCall,
        DWORD dwRegister,
        FILETIME __RPC_FAR *pfiletime );
extern "C" HRESULT E_IRunningObjectTable_GetTimeOfLastChange(
        void* ptr, BOOL incomingCall,
        IMoniker __RPC_FAR *pmkObjectName,
        FILETIME __RPC_FAR *pfiletime );
extern "C" HRESULT E_IRunningObjectTable_EnumRunning(
        void* ptr, BOOL incomingCall,
        IEnumMoniker __RPC_FAR *__RPC_FAR *ppenumMoniker );

/////////////////////////////////////////////////////////////////////////////
//
// ISimpleFrameSite
//

extern "C" HRESULT E_ISimpleFrameSite_PreMessageFilter(
        void* ptr, BOOL incomingCall,
        HWND hwnd, UINT msg, WPARAM wp, LPARAM lp,
        LRESULT FAR* lplResult,
        DWORD FAR * lpdwCookie );
extern "C" HRESULT E_ISimpleFrameSite_PostMessageFilter(
        void* ptr, BOOL incomingCall,
        HWND hwnd, UINT msg, WPARAM wp, LPARAM lp,
        LRESULT FAR* lplResult, DWORD dwCookie );

/////////////////////////////////////////////////////////////////////////////
//
// ISpecifyPropertyPages
//

extern "C" HRESULT E_ISpecifyPropertyPages_GetPages(
        void* ptr, BOOL incomingCall,
        CAUUID FAR* pPages );

/////////////////////////////////////////////////////////////////////////////
//
// IStdMarshalInfo
//

extern "C" HRESULT E_IStdMarshalInfo_GetClassForHandler(
        void* ptr, BOOL incomingCall,
        DWORD dwDestContext, void __RPC_FAR *pvDestContext,
        CLSID __RPC_FAR *pClsid );

/////////////////////////////////////////////////////////////////////////////
//
// IStorage
//

extern "C" HRESULT E_IStorage_CreateStream(
        void* ptr, BOOL incomingCall,
        const OLECHAR __RPC_FAR *pwcsName,
        DWORD grfMode, DWORD reserved1, DWORD reserved2,
        IStream __RPC_FAR *__RPC_FAR *ppstm );
extern "C" HRESULT E_IStorage_OpenStream(
        void* ptr, BOOL incomingCall,
        const OLECHAR __RPC_FAR *pwcsName,
        void __RPC_FAR *reserved1, DWORD grfMode, DWORD reserved2,
        IStream __RPC_FAR *__RPC_FAR *ppstm );
extern "C" HRESULT E_IStorage_CreateStorage(
        void* ptr, BOOL incomingCall,
        const OLECHAR __RPC_FAR *pwcsName,
        DWORD grfMode, DWORD dwStgFmt, DWORD reserved2,
        IStorage __RPC_FAR *__RPC_FAR *ppstg );
extern "C" HRESULT E_IStorage_OpenStorage(
        void* ptr, BOOL incomingCall,
        const OLECHAR __RPC_FAR *pwcsName,
        IStorage __RPC_FAR *pstgPriority, DWORD grfMode,
        SNB snbExclude, DWORD reserved,
        IStorage __RPC_FAR *__RPC_FAR *ppstg );
extern "C" HRESULT E_IStorage_CopyTo(
        void* ptr, BOOL incomingCall,
        DWORD ciidExclude,
        const IID __RPC_FAR *rgiidExclude,
        SNB snbExclude, IStorage __RPC_FAR *pstgDest );
extern "C" HRESULT E_IStorage_MoveElementTo(
        void* ptr, BOOL incomingCall,
        const OLECHAR __RPC_FAR *pwcsName,
        IStorage __RPC_FAR *pstgDest,
        const OLECHAR __RPC_FAR *pwcsNewName,
        DWORD grfFlags );
extern "C" HRESULT E_IStorage_Commit(
        void* ptr, BOOL incomingCall,
        DWORD grfCommitFlags );
extern "C" HRESULT E_IStorage_Revert(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IStorage_EnumElements(
        void* ptr, BOOL incomingCall,
        DWORD reserved1, void __RPC_FAR *reserved2,
        DWORD reserved3, IEnumSTATSTG __RPC_FAR *__RPC_FAR *ppenum );
extern "C" HRESULT E_IStorage_DestroyElement(
        void* ptr, BOOL incomingCall,
        const OLECHAR __RPC_FAR *pwcsName );
extern "C" HRESULT E_IStorage_RenameElement(
        void* ptr, BOOL incomingCall,
        const OLECHAR __RPC_FAR *pwcsOldName,
        const OLECHAR __RPC_FAR *pwcsNewName );
extern "C" HRESULT E_IStorage_SetElementTimes(
        void* ptr, BOOL incomingCall,
        const OLECHAR __RPC_FAR *pwcsName,
        const FILETIME __RPC_FAR *pctime,
        const FILETIME __RPC_FAR *patime,
        const FILETIME __RPC_FAR *pmtime );
extern "C" HRESULT E_IStorage_SetClass(
        void* ptr, BOOL incomingCall,
        REFCLSID clsid );
extern "C" HRESULT E_IStorage_SetStateBits(
        void* ptr, BOOL incomingCall,
        DWORD grfStateBits, DWORD grfMask );
extern "C" HRESULT E_IStorage_Stat(
        void* ptr, BOOL incomingCall,
        STATSTG __RPC_FAR *pstatstg, DWORD grfStatFlag );

/////////////////////////////////////////////////////////////////////////////
//
// IStream
//

extern "C" HRESULT E_IStream_Read(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *pv, ULONG cb, ULONG __RPC_FAR *pcbRead );
extern "C" HRESULT E_IStream_Write(
        void* ptr, BOOL incomingCall,
        const void __RPC_FAR *pv, ULONG cb,
        ULONG __RPC_FAR *pcbWritten );
extern "C" HRESULT E_IStream_Seek(
        void* ptr, BOOL incomingCall,
        LARGE_INTEGER dlibMove, DWORD dwOrigin,
        ULARGE_INTEGER __RPC_FAR *plibNewPosition );
extern "C" HRESULT E_IStream_SetSize(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER libNewSize );
extern "C" HRESULT E_IStream_CopyTo(
        void* ptr, BOOL incomingCall,
        IStream __RPC_FAR *pstm, ULARGE_INTEGER cb,
        ULARGE_INTEGER __RPC_FAR *pcbRead,
        ULARGE_INTEGER __RPC_FAR *pcbWritten );
extern "C" HRESULT E_IStream_Commit(
        void* ptr, BOOL incomingCall,
        DWORD grfCommitFlags );
extern "C" HRESULT E_IStream_Revert(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IStream_LockRegion(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER libOffset, ULARGE_INTEGER cb,
        DWORD dwLockType );
extern "C" HRESULT E_IStream_UnlockRegion(
        void* ptr, BOOL incomingCall,
        ULARGE_INTEGER libOffset, ULARGE_INTEGER cb,
        DWORD dwLockType );
extern "C" HRESULT E_IStream_Stat(
        void* ptr, BOOL incomingCall,
        STATSTG __RPC_FAR *pstatstg, DWORD grfStatFlag );
extern "C" HRESULT E_IStream_Clone(
        void* ptr, BOOL incomingCall,
        IStream __RPC_FAR *__RPC_FAR *ppstm );

/////////////////////////////////////////////////////////////////////////////
//
// ISupportErrorInfo
//

extern "C" HRESULT E_ISupportErrorInfo_InterfaceSupportsErrorInfo(
        void* ptr, BOOL incomingCall,
        REFIID riid );

/////////////////////////////////////////////////////////////////////////////
//
// ITypeComp
//

extern "C" HRESULT E_ITypeComp_Bind(
        void* ptr, BOOL incomingCall,
        LPOLESTR szName, ULONG lHashVal, WORD fFlags,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo,
        DESCKIND __RPC_FAR *pdesckind,
        BINDPTR __RPC_FAR *pbindptr );
extern "C" HRESULT E_ITypeComp_BindType(
        void* ptr, BOOL incomingCall,
        LPOLESTR szName, ULONG lHashVal,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo,
        ITypeComp __RPC_FAR *__RPC_FAR *pptcomp );

/////////////////////////////////////////////////////////////////////////////
//
// ITypeInfo
//

extern "C" HRESULT E_ITypeInfo_GetTypeAttr(
        void* ptr, BOOL incomingCall,
        TYPEATTR __RPC_FAR *__RPC_FAR *pptypeattr );
extern "C" HRESULT E_ITypeInfo_GetTypeComp(
        void* ptr, BOOL incomingCall,
        ITypeComp __RPC_FAR *__RPC_FAR *pptcomp );
extern "C" HRESULT E_ITypeInfo_GetFuncDesc(
        void* ptr, BOOL incomingCall,
        UINT index, FUNCDESC __RPC_FAR *__RPC_FAR *pppfuncdesc );
extern "C" HRESULT E_ITypeInfo_GetVarDesc(
        void* ptr, BOOL incomingCall,
        UINT index,
        VARDESC __RPC_FAR *__RPC_FAR *ppvardesc );
extern "C" HRESULT E_ITypeInfo_GetNames(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, BSTR __RPC_FAR *rgbstrNames,
        UINT cMaxNames, UINT __RPC_FAR *pcNames );
extern "C" HRESULT E_ITypeInfo_GetRefTypeOfImplType(
        void* ptr, BOOL incomingCall,
        UINT index, HREFTYPE __RPC_FAR *hpreftype );
extern "C" HRESULT E_ITypeInfo_GetImplTypeFlags(
        void* ptr, BOOL incomingCall,
        UINT index, INT __RPC_FAR *pimpltypeflags );
extern "C" HRESULT E_ITypeInfo_GetIDsOfNames(
        void* ptr, BOOL incomingCall,
        OLECHAR __RPC_FAR *__RPC_FAR *rglpszNames,
        UINT cNames, MEMBERID __RPC_FAR *rgmemid );
extern "C" HRESULT E_ITypeInfo_Invoke(
        void* ptr, BOOL incomingCall,
        void __RPC_FAR *pvInstance, MEMBERID memid,
        WORD wFlags, DISPPARAMS __RPC_FAR *pdispparams,
        VARIANT __RPC_FAR *pvarResult, EXCEPINFO __RPC_FAR *pexcepinfo,
        UINT __RPC_FAR *puArgErr );
extern "C" HRESULT E_ITypeInfo_GetDocumentation(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, BSTR __RPC_FAR *pbstrName,
        BSTR __RPC_FAR *pbstrDocString, DWORD __RPC_FAR *pdwHelpContext,
        BSTR __RPC_FAR *pbstrHelpFile );
extern "C" HRESULT E_ITypeInfo_GetDllEntry(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, INVOKEKIND invkind,
        BSTR __RPC_FAR *pbstrDllName, BSTR __RPC_FAR *pbstrName,
        WORD __RPC_FAR *pwOrdinal );
extern "C" HRESULT E_ITypeInfo_GetRefTypeInfo(
        void* ptr, BOOL incomingCall,
        HREFTYPE hreftype,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo );
extern "C" HRESULT E_ITypeInfo_AddressOfMember(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, INVOKEKIND invkind,
        void __RPC_FAR *__RPC_FAR *ppv );
extern "C" HRESULT E_ITypeInfo_CreateInstance(
        void* ptr, BOOL incomingCall,
        IUnknown __RPC_FAR *puncOuter,
        REFIID riid, void __RPC_FAR *__RPC_FAR *ppvObj );
extern "C" HRESULT E_ITypeInfo_GetMops(
        void* ptr, BOOL incomingCall,
        MEMBERID memid, BSTR __RPC_FAR *pbstrMops );
extern "C" HRESULT E_ITypeInfo_GetContainingTypeLib(
        void* ptr, BOOL incomingCall,
        ITypeLib __RPC_FAR *__RPC_FAR *pptlib,
        UINT __RPC_FAR *pindex );
extern "C" HRESULT E_ITypeInfo_ReleaseTypeAttr(
        void* ptr, BOOL incomingCall,
        TYPEATTR __RPC_FAR *ptypeattr );
extern "C" HRESULT E_ITypeInfo_ReleaseFuncDesc(
        void* ptr, BOOL incomingCall,
        FUNCDESC __RPC_FAR *pfuncdesc );
extern "C" HRESULT E_ITypeInfo_ReleaseVarDesc(
        void* ptr, BOOL incomingCall,
        VARDESC __RPC_FAR *pvardesc );

/////////////////////////////////////////////////////////////////////////////
//
// ITypeLib
//

extern "C" HRESULT E_ITypeLib_GetTypeInfoCount(
        void* ptr );
extern "C" HRESULT E_ITypeLib_GetTypeInfo(
        void* ptr,
        UINT index,
        ITypeInfo __RPC_FAR *__RPC_FAR *ppitinfo );
extern "C" HRESULT E_ITypeLib_GetTypeInfoType(
        void* ptr,
        UINT index, TYPEKIND __RPC_FAR *ptkind );
extern "C" HRESULT E_ITypeLib_GetTypeInfoOfGuid(
        void* ptr,
        REFGUID guid,
        ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo );
extern "C" HRESULT E_ITypeLib_GetLibAttr(
        void* ptr,
        TLIBATTR __RPC_FAR *__RPC_FAR *pptlibattr );
extern "C" HRESULT E_ITypeLib_GetTypeComp(
        void* ptr,
        ITypeComp __RPC_FAR *__RPC_FAR *pptcomp );
extern "C" HRESULT E_ITypeLib_GetDocumentation(
        void* ptr,
        INT index, BSTR __RPC_FAR *pbstrName,
        BSTR __RPC_FAR *pbstrDocString,
        DWORD __RPC_FAR *pdwHelpContext,
        BSTR __RPC_FAR *pbstrHelpFile );
 extern "C" HRESULT E_ITypeLib_IsName(
        void* ptr,
        LPOLESTR szNameBuf, ULONG lHashVal,
        BOOL __RPC_FAR *pfName );
extern "C" HRESULT E_ITypeLib_FindName(
        void* ptr,
        LPOLESTR szNameBuf,
        ITypeInfo __RPC_FAR *__RPC_FAR *rgptinfo,
        MEMBERID __RPC_FAR *rgmemid,
        USHORT __RPC_FAR *pcFound );
extern "C" void E_ITypeLib_ReleaseTLibAttr(
        void* ptr,
        TLIBATTR __RPC_FAR *ptlibattr );

/////////////////////////////////////////////////////////////////////////////
//
// IViewObject
//

extern "C" HRESULT E_IViewObject_Draw(
        void* ptr, BOOL incomingCall,
        DWORD dwDrawAspect,
        LONG lindex,
        void __RPC_FAR *pvAspect,
        DVTARGETDEVICE __RPC_FAR *ptd,
        HDC hdcTargetDev,
        HDC hdcDraw,
        LPCRECTL lprcBounds,
        LPCRECTL lprcWBounds,
        BOOL ( __stdcall __stdcall __RPC_FAR *pfnContinue )( DWORD dwContinue),
        DWORD dwContinue );
extern "C" HRESULT E_IViewObject_GetColorSet(
        void* ptr, BOOL incomingCall,
        DWORD dwDrawAspect, LONG lindex,
        void __RPC_FAR *pvAspect, DVTARGETDEVICE __RPC_FAR *ptd,
        HDC hicTargetDev,
        LOGPALETTE __RPC_FAR *__RPC_FAR *ppColorSet );
extern "C" HRESULT E_IViewObject_Freeze(
        void* ptr, BOOL incomingCall,
        DWORD dwDrawAspect, LONG lindex,
        void __RPC_FAR *pvAspect,
        DWORD __RPC_FAR *pdwFreeze );
extern "C" HRESULT E_IViewObject_Unfreeze(
        void* ptr, BOOL incomingCall,
        DWORD dwFreeze );
extern "C" HRESULT E_IViewObject_SetAdvise(
        void* ptr, BOOL incomingCall,
        DWORD aspects, DWORD advf,
        IAdviseSink __RPC_FAR *pAdvSink );
extern "C" HRESULT E_IViewObject_GetAdvise(
        void* ptr, BOOL incomingCall,
        DWORD __RPC_FAR *pAspects,
        DWORD __RPC_FAR *pAdvf,
        IAdviseSink __RPC_FAR *__RPC_FAR *ppAdvSink );

/////////////////////////////////////////////////////////////////////////////
//
// IViewObject2
//

extern "C" HRESULT E_IViewObject2_GetExtent(
        void* ptr, BOOL incomingCall,
        DWORD dwDrawAspect, LONG lindex,
        DVTARGETDEVICE __RPC_FAR *ptd, LPSIZEL lpsizel );

/////////////////////////////////////////////////////////////////////////////
//
// IFont
//

extern "C" HRESULT E_IFont_get_Name(
        void* ptr, BOOL incomingCall,
        BSTR FAR* pname );
extern "C" HRESULT E_IFont_put_Name(
        void* ptr, BOOL incomingCall,
        BSTR name );
extern "C" HRESULT E_IFont_get_Size(
        void* ptr, BOOL incomingCall,
        CY FAR* psize );
extern "C" HRESULT E_IFont_put_Size(
        void* ptr, BOOL incomingCall,
        CY size );
extern "C" HRESULT E_IFont_get_Bold(
        void* ptr, BOOL incomingCall,
        BOOL FAR* pbold );
extern "C" HRESULT E_IFont_put_Bold(
        void* ptr, BOOL incomingCall,
        BOOL bold );
extern "C" HRESULT E_IFont_get_Italic(
        void* ptr, BOOL incomingCall,
        BOOL FAR* pitalic );
extern "C" HRESULT E_IFont_put_Italic(
        void* ptr, BOOL incomingCall,
        BOOL italic );
extern "C" HRESULT E_IFont_get_Underline(
        void* ptr, BOOL incomingCall,
        BOOL FAR* punderline );
extern "C" HRESULT E_IFont_put_Underline(
        void* ptr, BOOL incomingCall,
        BOOL underline );
extern "C" HRESULT E_IFont_get_Strikethrough(
        void* ptr, BOOL incomingCall,
        BOOL FAR* pstrikethrough );
extern "C" HRESULT E_IFont_put_Strikethrough(
        void* ptr, BOOL incomingCall,
        BOOL strikethrough );
extern "C" HRESULT E_IFont_get_Weight(
        void* ptr, BOOL incomingCall,
        short FAR* pweight );
extern "C" HRESULT E_IFont_put_Weight(
        void* ptr, BOOL incomingCall,
        short weight );
extern "C" HRESULT E_IFont_get_Charset(
        void* ptr, BOOL incomingCall,
        short FAR* pcharset );
extern "C" HRESULT E_IFont_put_Charset(
        void* ptr, BOOL incomingCall,
        short charset );
extern "C" HRESULT E_IFont_get_hFont(
        void* ptr, BOOL incomingCall,
        HFONT FAR* phfont );
extern "C" HRESULT E_IFont_Clone(
        void* ptr, BOOL incomingCall,
        IFont FAR* FAR* lplpfont );
extern "C" HRESULT E_IFont_IsEqual(
        void* ptr, BOOL incomingCall,
        IFont FAR * lpFontOther );
extern "C" HRESULT E_IFont_SetRatio(
        void* ptr, BOOL incomingCall,
        long cyLogical, long cyHimetric );
extern "C" HRESULT E_IFont_QueryTextMetrics(
        void* ptr, BOOL incomingCall,
        LPTEXTMETRICOLE lptm );
extern "C" HRESULT E_IFont_AddRefHfont(
        void* ptr, BOOL incomingCall,
        HFONT hfont );
extern "C" HRESULT E_IFont_ReleaseHfont(
        void* ptr, BOOL incomingCall,
        HFONT hfont );
extern "C" HRESULT E_IFont_SetHdc (
        void *ptr, BOOL incomingCall,
        HDC hdc);

/////////////////////////////////////////////////////////////////////////////
//
// IFontDisp
//

//extern "C" HRESULT E_IFontDisp_GetTypeInfoCount(
//        void* ptr, BOOL incomingCall,
//        UINT FAR* pctinfo );
//extern "C" HRESULT E_IFontDisp_GetTypeInfo(
//        void* ptr, BOOL incomingCall,
//        UINT itinfo, LCID lcid,
//        ITypeInfo FAR* FAR* pptinfo );
//extern "C" HRESULT E_IFontDisp_GetIDsOfNames(
//        void* ptr, BOOL incomingCall,
//        REFIID riid, LPOLESTR FAR* rgszNames,
//        UINT cNames, LCID lcid, DISPID FAR* rgdispid );
//extern "C" HRESULT E_IFontDisp_Invoke(
//        void* ptr, BOOL incomingCall,
//        DISPID dispidMember, REFIID riid, LCID lcid,
//        WORD wFlags, DISPPARAMS FAR* pdispparams, VARIANT FAR* pvarResult,
//        EXCEPINFO FAR* pexcepinfo, UINT FAR* puArgErr );

/////////////////////////////////////////////////////////////////////////////
//
// IPicture
//

extern "C" HRESULT E_IPicture_get_Handle(
        EIF_OBJ ptr, BOOL incomingCall,
        OLE_HANDLE FAR* phandle );
extern "C" HRESULT E_IPicture_get_hPal(
        void* ptr, BOOL incomingCall,
        OLE_HANDLE FAR* phpal );
extern "C" HRESULT E_IPicture_get_Type(
        void* ptr, BOOL incomingCall,
        short FAR* ptype );
extern "C" HRESULT E_IPicture_get_Width(
        void* ptr, BOOL incomingCall,
        OLE_XSIZE_HIMETRIC FAR* pwidth );
extern "C" HRESULT E_IPicture_get_Height(
        void* ptr, BOOL incomingCall,
        OLE_YSIZE_HIMETRIC FAR* pheight );
extern "C" HRESULT E_IPicture_Render(
        void* ptr, BOOL incomingCall,
        HDC hdc,
        long x, long y, long cx, long cy,
        OLE_XPOS_HIMETRIC xSrc, OLE_YPOS_HIMETRIC ySrc,
        OLE_XSIZE_HIMETRIC cxSrc, OLE_YSIZE_HIMETRIC cySrc,
        LPCRECT lprcWBounds );
extern "C" HRESULT E_IPicture_set_hPal(
        void* ptr, BOOL incomingCall,
        OLE_HANDLE hpal );
extern "C" HRESULT E_IPicture_get_CurDC(
        void* ptr, BOOL incomingCall,
        HDC FAR * phdcOut );
extern "C" HRESULT E_IPicture_SelectPicture(
        void* ptr, BOOL incomingCall,
        HDC hdcIn, HDC FAR * phdcOut,
        OLE_HANDLE FAR * phbmpOut );
extern "C" HRESULT E_IPicture_get_KeepOriginalFormat(
        void* ptr, BOOL incomingCall,
        BOOL * pfkeep );
extern "C" HRESULT E_IPicture_put_KeepOriginalFormat(
        void* ptr, BOOL incomingCall,
        BOOL fkeep );
extern "C" HRESULT E_IPicture_PictureChanged(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IPicture_SaveAsFile(
        void* ptr, BOOL incomingCall,
        LPSTREAM lpstream, BOOL fSaveMemCopy,
        LONG FAR * lpcbSize );
extern "C" HRESULT E_IPicture_get_Attributes(
        void* ptr, BOOL incomingCall,
        DWORD FAR * lpdwAttr );

/////////////////////////////////////////////////////////////////////////////
//
// IPictureDisp
//

extern "C" HRESULT E_IPictureDisp_GetTypeInfoCount(
        void* ptr, BOOL incomingCall,
        UINT FAR* pctinfo );
extern "C" HRESULT E_IPictureDisp_GetTypeInfo(
        void* ptr, BOOL incomingCall,
        UINT itinfo, LCID lcid,
        ITypeInfo FAR* FAR* pptinfo );
extern "C" HRESULT E_IPictureDisp_GetIDsOfNames(
        void* ptr, BOOL incomingCall,
        REFIID riid, LPOLESTR FAR* rgszNames,
        UINT cNames, LCID lcid, DISPID FAR* rgdispid );
extern "C" HRESULT E_IPictureDisp_Invoke(
        void* ptr, BOOL incomingCall,
        DISPID dispidMember, REFIID riid,
        LCID lcid, WORD wFlags, DISPPARAMS FAR* pdispparams,
        VARIANT FAR* pvarResult, EXCEPINFO FAR* pexcepinfo,
        UINT FAR* puArgErr );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumFORMATETC
//

extern "C" HRESULT E_IEnumFOERMATETC_Next(
        void* ptr, BOOL incomingCall,
        ULONG celt, FORMATETC __RPC_FAR *rgelt,
        ULONG __RPC_FAR *pceltFetched );
extern "C" HRESULT E_IEnumFOERMATETC_Skip(
        void* ptr, BOOL incomingCall,
        ULONG celt );
extern "C" HRESULT E_IEnumFOERMATETC_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumFOERMATETC_Clone(
        void* ptr, BOOL incomingCall,
        IEnumFORMATETC __RPC_FAR *__RPC_FAR *ppenum );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumMoniker
//

extern "C" HRESULT E_IEnumMoniker_Next(
        void* ptr, BOOL incomingCall,
        ULONG celt, IMoniker __RPC_FAR *__RPC_FAR *rgelt,
        ULONG __RPC_FAR *pceltFetched );
extern "C" HRESULT E_IEnumMoniker_Skip(
        void* ptr, BOOL incomingCall,
        ULONG celt );
extern "C" HRESULT E_IEnumMoniker_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumMoniker_Clone(
        void* ptr, BOOL incomingCall,
        IEnumMoniker __RPC_FAR *__RPC_FAR *ppenum );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumOLEVERB
//

extern "C" HRESULT E_IEnumOLEVERB_Next(
        void* ptr, BOOL incomingCall,
        ULONG celt, LPOLEVERB rgelt,
        ULONG __RPC_FAR *pceltFetched );
extern "C" HRESULT E_IEnumOLEVERB_Skip(
        void* ptr, BOOL incomingCall,
        ULONG celt );
extern "C" HRESULT E_IEnumOLEVERB_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumOLEVERB_Clone(
        void* ptr, BOOL incomingCall,
        IEnumOLEVERB __RPC_FAR *__RPC_FAR *ppenum );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumSTATDATA
//

extern "C" HRESULT E_IEnumSTATDATA_Next(
        void* ptr, BOOL incomingCall,
        ULONG celt, STATDATA __RPC_FAR *rgelt,
        ULONG __RPC_FAR *pceltFetched );
extern "C" HRESULT E_IEnumSTATDATA_Skip(
        void* ptr, BOOL incomingCall,
        ULONG celt );
extern "C" HRESULT E_IEnumSTATDATA_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumSTATDATA_Clone(
        void* ptr, BOOL incomingCall,
        IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenum );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumSTATSTG
//

extern "C" HRESULT E_IEnumSTATSTG_Next(
        void* ptr, BOOL incomingCall,
        ULONG celt, STATSTG __RPC_FAR *rgelt,
        ULONG __RPC_FAR *pceltFetched );
extern "C" HRESULT E_IEnumSTATSTG_Skip(
        void* ptr, BOOL incomingCall,
        ULONG celt );
extern "C" HRESULT E_IEnumSTATSTG_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumSTATSTG_Clone(
        void* ptr, BOOL incomingCall,
        IEnumSTATSTG __RPC_FAR *__RPC_FAR *ppenum );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumVariant
//

extern "C" HRESULT E_IEnumVARIANT_Next(
        void* ptr, BOOL incomingCall,
        unsigned long celt, VARIANT __RPC_FAR *rgvar,
        unsigned long __RPC_FAR *pceltFetched );
extern "C" HRESULT E_IEnumVARIANT_Skip(
        void* ptr, BOOL incomingCall,
        unsigned long celt );
extern "C" HRESULT E_IEnumVARIANT_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumVARIANT_Clone(
        void* ptr, BOOL incomingCall,
        IEnumVARIANT __RPC_FAR *__RPC_FAR *ppenum );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumUnknown
//

extern "C" HRESULT E_IEnumUnknown_Next(
        void* ptr, BOOL incomingCall,
        ULONG celt, IUnknown __RPC_FAR *__RPC_FAR *rgelt,
        ULONG __RPC_FAR *pceltFetched );
extern "C" HRESULT E_IEnumUnknown_Skip(
        void* ptr, BOOL incomingCall,
        ULONG celt );
extern "C" HRESULT E_IEnumUnknown_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumUnknown_Clone(
        void* ptr, BOOL incomingCall,
        IEnumUnknown __RPC_FAR *__RPC_FAR *ppenum );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumConnectionPoints
//

extern "C" HRESULT E_IEnumConnectionPoints_Next(
        void* ptr, BOOL incomingCall,
        ULONG cConnections,
        LPCONNECTIONPOINT FAR* rgpcn,
        ULONG FAR* lpcFetched );
extern "C" HRESULT E_IEnumConnectionPoints_Skip(
        void* ptr, BOOL incomingCall,
        ULONG cConnections );
extern "C" HRESULT E_IEnumConnectionPoints_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumConnectionPoints_Clone(
        void* ptr, BOOL incomingCall,
        LPENUMCONNECTIONPOINTS FAR* ppEnum );

/////////////////////////////////////////////////////////////////////////////
//
// IEnumConnections
//

extern "C" HRESULT E_IEnumConnections_Next(
        void* ptr, BOOL incomingCall,
        ULONG cConnections,
        CONNECTDATA **rgcd,
        ULONG FAR* lpcFetched );
extern "C" HRESULT E_IEnumConnections_Skip(
        void* ptr, BOOL incomingCall,
        ULONG cConnections );
extern "C" HRESULT E_IEnumConnections_Reset(
        void* ptr, BOOL incomingCall );
extern "C" HRESULT E_IEnumConnections_Clone(
        void* ptr, BOOL incomingCall,
        LPENUMCONNECTIONS FAR* ppecn );

/////////////////////////////////////////////////////////////////////////////
//
// IOleContainer
//

extern "C" HRESULT E_IOleContainer_EnumObjects (
        void *ptr, BOOL incomingCall,
        DWORD grfFlags,
        IEnumUnknown __RPC_FAR *__RPC_FAR *ppenum);

extern "C" HRESULT E_IOleContainer_LockContainer (
        void *ptr, BOOL incomingCall, BOOL fLock);

#endif // !__WRAPFUNC_H_INC__

/////// END OF FILE /////////////////////////////////////////////////////////

