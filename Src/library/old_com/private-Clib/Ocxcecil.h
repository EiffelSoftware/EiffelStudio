/////////////////////////////////////////////////////////////////////////////
//
//     OCXCECIL.H     Copyright (c) 1996 by SiG Computer
//
//     Version:       0.00
//
//     Eiffel OLE 2 Library
//
//     OCX calls OLE2->C->Eiffel support
//
//     Notes:
//       None.
//

#ifndef __OCXCECIL_H_INC__
#define __OCXCECIL_H_INC__

/////////////////////////////////////////////////////////////////////////////
//
// Since E_IOleInPlaceSite::GetWindowContext method has 4 [out] parameters :~(
// me must aggregate it in the single data structure to interface with Eiffel.
//

typedef struct tagWINDOWCONTEXT {
   LPOLEINPLACEFRAME     pFrame;
   LPOLEINPLACEUIWINDOW  pDoc;
   RECT                  rcPosRect;
   RECT                  rcClipRect;
   OLEINPLACEFRAMEINFO   fiFrameInfo;
} WINDOWCONTEXT, *LPWINDOWCONTEXT;


/////////////////////////////////////////////////////////////////////////////
//
// Since E_IViewObject::GetAdvise method has 3 [out] parameters :~(
// me must aggregate it in the single data structure to interface with Eiffel.
//

typedef struct tagADVISEINFO {
   DWORD         dwAspect;
   DWORD         advf;
   IAdviseSink  *pAdvSink;
} ADVISEINFO, *LPADVISEINFO;

/////////////////////////////////////////////////////////////////////////////
//
// Since Eiffel restriction to return interface pointer in [out] parameter
// in [Get|Create|Open|Enum]... methods :-( we must remember the status of
// each operation, wich return interface pointer in [out] parameter
// in this global variable. Corresponding Eiffel object
// can obtain this value via 'eole2_last_scode' function.
//

extern     HRESULT       g_hrStatusCode;
extern "C" EIF_INTEGER   eole2_last_scode (void);

/////////////////////////////////////////////////////////////////////////////
//
// HELPER and CONVERSION functions
//

extern "C" void          EiffelStringToGuid (EIF_POINTER str, GUID* guid);
extern "C" char*         GuidToCString (REFIID guid);
extern "C" EIF_REFERENCE GuidToEiffelString (REFIID guid);
extern "C" LPOLESTR      Eif2OleString (EIF_POINTER eifString);
extern "C" EIF_REFERENCE Ole2EifString (LPCOLESTR oleString);
extern "C" EIF_REFERENCE EStringFromCString (char* cstring);
extern "C" void          Ole2CString (LPCOLESTR oleString, char **result);


/////////////////////////////////////////////////////////////////////////////
//
// Ole control window class creation functions
//

extern     void          RegisterEiffelControlClass (void);
extern     void          UnregisterEiffelControlClass (void);
extern     LPCTSTR       GetEocxWndClass (void);
extern     HINSTANCE     GetEocxInstance (void);


/////////////////////////////////////////////////////////////////////////////
//
// Following functions are the only functions that actually call Eiffel code.
//

extern EIF_REFERENCE  eiffelOcxModule;
extern EIF_REFERENCE  eoleOcxDisp;

extern EIF_FN_INT     Ocxdisp_ModuleGetStatusCode;
extern EIF_PROC       Ocxdisp_ModuleSetStatusCode;
extern EIF_PROC       Ocxdisp_ModuleRegister;
extern EIF_PROC       Ocxdisp_ModuleUnregister;
extern EIF_FN_BOOL    Ocxdisp_ModuleCanUnloadNow;
extern EIF_FN_POINTER Ocxdisp_ModuleGetClassFactory;

extern EIF_FN_INT     Ocxdisp_UnknownGetStatusCode;
extern EIF_PROC       Ocxdisp_UnknownSetStatusCode;
extern EIF_FN_POINTER Ocxdisp_UnknownQueryInterface;
extern EIF_FN_INT     Ocxdisp_UnknownAddRef;
extern EIF_FN_INT     Ocxdisp_UnknownRelease;
extern EIF_FN_INT     Ocxdisp_UnknownReferenceCounter;

extern EIF_FN_POINTER Ocxdisp_ClassFactoryCreateInstance;
extern EIF_PROC       Ocxdisp_ClassFactoryLockServer;

extern EIF_PROC       Ocxdisp_OleObjSetClientSite;
extern EIF_FN_POINTER Ocxdisp_OleObjGetClientSite;
extern EIF_PROC       Ocxdisp_OleObjSetHostNames;
extern EIF_PROC       Ocxdisp_OleObjClose;
extern EIF_PROC       Ocxdisp_OleObjSetMoniker;
extern EIF_FN_POINTER Ocxdisp_OleObjGetMoniker;
extern EIF_PROC       Ocxdisp_OleObjInitFromData;
extern EIF_FN_POINTER Ocxdisp_OleObjGetClipboardData;
extern EIF_PROC       Ocxdisp_OleObjDoVerb;
extern EIF_FN_POINTER Ocxdisp_OleObjEnumVerbs;
extern EIF_PROC       Ocxdisp_OleObjUpdate;
extern EIF_PROC       Ocxdisp_OleObjIsUpToDate;
extern EIF_FN_POINTER Ocxdisp_OleObjGetUserClassId;
extern EIF_FN_POINTER Ocxdisp_OleObjGetUserType;
extern EIF_PROC       Ocxdisp_OleObjSetExtent;
extern EIF_PROC       Ocxdisp_OleObjGetExtent;
extern EIF_FN_INT     Ocxdisp_OleObjAdvise;
extern EIF_PROC       Ocxdisp_OleObjUnadvise;
extern EIF_FN_POINTER Ocxdisp_OleObjEnumAdvise;
extern EIF_FN_INT     Ocxdisp_OleObjGetMiscStatus;
extern EIF_PROC       Ocxdisp_OleObjSetColorScheme;

/////////////////////////////////////////////////////////////////////////////
//
// IPersist
//

extern EIF_FN_POINTER Ocxdisp_PersistGetClassId;

/////////////////////////////////////////////////////////////////////////////
//
// IPersistStorage
//

extern EIF_PROC       Ocxdisp_PersistStgIsDirtyStg;
extern EIF_PROC       Ocxdisp_PersistStgInitNewStg;
extern EIF_PROC       Ocxdisp_PersistStgLoadStg;
extern EIF_PROC       Ocxdisp_PersistStgSaveStg;
extern EIF_PROC       Ocxdisp_PersistStgSaveCompleted;
extern EIF_PROC       Ocxdisp_PersistStgHandsOffStorage;

/////////////////////////////////////////////////////////////////////////////
//
// IViewObject(2)
//

extern EIF_PROC       Ocxdisp_ViewDraw;
extern EIF_FN_POINTER Ocxdisp_ViewGetColorSet;
extern EIF_FN_INT     Ocxdisp_ViewFreeze;
extern EIF_PROC       Ocxdisp_ViewUnfreeze;
extern EIF_PROC       Ocxdisp_ViewSetAdvise;
extern EIF_PROC       Ocxdisp_ViewGetAdvise;
extern EIF_PROC       Ocxdisp_ViewGetExtent;

/////////////////////////////////////////////////////////////////////////////
//
// IRunnableObject
//

extern EIF_FN_POINTER Ocxdisp_RunnableGetRunningClass;
extern EIF_PROC       Ocxdisp_RunnableRun;
extern EIF_FN_BOOL    Ocxdisp_RunnableIsRunning;
extern EIF_PROC       Ocxdisp_RunnableLockRunning;
extern EIF_PROC       Ocxdisp_RunnableSetContainedObject;

/////////////////////////////////////////////////////////////////////////////
//
// IOleControl
//

extern EIF_PROC       Ocxdisp_ControlGetControlInfo;
extern EIF_PROC       Ocxdisp_ControlOnMnemonic;
extern EIF_PROC       Ocxdisp_ControlOnAmbientPropertyChange;
extern EIF_PROC       Ocxdisp_ControlFreezeEvents;

/////////////////////////////////////////////////////////////////////////////
//
// IOleWindow
//

extern EIF_FN_INT     Ocxdisp_OleWndGetWindow;
extern EIF_PROC       Ocxdisp_OleWndContextSensitiveHelp;

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceObject
//

extern EIF_PROC       Ocxdisp_IpoInPlaceDeactivate;
extern EIF_PROC       Ocxdisp_IpoUIDeactivate;
extern EIF_PROC       Ocxdisp_IpoSetObjectRects;
extern EIF_PROC       Ocxdisp_IpoReactivateAndUndo;

/////////////////////////////////////////////////////////////////////////////
//
// IParseDisplayName
//

extern EIF_FN_POINTER Ocxdisp_PdnParseDisplayName;

/////////////////////////////////////////////////////////////////////////////
//
// IOleContainer
//

extern EIF_FN_POINTER Ocxdisp_OleContainerEnumObjects;
extern EIF_PROC       Ocxdisp_OleContainerLockContainer;

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceUIWindow
//

extern EIF_FN_POINTER Ocxdisp_OleInPlaceUIWindowGetBorder;
extern EIF_PROC       Ocxdisp_OleInPlaceUIWindowRequestBorderSpace;
extern EIF_PROC       Ocxdisp_OleInPlaceUIWindowSetBorderSpace;
extern EIF_PROC       Ocxdisp_OleInPlaceUIWindowSetActiveObject;

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceFrame
//

extern EIF_PROC       Ocxdisp_OleInPlaceFrameInsertMenus;
extern EIF_PROC       Ocxdisp_OleInPlaceFrameSetMenu;
extern EIF_PROC       Ocxdisp_OleInPlaceFrameRemoveMenus;
extern EIF_PROC       Ocxdisp_OleInPlaceFrameSetStatusText;
extern EIF_PROC       Ocxdisp_OleInPlaceFrameEnableModeless;
extern EIF_PROC       Ocxdisp_OleInPlaceFrameTranslateAccelerator;


/////////////////////////////////////////////////////////////////////////////
//
// IOleClientSite
//

extern EIF_PROC       Ocxdisp_OleClientSiteSaveObject;
extern EIF_FN_POINTER Ocxdisp_OleClientSiteGetMoniker;
extern EIF_FN_POINTER Ocxdisp_OleClientSiteGetContainer;
extern EIF_PROC       Ocxdisp_OleClientSiteShowObject;
extern EIF_PROC       Ocxdisp_OleClientSiteOnShowWindow;
extern EIF_PROC       Ocxdisp_OleClientSiteRequestNewObjectLayout;

/////////////////////////////////////////////////////////////////////////////
//
// IOleInPlaceSite
//

extern EIF_PROC       Ocxdisp_OleInPlaceSiteCanInPlaceActivate;
extern EIF_PROC       Ocxdisp_OleInPlaceSiteOnInPlaceActivate;
extern EIF_PROC       Ocxdisp_OleInPlaceSiteOnUIActivate;
extern EIF_FN_POINTER Ocxdisp_OleInPlaceSiteGetWindowContext;
extern EIF_PROC       Ocxdisp_OleInPlaceSiteScroll;
extern EIF_PROC       Ocxdisp_OleInPlaceSiteOnUIDeactivate;
extern EIF_PROC       Ocxdisp_OleInPlaceSiteOnInPlaceDeactivate;
extern EIF_PROC       Ocxdisp_OleInPlaceSiteDiscardUndoState;
extern EIF_PROC       Ocxdisp_OleInPlaceSiteDeactivateAndUndo;
extern EIF_PROC       Ocxdisp_OleInPlaceSiteOnPosRectChange;

/////////////////////////////////////////////////////////////////////////////
//
// IOleControlSite
//

extern EIF_PROC       Ocxdisp_OleControlSiteOnControlInfoChanged;
extern EIF_PROC       Ocxdisp_OleControlSiteLockInPlaceActivate;
extern EIF_FN_POINTER Ocxdisp_OleControlSiteGetExtendedControl;
extern EIF_PROC       Ocxdisp_OleControlSiteTransformCoords;
extern EIF_PROC       Ocxdisp_OleControlSiteTranslateAccelerator;
extern EIF_PROC       Ocxdisp_OleControlSiteOnFocus;
extern EIF_PROC       Ocxdisp_OleControlSiteShowPropertyFrame;

/////////////////////////////////////////////////////////////////////////////
//
// IPropertyNotifySink
//

extern EIF_PROC       Ocxdisp_PropertyNotifySinkOnChanged;
extern EIF_PROC       Ocxdisp_PropertyNotifySinkOnRequestEdit;

/////////////////////////////////////////////////////////////////////////////
//
// IAdviseSink
//

extern EIF_PROC       Ocxdisp_AdviseSinkOnDataChange;
extern EIF_PROC       Ocxdisp_AdviseSinkOnViewChange;
extern EIF_PROC       Ocxdisp_AdviseSinkOnRename;
extern EIF_PROC       Ocxdisp_AdviseSinkOnSave;
extern EIF_PROC       Ocxdisp_AdviseSinkOnClose;

/////////////////////////////////////////////////////////////////////////////
//
// IDispatch
//

extern EIF_FN_INT     Ocxdisp_DispatchGetTypeInfoCount;
extern EIF_FN_POINTER Ocxdisp_DispatchGetTypeInfo;
extern EIF_FN_POINTER Ocxdisp_DispatchGetIdsOfNames;
extern EIF_PROC       Ocxdisp_DispatchInvoke;

////////////////////////////////////////////////////////////////////////////
//
// IFont
//

extern EIF_FN_POINTER Ocxdisp_FontGetName;
extern EIF_PROC       Ocxdisp_FontPutName;
extern EIF_FN_POINTER Ocxdisp_FontGetSize;
extern EIF_PROC       Ocxdisp_FontPutSize;
extern EIF_FN_BOOL    Ocxdisp_FontGetBold;
extern EIF_PROC       Ocxdisp_FontPutBold;
extern EIF_FN_BOOL    Ocxdisp_FontGetItalic;
extern EIF_PROC       Ocxdisp_FontPutItalic;
extern EIF_FN_BOOL    Ocxdisp_FontGetUnderline;
extern EIF_PROC       Ocxdisp_FontPutUnderline;
extern EIF_FN_BOOL    Ocxdisp_FontGetStrikethrough;
extern EIF_PROC       Ocxdisp_FontPutStrikethrough;
extern EIF_FN_INT     Ocxdisp_FontGetWeight;
extern EIF_PROC       Ocxdisp_FontPutWeight;
extern EIF_FN_INT     Ocxdisp_FontGetCharset;
extern EIF_PROC       Ocxdisp_FontPutCharset;
extern EIF_FN_INT     Ocxdisp_FontGetHFont;
extern EIF_FN_POINTER Ocxdisp_FontClone;
extern EIF_PROC       Ocxdisp_FontIsEqual;
extern EIF_PROC       Ocxdisp_FontSetRatio;
extern EIF_FN_POINTER Ocxdisp_FontQueryTextMetrics;
extern EIF_PROC       Ocxdisp_FontAddRefHfont;
extern EIF_PROC       Ocxdisp_FontReleaseHfont;
extern EIF_PROC       Ocxdisp_FontSetHdc;

////////////////////////////////////////////////////////////////////////////
//
// IFontDisp
//

extern EIF_PROC       Ocxdisp_FontDispInvoke;

////////////////////////////////////////////////////////////////////////////
//
// IPicture
//

extern EIF_FN_INT     Ocxdisp_PictureGetHandle;
extern EIF_FN_INT     Ocxdisp_PictureGetHpal;
extern EIF_FN_INT     Ocxdisp_PictureGetType;
extern EIF_FN_INT     Ocxdisp_PictureGetWidth;
extern EIF_FN_INT     Ocxdisp_PictureGetHeight;
extern EIF_FN_INT     Ocxdisp_PictureGetCurDc;
extern EIF_FN_BOOL    Ocxdisp_PictureGetKeepOriginalFormat;
extern EIF_FN_INT     Ocxdisp_PictureGetAttributes;
extern EIF_PROC       Ocxdisp_PictureRender;
extern EIF_PROC       Ocxdisp_PictureSetHpal;
extern EIF_FN_POINTER Ocxdisp_PictureSelectPicture;
extern EIF_PROC       Ocxdisp_PicturePutKeepOriginalFormat;
extern EIF_PROC       Ocxdisp_PicturePictureChanged;
extern EIF_FN_INT     Ocxdisp_PictureSaveAsFile;
	
////////////////////////////////////////////////////////////////////////////
//
// IPictureDisp
//

extern EIF_PROC       Ocxdisp_PictureDispInvoke;

/////////////////////////////////////////////////////////////////////////////
//
// IProvideClassInfo
//

extern EIF_FN_POINTER Ocxdisp_ProvideClassInfoGetClassInfo;

/////////////////////////////////////////////////////////////////////////////
//
// IConnectionPoint
//

extern EIF_FN_INT     Ocxdisp_ConnectionPointAdvise;
extern EIF_PROC       Ocxdisp_ConnectionPointUnadvise;
extern EIF_FN_POINTER Ocxdisp_ConnectionPointGetConnectionInterface;
extern EIF_FN_POINTER Ocxdisp_ConnectionPointGetConnectionPointContainer;
extern EIF_FN_POINTER Ocxdisp_ConnectionPointEnumConnections;

/////////////////////////////////////////////////////////////////////////////
//
// IConnectionPointContainer
//

extern EIF_FN_POINTER Ocxdisp_ConnectionPointContainerEnumConnectionPoints;
extern EIF_FN_POINTER Ocxdisp_ConnectionPointContainerFindConnectionPoint;

/////////////////////////////////////////////////////////////////////////////
//
// IEnumUnknown
//

extern EIF_FN_POINTER	Ocxdisp_EnumUnknownNext;
extern EIF_PROC		    Ocxdisp_EnumUnknownSkip;
extern EIF_PROC		    Ocxdisp_EnumUnknownReset;
extern EIF_FN_POINTER   Ocxdisp_EnumUnknownClone;

/////////////////////////////////////////////////////////////////////////////
//
// IEnumConnPoint
//

extern EIF_FN_POINTER Ocxdisp_EnumConnPointNext;
extern EIF_PROC       Ocxdisp_EnumConnPointSkip;
extern EIF_PROC       Ocxdisp_EnumConnPointReset;
extern EIF_FN_POINTER Ocxdisp_EnumConnPointClone;

/////////////////////////////////////////////////////////////////////////////
//
// IEnumConnections
//

extern EIF_FN_POINTER Ocxdisp_EnumConnectionsNext;
extern EIF_PROC       Ocxdisp_EnumConnectionsSkip;
extern EIF_PROC       Ocxdisp_EnumConnectionsReset;
extern EIF_FN_POINTER Ocxdisp_EnumConnectionsClone;

///////////////////////////////////////////////////////////////////////////////
//
// ITypeInfo
//

extern EIF_FN_POINTER Ocxdisp_TypeInfoGetTypeAttr;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetTypeComp;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetFuncDesc;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetVarDesc;
extern EIF_FN_INT     Ocxdisp_TypeInfoGetRefTypeOfImplType;
extern EIF_FN_INT     Ocxdisp_TypeInfoGetImplTypeFlags;
extern EIF_FN_POINTER Ocxdisp_DispatchGetIDsOfNames;
extern EIF_PROC       Ocxdisp_TypeInfoInvoke;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetDocumentation;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetDllEntry;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetRefTypeInfo;
extern EIF_FN_POINTER Ocxdisp_TypeInfoAddressOfMember;
extern EIF_FN_POINTER Ocxdisp_TypeInfoCreateInstance;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetMops;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetContainingTypeLib;
extern EIF_PROC       Ocxdisp_TypeInfoReleaseTypeAttr;
extern EIF_PROC       Ocxdisp_TypeInfoReleaseFuncDesc;
extern EIF_PROC       Ocxdisp_TypeInfoReleaseVarDesc;
extern EIF_FN_POINTER Ocxdisp_TypeInfoGetNames;

#endif // !__OCXCECIL_H_INC__

/////// END OF FILE /////////////////////////////////////////////////////////
