/////////////////////////////////////////////////////////////////////////////
//
//     INTERFAC.H     Copyright (c) 1996 by SiG Computer
//
//     Version:       0.00
//
//     Eiffel OLE 2 Library
//
//     EOLE interfaces support
//
//     Notes:
//       None.
//


#ifndef __INTERFAC_H_INC__
#define __INTERFAC_H_INC__

/////////////////////////////////////////////////////////////////////////////
//
// Here are the forward declarations of all interfaces supported
// by Eiffel OLE2 library.
//

class E_IUnknown;
//    class E_IAdviseSink;
//        class E_IAdviseSink2;
    class E_IBindCtx;
    class E_IClassFactory;
        class E_IClassFactory2;
    class E_IConnectionPointContainer;
    class E_IConnectionPoint;
    class E_ICreateErrorInfo;
    class E_ICreateTypeInfo;
    class E_ICreateTypeLib;
    class E_IDataAdviseHolder;
    class E_IDataObject;
    class E_IDispatch;
//        class E_IFontDisp;
        class E_IPictureDisp;
    class E_IDropSource;
    class E_IDropTarget;
    class E_IErrorInfo;
    class E_IExternalConnection;
    class E_ILockBytes;
    class E_IMalloc;
    class E_IMarshal;
    class E_IMessageFilter;
    class E_IOleAdviseHolder;
    class E_IOleCache;
        class E_IOleCache2;
    class E_IOleCacheControl;
    class E_IOleClientSite;
    class E_IParseDisplayName;
        class E_IOleContainer;
            class E_IOleItemContainer;
    class E_IOleControl;
    class E_IOleControlSite;
    class E_IOleWindow;
        class E_IOleInPlaceActiveObject;
        class E_IOleInPlaceObject;
        class E_IOleInPlaceSite;
        class E_IOleInPlaceUIWindow;
            class E_IOleInPlaceFrame;
    class E_IOleLink;
    class E_IOleObject;
    class E_IOleUILinkContainer;
    class E_IPerPropertyBrowsing;
    class E_IPersist;
        class E_IPersistFile;
        class E_IPersistStorage;
        class E_IPersistStream;
            class E_IMoniker;
        class E_IPersistStreamInit;
    class E_IPropertyNotifySink;
    class E_IPropertyPage;
        class E_IPropertyPage2;
    class E_IPropertyPageSite;
    class E_IProvideClassInfo;
    class E_IPSFactoryBuffer;
    class E_IRootStorage;
    class E_IROTData;
    class E_IRpcChannelBuffer;
    class E_IRpcProxyBuffer;
    class E_IRpcStubBuffer;
    class E_IRunnableObject;
    class E_IRunningObjectTable;
    class E_ISimpleFrameSite;
    class E_ISpecifyPropertyPages;
    class E_IStdMarshalInfo;
    class E_IStorage;
    class E_IStream;
    class E_ISupportErrorInfo;
    class E_ITypeComp;
    class E_ITypeInfo;
    class E_ITypeLib;
    class E_IUnknown;
    class E_IViewObject;
        class E_IViewObject2;
    class E_IFont;
    class E_IPicture;
    class E_IEnumFORMATETC;
    class E_IEnumMoniker;
    class E_IEnumOLEVERB;
    class E_IEnumSTATDATA;
    class E_IEnumSTATSTG;
    class E_IEnumVariant;
    class E_IEnumUnknown;
    class E_IEnumConnectionPoints;
    class E_IEnumConnections;

/////////////////////////////////////////////////////////////////////////////

class E_IUnknown
{
public:
    E_IUnknown();
    void SetEiffelCurrentPointer( EIF_OBJ ptr );
    EIF_OBJ GetEiffelCurrentPointer( void ) const;

	STDMETHOD( QueryInterface )( REFIID riid, LPVOID FAR* ppvObj);
	STDMETHOD_( ULONG, AddRef )( void );
	STDMETHOD_( ULONG, Release )( void );
private:
    EIF_OBJ m_pEiffelCurrent;
};

class E_IUnknown2
{
public:
    E_IUnknown2();

	STDMETHOD( QueryInterface )( REFIID riid, LPVOID FAR* ppvObj);

private:
    void* m_pEiffelCurrent;
};
/////////////////////////////////////////////////////////////////////////////

//class E_IAdviseSink : public E_IUnknown
//{
//public:
//    E_IAdviseSink();
//   STDMETHOD_( void, OnDataChange )(
//            FORMATETC __RPC_FAR *pFormatetc,
//            STGMEDIUM __RPC_FAR *pStgmed );
//    STDMETHOD_( void, OnViewChange )( DWORD dwAspect, LONG lindex );
//    STDMETHOD_( void, OnRename )( IMoniker __RPC_FAR *pmk );
//    STDMETHOD_( void, OnSave )( void );
//    STDMETHOD_( void, OnClose )( void );
//};

/////////////////////////////////////////////////////////////////////////////

//class E_IAdviseSink2 : public E_IAdviseSink
//{
//public:
//    E_IAdviseSink2();
//    STDMETHOD_( void, OnLinkSrcChange )( IMoniker __RPC_FAR *pmk );
//};

/////////////////////////////////////////////////////////////////////////////

class E_IBindCtx : public E_IUnknown
{
public:
    E_IBindCtx();
    STDMETHOD( RegisterObjectBound )( IUnknown __RPC_FAR *punk );
    STDMETHOD( RevokeObjectBound )( IUnknown __RPC_FAR *punk );
    STDMETHOD( ReleaseBoundObjects )( void );
    STDMETHOD( SetBindOptions )( BIND_OPTS __RPC_FAR *pbindopts );
    STDMETHOD( GetBindOptions )( BIND_OPTS __RPC_FAR *pbindopts );
    STDMETHOD( GetRunningObjectTable )(
            IRunningObjectTable __RPC_FAR *__RPC_FAR *pprot );
    STDMETHOD( RegisterObjectParam )( LPOLESTR pszKey,
            IUnknown __RPC_FAR *punk );
    STDMETHOD( GetObjectParam )( LPOLESTR pszKey,
            IUnknown __RPC_FAR *__RPC_FAR *ppunk );
    STDMETHOD( EnumObjectParam )( IEnumString __RPC_FAR *__RPC_FAR *ppenum );
    STDMETHOD( RevokeObjectParam )( LPOLESTR pszKey );
};

/////////////////////////////////////////////////////////////////////////////

class E_IClassFactory : public E_IUnknown
{
public:
    E_IClassFactory();

    STDMETHOD( CreateInstance )( IUnknown __RPC_FAR *pUnkOuter,
            REFIID riid, void __RPC_FAR *__RPC_FAR *ppvObject );
    STDMETHOD( LockServer )( BOOL fLock );
};

/////////////////////////////////////////////////////////////////////////////


class E_IClassFactory2 : public E_IClassFactory
{
public:
    E_IClassFactory2();

	STDMETHOD( GetLicInfo )( THIS_ LPLICINFO pLicInfo );
	STDMETHOD( RequestLicKey )( THIS_ DWORD dwResrved, BSTR FAR* pbstrKey);
	STDMETHOD( CreateInstanceLic )( THIS_ LPUNKNOWN pUnkOuter,
            LPUNKNOWN pUnkReserved,
            REFIID riid,
            BSTR bstrKey,
            LPVOID FAR* ppvObject);
};

/////////////////////////////////////////////////////////////////////////////


class E_IConnectionPointContainer : public E_IUnknown
{
public:
    E_IConnectionPointContainer();

    STDMETHOD( EnumConnectionPoints )( THIS_ LPENUMCONNECTIONPOINTS FAR* ppEnum );
    STDMETHOD( FindConnectionPoint )( THIS_ REFIID iid,
            LPCONNECTIONPOINT FAR* ppCP);

};

/////////////////////////////////////////////////////////////////////////////


class E_IConnectionPoint : public E_IUnknown
{
public:
    E_IConnectionPoint();

    STDMETHOD( GetConnectionInterface )( THIS_ IID FAR* pIID );
    STDMETHOD( GetConnectionPointContainer )(
            THIS_ IConnectionPointContainer FAR* FAR* ppCPC );
    STDMETHOD( Advise )( THIS_ LPUNKNOWN pUnkSink, DWORD FAR* pdwCookie );
    STDMETHOD( Unadvise )( THIS_ DWORD dwCookie );
    STDMETHOD( EnumConnections )( THIS_ LPENUMCONNECTIONS FAR* ppEnum );
};

/////////////////////////////////////////////////////////////////////////////


class E_ICreateErrorInfo : public E_IUnknown
{
public:
    E_ICreateErrorInfo();

    STDMETHOD( SetGUID )( REFGUID rguid );
    STDMETHOD( SetSource )( LPOLESTR szSource );
    STDMETHOD( SetDescription )( LPOLESTR szDescription );
    STDMETHOD( SetHelpFile )( LPOLESTR szHelpFile );
    STDMETHOD( SetHelpContext )( DWORD dwHelpContext );
};

/////////////////////////////////////////////////////////////////////////////


class E_ICreateTypeInfo : public E_IUnknown
{
public:
    E_ICreateTypeInfo();

    STDMETHOD( SetGuid )( REFGUID guid );
    STDMETHOD( SetTypeFlags )( UINT uTypeFlags );
    STDMETHOD( SetDocString )( LPOLESTR lpstrDoc );
    STDMETHOD( SetHelpContext )( DWORD dwHelpContext );
    STDMETHOD( SetVersion )( WORD wMajorVerNum, WORD wMinorVerNum );
    STDMETHOD( AddRefTypeInfo )( ITypeInfo __RPC_FAR *ptinfo,
            HREFTYPE __RPC_FAR *phreftype );
    STDMETHOD( AddFuncDesc )( UINT index, FUNCDESC __RPC_FAR *pfuncdesc );
    STDMETHOD( AddImplType )( UINT index, HREFTYPE hreftype );
    STDMETHOD( SetImplTypeFlags )( UINT index, INT impltypeflags );
    STDMETHOD( SetAlignment )( WORD cbAlignment );
    STDMETHOD( SetSchema )( LPOLESTR lpstrSchema );
    STDMETHOD( AddVarDesc )( UINT index, VARDESC __RPC_FAR *pvardesc );
    STDMETHOD( SetFuncAndParamNames )( UINT index,
            LPOLESTR __RPC_FAR *rgszNames,
            UINT cNames );
    STDMETHOD( SetVarName )( UINT index, LPOLESTR szName );
    STDMETHOD( SetTypeDescAlias )( TYPEDESC __RPC_FAR *ptdescAlias );
    STDMETHOD( DefineFuncAsDllEntry )( UINT index, LPOLESTR szDllName,
            LPOLESTR szProcName );
    STDMETHOD( SetFuncDocString )( UINT index, LPOLESTR szDocString );
    STDMETHOD( SetVarDocString )( UINT index, LPOLESTR szDocString );
    STDMETHOD( SetFuncHelpContext )( UINT index, DWORD dwHelpContext );
    STDMETHOD( SetVarHelpContext )( UINT index, DWORD dwHelpContext );
    STDMETHOD( SetMops )( UINT index, BSTR bstrMops );
    STDMETHOD( SetTypeIdldesc )( IDLDESC __RPC_FAR *pidldesc );
    STDMETHOD( LayOut )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_ICreateTypeLib : public E_IUnknown
{
public:
    E_ICreateTypeLib();

    STDMETHOD( CreateTypeInfo )( LPOLESTR szName, TYPEKIND tkind,
            ICreateTypeInfo __RPC_FAR *__RPC_FAR *lplpictinfo );
    STDMETHOD( SetName )( LPOLESTR szName );
    STDMETHOD( SetVersion )( WORD wMajorVerNum, WORD wMinorVerNum );
    STDMETHOD( SetGuid )( REFGUID guid );
    STDMETHOD( SetDocString )( LPOLESTR szDoc );
    STDMETHOD( SetHelpFileName )( LPOLESTR szHelpFileName );
    STDMETHOD( SetHelpContext )( DWORD dwHelpContext );
    STDMETHOD( SetLcid )( LCID lcid );
    STDMETHOD( SetLibFlags )( UINT uLibFlags );
    STDMETHOD( SaveAllChanges )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IDataAdviseHolder : public E_IUnknown
{
public:
    E_IDataAdviseHolder();

    STDMETHOD( Advise )( IDataObject __RPC_FAR *pDataObject,
            FORMATETC __RPC_FAR *pFetc,
            DWORD advf,
            IAdviseSink __RPC_FAR *pAdvise,
            DWORD __RPC_FAR *pdwConnection );
    STDMETHOD( Unadvise )( DWORD dwConnection );
    STDMETHOD( EnumAdvise )(
            IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumAdvise );
    STDMETHOD( SendOnDataChange )( IDataObject __RPC_FAR *pDataObject,
            DWORD dwReserved,
            DWORD advf );
};

/////////////////////////////////////////////////////////////////////////////


class E_IDataObject : public E_IUnknown
{
public:
    E_IDataObject();

    STDMETHOD( GetData )( FORMATETC __RPC_FAR *pformatetcIn,
            STGMEDIUM __RPC_FAR *pmedium );
    STDMETHOD( GetDataHere )( FORMATETC __RPC_FAR *pformatetc,
            STGMEDIUM __RPC_FAR *pmedium );
    STDMETHOD( QueryGetData )( FORMATETC __RPC_FAR *pformatetc );
    STDMETHOD( GetCanonicalFormatEtc )( FORMATETC __RPC_FAR *pformatectIn,
            FORMATETC __RPC_FAR *pformatetcOut );
    STDMETHOD( SetData )( FORMATETC __RPC_FAR *pformatetc,
            STGMEDIUM __RPC_FAR *pmedium,
            BOOL fRelease );
    STDMETHOD( EnumFormatEtc )( DWORD dwDirection,
            IEnumFORMATETC __RPC_FAR *__RPC_FAR *ppenumFormatEtc );
    STDMETHOD( DAdvise )( FORMATETC __RPC_FAR *pformatetc, DWORD advf,
            IAdviseSink __RPC_FAR *pAdvSink, DWORD __RPC_FAR *pdwConnection );
    STDMETHOD( DUnadvise )( DWORD dwConnection );
    STDMETHOD( EnumDAdvise )( IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumAdvise );
};

/////////////////////////////////////////////////////////////////////////////


class E_IDispatch : public E_IUnknown
{
public:
    E_IDispatch();

    STDMETHOD( GetTypeInfoCount )( UINT __RPC_FAR *pctinfo );
    STDMETHOD( GetTypeInfo )( UINT itinfo, LCID lcid,
            ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo );
    STDMETHOD( GetIDsOfNames )( REFIID riid, LPOLESTR __RPC_FAR *rgszNames,
            UINT cNames, LCID lcid, DISPID __RPC_FAR *rgdispid );
    STDMETHOD( Invoke )( DISPID dispidMember, REFIID riid,
            LCID lcid,
            WORD wFlags,
            DISPPARAMS __RPC_FAR *pdispparams,
            VARIANT __RPC_FAR *pvarResult,
            EXCEPINFO __RPC_FAR *pexcepinfo,
            UINT __RPC_FAR *puArgErr );
};

/////////////////////////////////////////////////////////////////////////////


class E_IDropSource : public E_IUnknown
{
public:
    E_IDropSource();

    STDMETHOD( QueryContinueDrag )( BOOL fEscapePressed, DWORD grfKeyState );
    STDMETHOD( GiveFeedback )( DWORD dwEffect );
};

/////////////////////////////////////////////////////////////////////////////


class E_IDropTarget : public E_IUnknown
{
public:
    E_IDropTarget();

    STDMETHOD( DragEnter )( IDataObject __RPC_FAR *pDataObj,
            DWORD grfKeyState,
            POINTL pt,
            DWORD __RPC_FAR *pdwEffect );
    STDMETHOD( DragOver )( DWORD grfKeyState, POINTL pt,
            DWORD __RPC_FAR *pdwEffect );
    STDMETHOD( DragLeave )( void );
    STDMETHOD( Drop )( IDataObject __RPC_FAR *pDataObj, DWORD grfKeyState,
            POINTL pt, DWORD __RPC_FAR *pdwEffect );
};

/////////////////////////////////////////////////////////////////////////////


class E_IErrorInfo : public E_IUnknown
{
public:
    E_IErrorInfo();

    STDMETHOD( GetGUID )( GUID __RPC_FAR *pguid );
    STDMETHOD( GetSource )( BSTR __RPC_FAR *pbstrSource );
    STDMETHOD( GetDescription )( BSTR __RPC_FAR *pbstrDescription );
    STDMETHOD( GetHelpFile )( BSTR __RPC_FAR *pbstrHelpFile );
    STDMETHOD( GetHelpContext )( DWORD __RPC_FAR *pdwHelpContext );
};

/////////////////////////////////////////////////////////////////////////////


class E_IExternalConnection : public E_IUnknown
{
public:
    E_IExternalConnection();

    STDMETHOD( AddConnection )( DWORD extconn, DWORD reserved );
    STDMETHOD( ReleaseConnection )( DWORD extconn, DWORD reserved,
            BOOL fLastReleaseCloses );
};

/////////////////////////////////////////////////////////////////////////////


class E_ILockBytes : public E_IUnknown
{
public:
    E_ILockBytes();

    STDMETHOD( ReadAt )( ULARGE_INTEGER ulOffset, void __RPC_FAR *pv,
            ULONG cb, ULONG __RPC_FAR *pcbRead );
    STDMETHOD( WriteAt )( ULARGE_INTEGER ulOffset, const void __RPC_FAR *pv,
            ULONG cb, ULONG __RPC_FAR *pcbWritten );
    STDMETHOD( Flush )( void );
    STDMETHOD( SetSize )( ULARGE_INTEGER cb );
    STDMETHOD( LockRegion )( ULARGE_INTEGER libOffset, ULARGE_INTEGER cb,
            DWORD dwLockType );
    STDMETHOD( UnlockRegion )( ULARGE_INTEGER libOffset, ULARGE_INTEGER cb,
            DWORD dwLockType);
    STDMETHOD( Stat )( STATSTG __RPC_FAR *pstatstg, DWORD grfStatFlag );
};

/////////////////////////////////////////////////////////////////////////////


class E_IMalloc : public E_IUnknown
{
public:
    E_IMalloc();

    STDMETHOD( Alloc )( ULONG cb );
    STDMETHOD( Realloc )( void __RPC_FAR *pv, ULONG cb );
    STDMETHOD( Free )( void __RPC_FAR *pv );
    STDMETHOD( GetSize )( void __RPC_FAR *pv );
    STDMETHOD( DidAlloc )( void __RPC_FAR *pv );
    STDMETHOD( HeapMinimize )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IMarshal : public E_IUnknown
{
public:
    E_IMarshal();

    STDMETHOD( GetUnmarshalClass )( REFIID riid, void __RPC_FAR *pv,
            DWORD dwDestContext, void __RPC_FAR *pvDestContext,
            DWORD mshlflags, CLSID __RPC_FAR *pCid );
    STDMETHOD( GetMarshalSizeMax )( REFIID riid, void __RPC_FAR *pv,
            DWORD dwDestContext, void __RPC_FAR *pvDestContext,
            DWORD mshlflags, DWORD __RPC_FAR *pSize );
    STDMETHOD( MarshalInterface )( IStream __RPC_FAR *pStm,
            REFIID riid, void __RPC_FAR *pv, DWORD dwDestContext,
            void __RPC_FAR *pvDestContext, DWORD mshlflags );
    STDMETHOD( UnmarshalInterface )( IStream __RPC_FAR *pStm,
            REFIID riid, void __RPC_FAR *__RPC_FAR *ppv );
    STDMETHOD( ReleaseMarshalData )( IStream __RPC_FAR *pStm );
    STDMETHOD( DisconnectObject )( DWORD dwReserved );
};

/////////////////////////////////////////////////////////////////////////////


class E_IMessageFilter : public E_IUnknown
{
public:
    E_IMessageFilter();

    STDMETHOD( HandleInComingCall )( DWORD dwCallType, HTASK htaskCaller,
            DWORD dwTickCount, LPINTERFACEINFO lpInterfaceInfo );
    STDMETHOD( RetryRejectedCall )( HTASK htaskCallee, DWORD dwTickCount,
            DWORD dwRejectType );
    STDMETHOD( MessagePending )( HTASK htaskCallee, DWORD dwTickCount,
            DWORD dwPendingType );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleAdviseHolder : public E_IUnknown
{
public:
    E_IOleAdviseHolder();

    STDMETHOD( Advise )( IAdviseSink __RPC_FAR *pAdvise,
            DWORD __RPC_FAR *pdwConnection );
    STDMETHOD( Unadvise )( DWORD dwConnection );
    STDMETHOD( EnumAdvise )( IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumAdvise );
    STDMETHOD( SendOnRename )( IMoniker __RPC_FAR *pmk );
    STDMETHOD( SendOnSave )( void );
    STDMETHOD( SendOnClose )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleCache : public E_IUnknown
{
public:
    E_IOleCache();

    STDMETHOD( Cache )( FORMATETC __RPC_FAR *pformatetc,
            DWORD advf, DWORD __RPC_FAR *pdwConnection );
    STDMETHOD( Uncache )( DWORD dwConnection );
    STDMETHOD( EnumCache )( IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumSTATDATA );
    STDMETHOD( InitCache )( IDataObject __RPC_FAR *pDataObject );
    STDMETHOD( SetData )( FORMATETC __RPC_FAR *pformatetc,
            STGMEDIUM __RPC_FAR *pmedium, BOOL fRelease );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleCache2 : public E_IOleCache
{
public:
    E_IOleCache2();

    STDMETHOD( UpdateCache )( LPDATAOBJECT pDataObject, DWORD grfUpdf,
            LPVOID pReserved );
    STDMETHOD( DiscardCache )( DWORD dwDiscardOptions );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleCacheControl : public E_IUnknown
{
public:
    E_IOleCacheControl();

    STDMETHOD( OnRun )( LPDATAOBJECT pDataObject );
    STDMETHOD( OnStop )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleClientSite : public E_IUnknown
{
public:
    E_IOleClientSite();

    STDMETHOD( SaveObject )( void );
    STDMETHOD( GetMoniker )( DWORD dwAssign, DWORD dwWhichMoniker,
            IMoniker __RPC_FAR *__RPC_FAR *ppmk );
    STDMETHOD( GetContainer )(
            IOleContainer __RPC_FAR *__RPC_FAR *ppContainer );
    STDMETHOD( ShowObject )( void );
    STDMETHOD( OnShowWindow )( BOOL fShow );
    STDMETHOD( RequestNewObjectLayout )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IParseDisplayName : public E_IUnknown
{
public:
    E_IParseDisplayName();

    STDMETHOD( ParseDisplayName )( IBindCtx __RPC_FAR *pbc,
            LPOLESTR pszDisplayName, ULONG __RPC_FAR *pchEaten,
            IMoniker __RPC_FAR *__RPC_FAR *ppmkOut );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleContainer : public E_IParseDisplayName
{
public:
    E_IOleContainer();

    STDMETHOD( EnumObjects )( DWORD grfFlags,
            IEnumUnknown __RPC_FAR *__RPC_FAR *ppenum );
    STDMETHOD( LockContainer )( BOOL fLock );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleControl : public E_IUnknown
{
public:
    E_IOleControl();

    STDMETHOD( GetControlInfo )( THIS_ LPCONTROLINFO pCI );
    STDMETHOD( OnMnemonic )( THIS_ LPMSG pMsg );
    STDMETHOD( OnAmbientPropertyChange )( THIS_ DISPID dispid );
    STDMETHOD( FreezeEvents )( THIS_ BOOL bFreeze );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleControlSite : public E_IUnknown
{
public:
    E_IOleControlSite();

    STDMETHOD( OnControlInfoChanged )( void );
    STDMETHOD( LockInPlaceActivate )( BOOL fLock );
    STDMETHOD( GetExtendedControl )( LPDISPATCH FAR* ppDisp );
    STDMETHOD( TransformCoords)( POINTL FAR* lpptlHimetric,
            POINTF FAR* lpptfContainer, DWORD flags );
    STDMETHOD( TranslateAccelerator )( LPMSG lpMsg, DWORD grfModifiers);
    STDMETHOD( OnFocus )( THIS_ BOOL fGotFocus);
    STDMETHOD( ShowPropertyFrame )( THIS );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleWindow : public E_IUnknown
{
public:
    E_IOleWindow();

    STDMETHOD( GetWindow )( HWND __RPC_FAR *phwnd );
    STDMETHOD( ContextSensitiveHelp )( BOOL fEnterMode );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleInPlaceUIWindow : public E_IOleWindow
{
public:
    E_IOleInPlaceUIWindow();

    STDMETHOD( GetBorder )( LPRECT lprectBorder );
    STDMETHOD( RequestBorderSpace )( LPCBORDERWIDTHS pborderwidths );
    STDMETHOD( SetBorderSpace )( LPCBORDERWIDTHS pborderwidths );
    STDMETHOD( SetActiveObject )(
            IOleInPlaceActiveObject __RPC_FAR *pActiveObject,
            LPCOLESTR pszObjName );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleInPlaceActiveObject : public E_IOleWindow
{
public:
    E_IOleInPlaceActiveObject();

    STDMETHOD( TranslateAccelerator )( LPMSG lpmsg );
    STDMETHOD( OnFrameWindowActivate )( BOOL fActivate );
    STDMETHOD( OnDocWindowActivate )( BOOL fActivate );
    STDMETHOD( ResizeBorder )( LPCRECT prcBorder,
            IOleInPlaceUIWindow __RPC_FAR *pUIWindow,
            BOOL fFrameWindow );
    STDMETHOD( EnableModeless )( BOOL fEnable );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleInPlaceFrame : public E_IOleInPlaceUIWindow
{
public:
    E_IOleInPlaceFrame();

    STDMETHOD( InsertMenus )( HMENU hmenuShared,
            LPOLEMENUGROUPWIDTHS lpMenuWidths );
    STDMETHOD( SetMenu )( HMENU hmenuShared, HOLEMENU holemenu,
            HWND hwndActiveObject );
    STDMETHOD( RemoveMenus )( HMENU hmenuShared );
    STDMETHOD( SetStatusText )( LPCOLESTR pszStatusText );
    STDMETHOD( EnableModeless )( BOOL fEnable );
    STDMETHOD( TranslateAccelerator )( LPMSG lpmsg, WORD wID );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleInPlaceObject : public E_IOleWindow
{
public:
    E_IOleInPlaceObject();

    STDMETHOD( InPlaceDeactivate )( void );
    STDMETHOD( UIDeactivate )( void );
    STDMETHOD( SetObjectRects )( LPCRECT lprcPosRect, LPCRECT lprcClipRect );
    STDMETHOD( ReactivateAndUndo )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleInPlaceSite :public E_IOleWindow
{
public:
    E_IOleInPlaceSite();

    STDMETHOD( CanInPlaceActivate )( void );
    STDMETHOD( OnInPlaceActivate )( void );
    STDMETHOD( OnUIActivate )( void );
    STDMETHOD( GetWindowContext )(
            IOleInPlaceFrame __RPC_FAR *__RPC_FAR *ppFrame,
            IOleInPlaceUIWindow __RPC_FAR *__RPC_FAR *ppDoc,
            LPRECT lprcPosRect,
            LPRECT lprcClipRect,
            LPOLEINPLACEFRAMEINFO lpFrameInfo );
    STDMETHOD( Scroll )( SIZE scrollExtent );
    STDMETHOD( OnUIDeactivate )( BOOL fUndoable );
    STDMETHOD( OnInPlaceDeactivate )( void );
    STDMETHOD( DiscardUndoState )( void );
    STDMETHOD( DeactivateAndUndo )( void );
    STDMETHOD( OnPosRectChange )( LPCRECT lprcPosRect );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleItemContainer : public E_IOleContainer
{
public:
    E_IOleItemContainer();

    STDMETHOD( GetObject )( LPOLESTR pszItem, DWORD dwSpeedNeeded,
            IBindCtx __RPC_FAR *pbc, REFIID riid,
            void __RPC_FAR *__RPC_FAR *ppvObject );
    STDMETHOD( GetObjectStorage )( LPOLESTR pszItem, IBindCtx __RPC_FAR *pbc,
            REFIID riid, void __RPC_FAR *__RPC_FAR *ppvStorage );
    STDMETHOD( IsRunning )( LPOLESTR pszItem );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleLink : public E_IUnknown
{
public:
    E_IOleLink();

    STDMETHOD( SetUpdateOptions )( DWORD dwUpdateOpt );
    STDMETHOD( GetUpdateOptions )(
            DWORD __RPC_FAR *pdwUpdateOpt );
    STDMETHOD( SetSourceMoniker )( IMoniker __RPC_FAR *pmk,
            REFCLSID rclsid );
    STDMETHOD( GetSourceMoniker )(
            IMoniker __RPC_FAR *__RPC_FAR *ppmk );
    STDMETHOD( SetSourceDisplayName )( LPCOLESTR pszStatusText );
    STDMETHOD( GetSourceDisplayName )(
            LPOLESTR __RPC_FAR *ppszDisplayName );
    STDMETHOD( BindToSource )( DWORD bindflags, IBindCtx __RPC_FAR *pbc );
    STDMETHOD( BindIfRunning )( void );
    STDMETHOD( GetBoundSource )( IUnknown __RPC_FAR *__RPC_FAR *ppunk );
    STDMETHOD( UnbindSource )( void );
    STDMETHOD( Update )( IBindCtx __RPC_FAR *pbc );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleObject : public E_IUnknown
{
public:
    E_IOleObject();

    STDMETHOD( SetClientSite )( IOleClientSite __RPC_FAR *pClientSite );
    STDMETHOD( GetClientSite )( IOleClientSite __RPC_FAR *__RPC_FAR *ppClientSite );
    STDMETHOD( SetHostNames )( LPCOLESTR szContainerApp, LPCOLESTR szContainerObj );
    STDMETHOD( Close )( DWORD dwSaveOption );
    STDMETHOD( SetMoniker )( DWORD dwWhichMoniker, IMoniker __RPC_FAR *pmk );
    STDMETHOD( GetMoniker )( DWORD dwAssign, DWORD dwWhichMoniker,
            IMoniker __RPC_FAR *__RPC_FAR *ppmk );
    STDMETHOD( InitFromData )( IDataObject __RPC_FAR *pDataObject,
            BOOL fCreation, DWORD dwReserved );
    STDMETHOD( GetClipboardData )( DWORD dwReserved,
            IDataObject __RPC_FAR *__RPC_FAR *ppDataObject );
    STDMETHOD( DoVerb )( LONG iVerb, LPMSG lpmsg,
            IOleClientSite __RPC_FAR *pActiveSite, LONG lindex, HWND hwndParent,
            LPCRECT lprcPosRect );
    STDMETHOD( EnumVerbs )( IEnumOLEVERB __RPC_FAR *__RPC_FAR *ppEnumOleVerb );
    STDMETHOD( Update )( void );
    STDMETHOD( IsUpToDate )( void );
    STDMETHOD( GetUserClassID )( CLSID __RPC_FAR *pClsid );
    STDMETHOD( GetUserType )( DWORD dwFormOfType,
            LPOLESTR __RPC_FAR *pszUserType );
    STDMETHOD( SetExtent )( DWORD dwDrawAspect, SIZEL __RPC_FAR *psizel );
    STDMETHOD( GetExtent )( DWORD dwDrawAspect, SIZEL __RPC_FAR *psizel );
    STDMETHOD( Advise )( IAdviseSink __RPC_FAR *pAdvSink,
            DWORD __RPC_FAR *pdwConnection );
    STDMETHOD( Unadvise )( DWORD dwConnection );
    STDMETHOD( EnumAdvise )(
            IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenumAdvise );
    STDMETHOD( GetMiscStatus )( DWORD dwAspect, DWORD __RPC_FAR *pdwStatus );
    STDMETHOD( SetColorScheme )( LOGPALETTE __RPC_FAR *pLogpal );
};

/////////////////////////////////////////////////////////////////////////////


class E_IOleUILinkContainer : public E_IUnknown
{
public:
    E_IOleUILinkContainer();

    STDMETHOD_( DWORD, GetNextLink )( DWORD dwLink );
    STDMETHOD( SetLinkUpdateOptions )( DWORD dwLink, DWORD dwUpdateOpt );
    STDMETHOD( GetLinkUpdateOptions )( DWORD dwLink, DWORD FAR* lpdwUpdateOpt );
    STDMETHOD( SetLinkSource )( DWORD dwLink, LPTSTR lpszDisplayName,
            ULONG lenFileName, ULONG FAR* pchEaten, BOOL fValidateSource );
	STDMETHOD( GetLinkSource )( DWORD dwLink, LPTSTR FAR* lplpszDisplayName,
	        ULONG FAR* lplenFileName, LPTSTR FAR* lplpszFullLinkType,
	        LPTSTR FAR* lplpszShortLinkType, BOOL FAR* lpfSourceAvailable,
	        BOOL FAR* lpfIsSelected );
	STDMETHOD( OpenLinkSource )( DWORD dwLink );
	STDMETHOD( UpdateLink )( DWORD dwLink, BOOL fErrorMessage, BOOL fErrorAction );
	STDMETHOD( CancelLink )( DWORD dwLink );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPerPropertyBrowsing : public E_IUnknown
{
public:
    E_IPerPropertyBrowsing();

    STDMETHOD( GetDisplayString )( DISPID dispid, BSTR FAR* lpbstr );
    STDMETHOD( MapPropertyToPage )( DISPID dispid, LPCLSID lpclsid );
    STDMETHOD( GetPredefinedStrings )( DISPID dispid,
            CALPOLESTR FAR* lpcaStringsOut,
            CADWORD FAR* lpcaCookiesOut );
    STDMETHOD( GetPredefinedValue )( DISPID dispid, DWORD dwCookie,
            VARIANT FAR* lpvarOut );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPersist : public E_IUnknown
{
public:
    E_IPersist();

    STDMETHOD( GetClassID )( CLSID __RPC_FAR *pClassID );

};

/////////////////////////////////////////////////////////////////////////////


class E_IPersistFile : public E_IPersist
{
public:
    E_IPersistFile();

    STDMETHOD( IsDirty )( void );
    STDMETHOD( Load )( LPCOLESTR pszFileName, DWORD dwMode );
    STDMETHOD( Save )( LPCOLESTR pszFileName, BOOL fRemember );
    STDMETHOD( SaveCompleted )( LPCOLESTR pszFileName );
    STDMETHOD( GetCurFile )( LPOLESTR __RPC_FAR *ppszFileName );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPersistStorage : public E_IPersist
{
public:
    E_IPersistStorage();

    STDMETHOD( IsDirty )( void );
    STDMETHOD( InitNew )( IStorage __RPC_FAR *pStg );
    STDMETHOD( Load )( IStorage __RPC_FAR *pStg );
    STDMETHOD( Save )( IStorage __RPC_FAR *pStgSave, BOOL fSameAsLoad );
    STDMETHOD( SaveCompleted )( IStorage __RPC_FAR *pStgNew );
    STDMETHOD( HandsOffStorage )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPersistStream : public E_IPersist
{
public:
    E_IPersistStream();

    STDMETHOD( IsDirty )( void );
    STDMETHOD( Load )( IStream __RPC_FAR *pStm );
    STDMETHOD( Save )( IStream __RPC_FAR *pStm, BOOL fClearDirty );
    STDMETHOD( GetSizeMax )( ULARGE_INTEGER __RPC_FAR *pcbSize );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPersistStreamInit : public E_IPersistStream
{
public:
    E_IPersistStreamInit();

    STDMETHOD( InitNew )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IMoniker : public E_IPersistStream
{
public:
    E_IMoniker();

    STDMETHOD( BindToObject )( IBindCtx __RPC_FAR *pbc,
            IMoniker __RPC_FAR *pmkToLeft,
            REFIID riidResult,
            void __RPC_FAR *__RPC_FAR *ppvResult );
    STDMETHOD( BindToStorage )( IBindCtx __RPC_FAR *pbc,
            IMoniker __RPC_FAR *pmkToLeft, REFIID riid,
            void __RPC_FAR *__RPC_FAR *ppvObj );
    STDMETHOD( Reduce )( IBindCtx __RPC_FAR *pbc, DWORD dwReduceHowFar,
            IMoniker __RPC_FAR *__RPC_FAR *ppmkToLeft,
            IMoniker __RPC_FAR *__RPC_FAR *ppmkReduced );
    STDMETHOD( ComposeWith )( IMoniker __RPC_FAR *pmkRight,
            BOOL fOnlyIfNotGeneric,
            IMoniker __RPC_FAR *__RPC_FAR *ppmkComposite );
    STDMETHOD( Enum )( BOOL fForward,
            IEnumMoniker __RPC_FAR *__RPC_FAR *ppenumMoniker );
    STDMETHOD( IsEqual )( IMoniker __RPC_FAR *pmkOtherMoniker );
    STDMETHOD( Hash )( DWORD __RPC_FAR *pdwHash );
    STDMETHOD( IsRunning )( IBindCtx __RPC_FAR *pbc,
            IMoniker __RPC_FAR *pmkToLeft,
            IMoniker __RPC_FAR *pmkNewlyRunning );
    STDMETHOD( GetTimeOfLastChange )( IBindCtx __RPC_FAR *pbc,
            IMoniker __RPC_FAR *pmkToLeft,
            FILETIME __RPC_FAR *pFileTime );
    STDMETHOD( Inverse )( IMoniker __RPC_FAR *__RPC_FAR *ppmk );
    STDMETHOD( CommonPrefixWith )( IMoniker __RPC_FAR *pmkOther,
            IMoniker __RPC_FAR *__RPC_FAR *ppmkPrefix );
    STDMETHOD( RelativePathTo )( IMoniker __RPC_FAR *pmkOther,
            IMoniker __RPC_FAR *__RPC_FAR *ppmkRelPath );
    STDMETHOD( GetDisplayName )( IBindCtx __RPC_FAR *pbc,
            IMoniker __RPC_FAR *pmkToLeft,
            LPOLESTR __RPC_FAR *ppszDisplayName );
    STDMETHOD( ParseDisplayName )( IBindCtx __RPC_FAR *pbc,
            IMoniker __RPC_FAR *pmkToLeft,
            LPOLESTR pszDisplayName,
            ULONG __RPC_FAR *pchEaten,
            IMoniker __RPC_FAR *__RPC_FAR *ppmkOut );
    STDMETHOD( IsSystemMoniker )( DWORD __RPC_FAR *pdwMksys );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPropertyNotifySink : public E_IUnknown
{
public:
    E_IPropertyNotifySink();

    STDMETHOD( OnChanged )( DISPID dispid );
    STDMETHOD( OnRequestEdit )( DISPID dispid );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPropertyPage : public E_IUnknown
{
public:
    E_IPropertyPage();

    STDMETHOD( SetPageSite )( LPPROPERTYPAGESITE pPageSite );
    STDMETHOD( Activate )( HWND hwndParent, LPCRECT lprc, BOOL bModal );
    STDMETHOD( Deactivate )( void );
    STDMETHOD( GetPageInfo )( LPPROPPAGEINFO pPageInfo );
    STDMETHOD( SetObjects )( ULONG cObjects, LPUNKNOWN FAR* ppunk );
    STDMETHOD( Show )( UINT nCmdShow);
    STDMETHOD( Move )( LPCRECT prect );
    STDMETHOD( IsPageDirty )( void );
    STDMETHOD( Apply )( void );
    STDMETHOD( Help )( LPCOLESTR lpszHelpDir );
	STDMETHOD( TranslateAccelerator )( LPMSG lpMsg );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPropertyPage2 : public E_IPropertyPage
{
public:
    E_IPropertyPage2();

    STDMETHOD( EditProperty )( DISPID dispid );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPropertyPageSite : public E_IUnknown
{
public:
    E_IPropertyPageSite();

    STDMETHOD( OnStatusChange )( DWORD flags );
    STDMETHOD( GetLocaleID )( LCID FAR* pLocaleID );
    STDMETHOD( GetPageContainer )( LPUNKNOWN FAR* ppUnk );
    STDMETHOD( TranslateAccelerator )( LPMSG lpMsg );
};


/////////////////////////////////////////////////////////////////////////////


class E_IProvideClassInfo : public E_IUnknown
{
public:
    E_IProvideClassInfo();

    STDMETHOD( GetClassInfo )(THIS_ LPTYPEINFO FAR* ppTI);
};

/////////////////////////////////////////////////////////////////////////////


class E_IPSFactoryBuffer : public E_IUnknown
{
public:
    E_IPSFactory();

    STDMETHOD( CreateProxy )( IUnknown __RPC_FAR *pUnkOuter, REFIID riid,
            IRpcProxyBuffer __RPC_FAR *__RPC_FAR *ppProxy,
            void __RPC_FAR *__RPC_FAR *ppv );

    STDMETHOD( CreateStub )( REFIID riid, IUnknown __RPC_FAR *pUnkServer,
            IRpcStubBuffer __RPC_FAR *__RPC_FAR *ppStub );
};

/////////////////////////////////////////////////////////////////////////////


class E_IRootStorage : public E_IUnknown
{
public:
    E_IRootStorage();

    STDMETHOD( SwitchToFile )( LPOLESTR pszFile );
};

/////////////////////////////////////////////////////////////////////////////


class E_IROTData : public E_IUnknown
{
public:
    E_IROTData();

    STDMETHOD( GetComparisonData )( byte __RPC_FAR *pbData, ULONG cbMax,
            ULONG __RPC_FAR *pcbData );
};

/////////////////////////////////////////////////////////////////////////////


class E_IRpcChannelBuffer : public E_IUnknown
{
public:
    E_IRpcChannelBuffer();

    STDMETHOD( GetBuffer )( RPCOLEMESSAGE __RPC_FAR *pMessage,
            REFIID riid );
    STDMETHOD( SendReceive )( RPCOLEMESSAGE __RPC_FAR *pMessage,
            ULONG __RPC_FAR *pStatus );
    STDMETHOD( FreeBuffer )( RPCOLEMESSAGE __RPC_FAR *pMessage );
    STDMETHOD( GetDestCtx )( DWORD __RPC_FAR *pdwDestContext,
            void __RPC_FAR *__RPC_FAR *ppvDestContext );
    STDMETHOD( IsConnected )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IRpcProxyBuffer : public E_IUnknown
{
public:
    E_IRpcProxyBuffer();

    STDMETHOD( Connect )( IRpcChannelBuffer __RPC_FAR *pRpcChannelBuffer );
    STDMETHOD( Disconnect )( void );
};

/////////////////////////////////////////////////////////////////////////////


class E_IRpcStubBuffer : public E_IUnknown
{
public:
    E_IRpcStubBuffer();

    STDMETHOD( Connect )( IUnknown __RPC_FAR *pUnkServer );
    STDMETHOD( Disconnect )( void );
    STDMETHOD( Invoke )( RPCOLEMESSAGE __RPC_FAR *_prpcmsg,
            IRpcChannelBuffer __RPC_FAR *_pRpcChannelBuffer );
    STDMETHOD_( IRpcStubBuffer __RPC_FAR *, IsIIDSupported )( REFIID riid );
    STDMETHOD_( ULONG, CountRefs )( void );
    STDMETHOD( DebugServerQueryInterface )( void __RPC_FAR *__RPC_FAR *ppv );
    STDMETHOD( DebugServerRelease )( void __RPC_FAR *pv );
};

/////////////////////////////////////////////////////////////////////////////


class E_IRunnableObject : public E_IUnknown
{
public:
    E_IRunnableObject();

    STDMETHOD( GetRunningClass )( LPCLSID lpClsid );
    STDMETHOD( Run )( LPBINDCTX pbc );
    STDMETHOD( IsRunning )( void );
    STDMETHOD( LockRunning )( BOOL fLock, BOOL fLastUnlockCloses );
    STDMETHOD( SetContainedObject )( BOOL fContained );
};

/////////////////////////////////////////////////////////////////////////////


class E_IRunningObjectTable : public E_IUnknown
{
public:
    E_IRunningObjectTable();

    STDMETHOD( Register )( DWORD grfFlags, IUnknown __RPC_FAR *punkObject,
            IMoniker __RPC_FAR *pmkObjectName, DWORD __RPC_FAR *pdwRegister );
    STDMETHOD( Revoke )( WORD dwRegister );
    STDMETHOD( IsRunning )( IMoniker __RPC_FAR *pmkObjectName );
    STDMETHOD( GetObject )( IMoniker __RPC_FAR *pmkObjectName,
            IUnknown __RPC_FAR *__RPC_FAR *ppunkObject );
    STDMETHOD( NoteChangeTime )( DWORD dwRegister,
            FILETIME __RPC_FAR *pfiletime );
    STDMETHOD( GetTimeOfLastChange )( IMoniker __RPC_FAR *pmkObjectName,
            FILETIME __RPC_FAR *pfiletime );
    STDMETHOD( EnumRunning )(
            IEnumMoniker __RPC_FAR *__RPC_FAR *ppenumMoniker );

};

/////////////////////////////////////////////////////////////////////////////


class E_ISimpleFrameSite : public E_IUnknown
{
public:
    E_ISimpleFrameSite();

    STDMETHOD( PreMessageFilter )( HWND hwnd, UINT msg, WPARAM wp,
            LPARAM lp, LRESULT FAR* lplResult, DWORD FAR * lpdwCookie );
    STDMETHOD( PostMessageFilter )( HWND hwnd, UINT msg, WPARAM wp,
            LPARAM lp, LRESULT FAR* lplResult, DWORD dwCookie );
};

/////////////////////////////////////////////////////////////////////////////


class E_ISpecifyPropertyPages : public E_IUnknown
{
public:
    E_ISpecifyPropertyPages();

    STDMETHOD( GetPages )( CAUUID FAR* pPages );
};

/////////////////////////////////////////////////////////////////////////////


class E_IStdMarshalInfo : public E_IUnknown
{
public:
    E_IStdMarshalInfo();

    STDMETHOD( GetClassForHandler )(
            DWORD dwDestContext,
            void __RPC_FAR *pvDestContext,
            CLSID __RPC_FAR *pClsid );

};

/////////////////////////////////////////////////////////////////////////////


class E_IStorage : public E_IUnknown
{
public:
    E_IStorage();

    STDMETHOD( CreateStream )( const OLECHAR __RPC_FAR *pwcsName,
            DWORD grfMode, DWORD reserved1, DWORD reserved2,
            IStream __RPC_FAR *__RPC_FAR *ppstm );
    STDMETHOD( OpenStream )( const OLECHAR __RPC_FAR *pwcsName,
            void __RPC_FAR *reserved1, DWORD grfMode, DWORD reserved2,
            IStream __RPC_FAR *__RPC_FAR *ppstm );
    STDMETHOD( CreateStorage )( const OLECHAR __RPC_FAR *pwcsName,
            DWORD grfMode, DWORD dwStgFmt, DWORD reserved2,
            IStorage __RPC_FAR *__RPC_FAR *ppstg );
    STDMETHOD( OpenStorage )( const OLECHAR __RPC_FAR *pwcsName,
            IStorage __RPC_FAR *pstgPriority, DWORD grfMode,
            SNB snbExclude, DWORD reserved,
            IStorage __RPC_FAR *__RPC_FAR *ppstg );
    STDMETHOD( CopyTo )( DWORD ciidExclude, const IID __RPC_FAR *rgiidExclude,
            SNB snbExclude, IStorage __RPC_FAR *pstgDest );
    STDMETHOD( MoveElementTo )( const OLECHAR __RPC_FAR *pwcsName,
            IStorage __RPC_FAR *pstgDest, const OLECHAR __RPC_FAR *pwcsNewName,
            DWORD grfFlags );
    STDMETHOD( Commit )( DWORD grfCommitFlags );
    STDMETHOD( Revert )( void );
    STDMETHOD( EnumElements )( DWORD reserved1, void __RPC_FAR *reserved2,
            DWORD reserved3, IEnumSTATSTG __RPC_FAR *__RPC_FAR *ppenum );
    STDMETHOD( DestroyElement )( const OLECHAR __RPC_FAR *pwcsName );
    STDMETHOD( RenameElement )( const OLECHAR __RPC_FAR *pwcsOldName,
            const OLECHAR __RPC_FAR *pwcsNewName );
    STDMETHOD( SetElementTimes )( const OLECHAR __RPC_FAR *pwcsName,
            const FILETIME __RPC_FAR *pctime,
            const FILETIME __RPC_FAR *patime,
            const FILETIME __RPC_FAR *pmtime );
    STDMETHOD( SetClass )( REFCLSID clsid );
    STDMETHOD( SetStateBits )( DWORD grfStateBits, DWORD grfMask );
    STDMETHOD( Stat )( STATSTG __RPC_FAR *pstatstg, DWORD grfStatFlag );
};

/////////////////////////////////////////////////////////////////////////////


class E_IStream : public E_IUnknown
{
public:
    E_IStream();

    STDMETHOD( Read )( void __RPC_FAR *pv, ULONG cb, ULONG __RPC_FAR *pcbRead );
    STDMETHOD( Write )( const void __RPC_FAR *pv, ULONG cb,
            ULONG __RPC_FAR *pcbWritten );
    STDMETHOD( Seek )( LARGE_INTEGER dlibMove, DWORD dwOrigin,
            ULARGE_INTEGER __RPC_FAR *plibNewPosition );
    STDMETHOD( SetSize )( ULARGE_INTEGER libNewSize );
    STDMETHOD( CopyTo )( IStream __RPC_FAR *pstm, ULARGE_INTEGER cb,
            ULARGE_INTEGER __RPC_FAR *pcbRead,
            ULARGE_INTEGER __RPC_FAR *pcbWritten );
    STDMETHOD( Commit )( DWORD grfCommitFlags );
    STDMETHOD( Revert )( void );
    STDMETHOD( LockRegion )( ULARGE_INTEGER libOffset, ULARGE_INTEGER cb,
            DWORD dwLockType );
    STDMETHOD( UnlockRegion )( ULARGE_INTEGER libOffset, ULARGE_INTEGER cb,
            DWORD dwLockType );
    STDMETHOD( Stat )( STATSTG __RPC_FAR *pstatstg, DWORD grfStatFlag );
    STDMETHOD( Clone )( IStream __RPC_FAR *__RPC_FAR *ppstm );
};

/////////////////////////////////////////////////////////////////////////////


class E_ISupportErrorInfo : public E_IUnknown
{
public:
    E_ISupportErrorInfo();

    STDMETHOD( InterfaceSupportsErrorInfo )( REFIID riid );
};

/////////////////////////////////////////////////////////////////////////////


class E_ITypeComp : public E_IUnknown
{
public:
    E_ITypeComp();

    STDMETHOD( Bind )( LPOLESTR szName, ULONG lHashVal, WORD fFlags,
            ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo,
            DESCKIND __RPC_FAR *pdesckind,
            BINDPTR __RPC_FAR *pbindptr );
    STDMETHOD( BindType )( LPOLESTR szName, ULONG lHashVal,
            ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo,
            ITypeComp __RPC_FAR *__RPC_FAR *pptcomp );
};

/////////////////////////////////////////////////////////////////////////////


class E_ITypeInfo : public E_IUnknown
{
public:
    E_ITypeInfo();

    STDMETHOD( GetTypeAttr )( TYPEATTR __RPC_FAR *__RPC_FAR *pptypeattr );
    STDMETHOD( GetTypeComp )( ITypeComp __RPC_FAR *__RPC_FAR *pptcomp );
    STDMETHOD( GetFuncDesc )( UINT index, FUNCDESC __RPC_FAR *__RPC_FAR *pppfuncdesc );
    STDMETHOD( GetVarDesc )( UINT index, VARDESC __RPC_FAR *__RPC_FAR *ppvardesc );
    STDMETHOD( GetNames )( MEMBERID memid, BSTR __RPC_FAR *rgbstrNames,
            UINT cMaxNames, UINT __RPC_FAR *pcNames );
    STDMETHOD( GetRefTypeOfImplType )( UINT index, HREFTYPE __RPC_FAR *hpreftype );
    STDMETHOD( GetImplTypeFlags )( UINT index, INT __RPC_FAR *pimpltypeflags );
    STDMETHOD( GetIDsOfNames )( OLECHAR __RPC_FAR *__RPC_FAR *rglpszNames,
            UINT cNames, MEMBERID __RPC_FAR *rgmemid );
    STDMETHOD( Invoke )( void __RPC_FAR *pvInstance, MEMBERID memid,
            WORD wFlags, DISPPARAMS __RPC_FAR *pdispparams,
            VARIANT __RPC_FAR *pvarResult, EXCEPINFO __RPC_FAR *pexcepinfo,
            UINT __RPC_FAR *puArgErr );
    STDMETHOD( GetDocumentation )( MEMBERID memid, BSTR __RPC_FAR *pbstrName,
            BSTR __RPC_FAR *pbstrDocString, DWORD __RPC_FAR *pdwHelpContext,
            BSTR __RPC_FAR *pbstrHelpFile );
    STDMETHOD( GetDllEntry )( MEMBERID memid, INVOKEKIND invkind,
            BSTR __RPC_FAR *pbstrDllName, BSTR __RPC_FAR *pbstrName,
            WORD __RPC_FAR *pwOrdinal );
    STDMETHOD( GetRefTypeInfo )( HREFTYPE hreftype,
            ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo );
    STDMETHOD( AddressOfMember )( MEMBERID memid, INVOKEKIND invkind,
            void __RPC_FAR *__RPC_FAR *ppv );
    STDMETHOD( CreateInstance )( IUnknown __RPC_FAR *puncOuter,
            REFIID riid, void __RPC_FAR *__RPC_FAR *ppvObj );
    STDMETHOD( GetMops )( MEMBERID memid, BSTR __RPC_FAR *pbstrMops );
    STDMETHOD( GetContainingTypeLib )( ITypeLib __RPC_FAR *__RPC_FAR *pptlib,
            UINT __RPC_FAR *pindex );
    STDMETHOD( ReleaseTypeAttr )( TYPEATTR __RPC_FAR *ptypeattr );
    STDMETHOD( ReleaseFuncDesc )( FUNCDESC __RPC_FAR *pfuncdesc );
    STDMETHOD( ReleaseVarDesc )( VARDESC __RPC_FAR *pvardesc );
};

/////////////////////////////////////////////////////////////////////////////


class E_ITypeLib : public E_IUnknown
{
public:
    E_ITypeLib();

    STDMETHOD( GetTypeInfoCount )( void );
    STDMETHOD( GetTypeInfo )( UINT index,
            ITypeInfo __RPC_FAR *__RPC_FAR *ppitinfo );
    STDMETHOD( GetTypeInfoType )( UINT index, TYPEKIND __RPC_FAR *ptkind );
    STDMETHOD( GetTypeInfoOfGuid )( REFGUID guid,
            ITypeInfo __RPC_FAR *__RPC_FAR *pptinfo );
    STDMETHOD( GetLibAttr )( TLIBATTR __RPC_FAR *__RPC_FAR *pptlibattr );
    STDMETHOD( GetTypeComp )( ITypeComp __RPC_FAR *__RPC_FAR *pptcomp );
    STDMETHOD( GetDocumentation )( INT index, BSTR __RPC_FAR *pbstrName,
            BSTR __RPC_FAR *pbstrDocString,
            DWORD __RPC_FAR *pdwHelpContext,
            BSTR __RPC_FAR *pbstrHelpFile );
    STDMETHOD( IsName )( LPOLESTR szNameBuf, ULONG lHashVal,
            BOOL __RPC_FAR *pfName );
    STDMETHOD( FindName )( LPOLESTR szNameBuf, ULONG lHashVal,
            ITypeInfo __RPC_FAR *__RPC_FAR *rgptinfo,
            MEMBERID __RPC_FAR *rgmemid,
            USHORT __RPC_FAR *pcFound );
    void ( ReleaseTLibAttr )( TLIBATTR __RPC_FAR *ptlibattr );
};

/////////////////////////////////////////////////////////////////////////////


class E_IViewObject : public E_IUnknown
{
public:
    E_IViewObject();

    STDMETHOD( Draw )( DWORD dwDrawAspect,
            LONG lindex,
            void __RPC_FAR *pvAspect,
            DVTARGETDEVICE __RPC_FAR *ptd,
            HDC hdcTargetDev,
            HDC hdcDraw,
            LPCRECTL lprcBounds,
            LPCRECTL lprcWBounds,
            BOOL ( __stdcall __stdcall __RPC_FAR *pfnContinue )( DWORD dwContinue),
            DWORD dwContinue );
    STDMETHOD( GetColorSet )( DWORD dwDrawAspect, LONG lindex,
            void __RPC_FAR *pvAspect, DVTARGETDEVICE __RPC_FAR *ptd,
            HDC hicTargetDev,
            LOGPALETTE __RPC_FAR *__RPC_FAR *ppColorSet );
    STDMETHOD( Freeze )( DWORD dwDrawAspect, LONG lindex,
            void __RPC_FAR *pvAspect,
            DWORD __RPC_FAR *pdwFreeze );
    STDMETHOD( Unfreeze )( DWORD dwFreeze );
    STDMETHOD( SetAdvise )( DWORD aspects, DWORD advf,
            IAdviseSink __RPC_FAR *pAdvSink );
    STDMETHOD( GetAdvise )( DWORD __RPC_FAR *pAspects,
            DWORD __RPC_FAR *pAdvf,
            IAdviseSink __RPC_FAR *__RPC_FAR *ppAdvSink );
};

/////////////////////////////////////////////////////////////////////////////


class E_IViewObject2 : public E_IViewObject
{
public:
    E_IViewObject2();

    STDMETHOD( GetExtent )( DWORD dwDrawAspect, LONG lindex,
            DVTARGETDEVICE __RPC_FAR *ptd, LPSIZEL lpsizel );
};

/////////////////////////////////////////////////////////////////////////////


class E_IFont : public E_IUnknown
{
public:
    E_IFont();

    STDMETHOD( get_Name )( BSTR FAR* pname );
    STDMETHOD( put_Name )( BSTR name );
    STDMETHOD( get_Size )( CY FAR* psize );
    STDMETHOD( put_Size )( CY size );
    STDMETHOD( get_Bold )( BOOL FAR* pbold );
    STDMETHOD( put_Bold )( BOOL bold );
    STDMETHOD( get_Italic )( BOOL FAR* pitalic );
    STDMETHOD( put_Italic )( BOOL italic );
    STDMETHOD( get_Underline )( BOOL FAR* punderline );
    STDMETHOD( put_Underline )( BOOL underline );
    STDMETHOD( get_Strikethrough )( BOOL FAR* pstrikethrough );
    STDMETHOD( put_Strikethrough )( BOOL strikethrough );
    STDMETHOD( get_Weight )( short FAR* pweight );
    STDMETHOD( put_Weight )( short weight );
    STDMETHOD( get_Charset )( short FAR* pcharset );
    STDMETHOD( put_Charset )( short charset );
    STDMETHOD( get_hFont )( HFONT FAR* phfont );
    STDMETHOD( Clone )( IFont FAR* FAR* lplpfont );
    STDMETHOD( IsEqual )( IFont FAR * lpFontOther );
    STDMETHOD( SetRatio )( long cyLogical, long cyHimetric );
    STDMETHOD( QueryTextMetrics )( LPTEXTMETRICOLE lptm );
    STDMETHOD( AddRefHfont )( HFONT hfont );
    STDMETHOD( ReleaseHfont )( HFONT hfont );
    STDMETHOD( SetHdc )( HDC hdc );
};

/////////////////////////////////////////////////////////////////////////////


//class E_IFontDisp : public E_IDispatch
//{
//public:
//    E_IFontDisp();
//
//    STDMETHOD( GetTypeInfoCount )( UINT FAR* pctinfo );
//    STDMETHOD( GetTypeInfo )( UINT itinfo, LCID lcid,
//            ITypeInfo FAR* FAR* pptinfo );
//    STDMETHOD( GetIDsOfNames )( REFIID riid, LPOLESTR FAR* rgszNames,
//            UINT cNames, LCID lcid, DISPID FAR* rgdispid );
//    STDMETHOD( Invoke )( DISPID dispidMember, REFIID riid, LCID lcid,
//            WORD wFlags, DISPPARAMS FAR* pdispparams, VARIANT FAR* pvarResult,
//            EXCEPINFO FAR* pexcepinfo, UINT FAR* puArgErr );
//};

/////////////////////////////////////////////////////////////////////////////


class E_IPicture : public E_IUnknown
{
public:
    E_IPicture();

    STDMETHOD( get_Handle )( OLE_HANDLE FAR* phandle );
    STDMETHOD( get_hPal )( OLE_HANDLE FAR* phpal );
    STDMETHOD( get_Type )( short FAR* ptype );
    STDMETHOD( get_Width )( OLE_XSIZE_HIMETRIC FAR* pwidth );
    STDMETHOD( get_Height )( OLE_YSIZE_HIMETRIC FAR* pheight );
    STDMETHOD( Render )( HDC hdc, long x, long y, long cx, long cy,
            OLE_XPOS_HIMETRIC xSrc, OLE_YPOS_HIMETRIC ySrc,
            OLE_XSIZE_HIMETRIC cxSrc, OLE_YSIZE_HIMETRIC cySrc,
            LPCRECT lprcWBounds );
    STDMETHOD( set_hPal )( OLE_HANDLE hpal );
    STDMETHOD( get_CurDC )( HDC FAR * phdcOut );
    STDMETHOD( SelectPicture )( HDC hdcIn, HDC FAR * phdcOut,
            OLE_HANDLE FAR * phbmpOut );
    STDMETHOD( get_KeepOriginalFormat )( BOOL * pfkeep );
    STDMETHOD( put_KeepOriginalFormat )( BOOL fkeep );
    STDMETHOD( PictureChanged )( void );
    STDMETHOD( SaveAsFile )( LPSTREAM lpstream, BOOL fSaveMemCopy,
            LONG FAR * lpcbSize );
    STDMETHOD( get_Attributes )( DWORD FAR * lpdwAttr );
};

/////////////////////////////////////////////////////////////////////////////


class E_IPictureDisp : public E_IDispatch
{
public:
    E_IPictureDisp();

    STDMETHOD( GetTypeInfoCount )( UINT FAR* pctinfo );
    STDMETHOD( GetTypeInfo )( UINT itinfo, LCID lcid,
            ITypeInfo FAR* FAR* pptinfo );
    STDMETHOD( GetIDsOfNames )( REFIID riid, LPOLESTR FAR* rgszNames,
            UINT cNames, LCID lcid, DISPID FAR* rgdispid );
    STDMETHOD( Invoke )( DISPID dispidMember, REFIID riid,
            LCID lcid, WORD wFlags, DISPPARAMS FAR* pdispparams,
            VARIANT FAR* pvarResult, EXCEPINFO FAR* pexcepinfo,
            UINT FAR* puArgErr );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumFORMATETC : public E_IUnknown
{
public:
    E_IEnumFORMATETC();

    STDMETHOD( Next )( ULONG celt, FORMATETC __RPC_FAR *rgelt,
            ULONG __RPC_FAR *pceltFetched );
    STDMETHOD( Skip )( ULONG celt );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( IEnumFORMATETC __RPC_FAR *__RPC_FAR *ppenum );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumMoniker : public E_IUnknown
{
public:
    E_IEnumMoniker();

    STDMETHOD( Next )( ULONG celt, IMoniker __RPC_FAR *__RPC_FAR *rgelt,
            ULONG __RPC_FAR *pceltFetched );
    STDMETHOD( Skip )( ULONG celt );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( IEnumMoniker __RPC_FAR *__RPC_FAR *ppenum );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumOLEVERB : public E_IUnknown
{
public:
    E_IEnumOLEVERB();

    STDMETHOD( Next )( ULONG celt, LPOLEVERB rgelt,
            ULONG __RPC_FAR *pceltFetched );
    STDMETHOD( Skip )( ULONG celt );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( IEnumOLEVERB __RPC_FAR *__RPC_FAR *ppenum );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumSTATDATA : public E_IUnknown
{
public:
    E_IEnumSTATDATA();

    STDMETHOD( Next )( ULONG celt, STATDATA __RPC_FAR *rgelt,
            ULONG __RPC_FAR *pceltFetched );
    STDMETHOD( Skip )( ULONG celt );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( IEnumSTATDATA __RPC_FAR *__RPC_FAR *ppenum );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumSTATSTG : public E_IUnknown
{
public:
    E_IEnumSTATSTG();

    STDMETHOD( Next )( ULONG celt, STATSTG __RPC_FAR *rgelt,
            ULONG __RPC_FAR *pceltFetched );
    STDMETHOD( Skip )( ULONG celt );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( IEnumSTATSTG __RPC_FAR *__RPC_FAR *ppenum );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumVariant : public E_IUnknown
{
public:
    E_IEnumVariant();

    STDMETHOD( Next )( unsigned long celt, VARIANT __RPC_FAR *rgvar,
            unsigned long __RPC_FAR *pceltFetched );
    STDMETHOD( Skip )( unsigned long celt );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( IEnumVARIANT __RPC_FAR *__RPC_FAR *ppenum );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumUnknown : public E_IUnknown
{
public:
    E_IEnumUnknown();

    STDMETHOD( Next )( ULONG celt, IUnknown __RPC_FAR *__RPC_FAR *rgelt,
            ULONG __RPC_FAR *pceltFetched );
    STDMETHOD( Skip )( ULONG celt );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( IEnumUnknown __RPC_FAR *__RPC_FAR *ppenum );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumConnectionPoints : public E_IUnknown
{
public:
    E_IEnumConnectionPoints();

    STDMETHOD( Next )( ULONG cConnections,
            LPCONNECTIONPOINT FAR* rgpcn,
            ULONG FAR* lpcFetched );
    STDMETHOD( Skip )( ULONG cConnections );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( LPENUMCONNECTIONPOINTS FAR* ppEnum );
};

/////////////////////////////////////////////////////////////////////////////


class E_IEnumConnections : public E_IUnknown
{
public:
    E_IEnumConnections();

    STDMETHOD( Next )( ULONG cConnections,
            CONNECTDATA **rgcd,
            ULONG FAR* lpcFetched );
    STDMETHOD( Skip )( ULONG cConnections );
    STDMETHOD( Reset )( void );
    STDMETHOD( Clone )( LPENUMCONNECTIONS FAR* ppecn );
};


#endif // !__INTERFAC_H_INC__

/////// END OF FILE /////////////////////////////////////////////////////////
