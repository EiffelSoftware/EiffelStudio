/////////////////////////////////////////////////////////////////////////////
//
//     OCXCECIL.CPP   Copyright (c) 1996 by SiG Computer
//
//     Version:       0.00
//
//     Eiffel OLE 2 Library.
//
//     OLE2->C->Eiffel call support
//
//     Functions:
//       eole2_setup_ocx_dispatcher
//       eole2_output_debug_string
//       GuidToCString
//       GuidToEiffelString
//       Eif2OleString
//       Ole2EifString
//       Ole2CString
//       EStringFromCString
//     Globals:
//
//     Notes:
//       None.
//

#include "eifole.h"
#include "eif_eiffel.h"

EIF_REFERENCE eiffelOcxModule;
EIF_REFERENCE eoleOcxDisp;

// Dispatcher type identifier

static EIF_TYPE_ID eocdTypeId;

// The following function pointers provides access to methods of the
// EOLE_CALL_DISPATCHER - the Eiffel site of callbacks implementation.
// IMPORTANT!!!
// All routing from OLE to Eiffel passes through EOLE_CALL_DISPATCHER.
//

// OcxModule

EIF_FN_INT     Ocxdisp_ModuleGetStatusCode;
EIF_PROC       Ocxdisp_ModuleSetStatusCode;
EIF_PROC       Ocxdisp_ModuleRegister;
EIF_PROC       Ocxdisp_ModuleUnregister;
EIF_FN_BOOL    Ocxdisp_ModuleCanUnloadNow;
EIF_FN_POINTER Ocxdisp_ModuleGetClassFactory;

// IUnknown

EIF_FN_INT     Ocxdisp_UnknownGetStatusCode;
EIF_PROC       Ocxdisp_UnknownSetStatusCode;
EIF_FN_POINTER Ocxdisp_UnknownQueryInterface;
EIF_FN_INT     Ocxdisp_UnknownAddRef;
EIF_FN_INT     Ocxdisp_UnknownRelease;
EIF_FN_INT     Ocxdisp_UnknownReferenceCounter;

// IClassFactory

EIF_FN_POINTER Ocxdisp_ClassFactoryCreateInstance;
EIF_PROC       Ocxdisp_ClassFactoryLockServer;

// IOleObject

EIF_PROC       Ocxdisp_OleObjSetClientSite;
EIF_FN_POINTER Ocxdisp_OleObjGetClientSite;
EIF_PROC       Ocxdisp_OleObjSetHostNames;
EIF_PROC       Ocxdisp_OleObjClose;
EIF_PROC       Ocxdisp_OleObjSetMoniker;
EIF_FN_POINTER Ocxdisp_OleObjGetMoniker;
EIF_PROC       Ocxdisp_OleObjInitFromData;
EIF_FN_POINTER Ocxdisp_OleObjGetClipboardData;
EIF_PROC       Ocxdisp_OleObjDoVerb;
EIF_FN_POINTER Ocxdisp_OleObjEnumVerbs;
EIF_PROC       Ocxdisp_OleObjUpdate;
EIF_PROC       Ocxdisp_OleObjIsUpToDate;
EIF_FN_POINTER Ocxdisp_OleObjGetUserClassId;
EIF_FN_POINTER Ocxdisp_OleObjGetUserType;
EIF_PROC       Ocxdisp_OleObjSetExtent;
EIF_PROC       Ocxdisp_OleObjGetExtent;
EIF_FN_INT     Ocxdisp_OleObjAdvise;
EIF_PROC       Ocxdisp_OleObjUnadvise;
EIF_FN_POINTER Ocxdisp_OleObjEnumAdvise;
EIF_FN_INT     Ocxdisp_OleObjGetMiscStatus;
EIF_PROC       Ocxdisp_OleObjSetColorScheme;

// IPersist

EIF_FN_POINTER Ocxdisp_PersistGetClassId;

// IPersistStorage

EIF_PROC       Ocxdisp_PersistStgIsDirtyStg;
EIF_PROC       Ocxdisp_PersistStgInitNewStg;
EIF_PROC       Ocxdisp_PersistStgLoadStg;
EIF_PROC       Ocxdisp_PersistStgSaveStg;
EIF_PROC       Ocxdisp_PersistStgSaveCompleted;
EIF_PROC       Ocxdisp_PersistStgHandsOffStorage;

// IViewObject(2)

EIF_PROC       Ocxdisp_ViewDraw;
EIF_FN_POINTER Ocxdisp_ViewGetColorSet;
EIF_FN_INT     Ocxdisp_ViewFreeze;
EIF_PROC       Ocxdisp_ViewUnfreeze;
EIF_PROC       Ocxdisp_ViewSetAdvise;
EIF_PROC       Ocxdisp_ViewGetAdvise;
EIF_PROC       Ocxdisp_ViewGetExtent;

// IRunnableObject

EIF_FN_POINTER Ocxdisp_RunnableGetRunningClass;
EIF_PROC       Ocxdisp_RunnableRun;
EIF_FN_BOOL    Ocxdisp_RunnableIsRunning;
EIF_PROC       Ocxdisp_RunnableLockRunning;
EIF_PROC       Ocxdisp_RunnableSetContainedObject;

// IOleControl

EIF_PROC       Ocxdisp_ControlGetControlInfo;
EIF_PROC       Ocxdisp_ControlOnMnemonic;
EIF_PROC       Ocxdisp_ControlOnAmbientPropertyChange;
EIF_PROC       Ocxdisp_ControlFreezeEvents;

// IOleWindow

EIF_FN_INT     Ocxdisp_OleWndGetWindow;
EIF_PROC       Ocxdisp_OleWndContextSensitiveHelp;

// IOleInPlaceObject

EIF_PROC       Ocxdisp_IpoInPlaceDeactivate;
EIF_PROC       Ocxdisp_IpoUIDeactivate;
EIF_PROC       Ocxdisp_IpoSetObjectRects;
EIF_PROC       Ocxdisp_IpoReactivateAndUndo;

// IOleInPlaceActiveObject

EIF_PROC        Ocxdisp_IpaoTranslateActivator;
EIF_PROC        Ocxdisp_IpaoOnFrameWindowActivate;
EIF_PROC        Ocxdisp_IpaoOnDocWindowActivate;
EIF_PROC        Ocxdisp_IpaoResizeBorder;
EIF_PROC        Ocxdisp_IpaoEnableModeless;

// IParseDisplayName

EIF_FN_POINTER Ocxdisp_PdnParseDisplayName;

// IOleContainer

EIF_FN_POINTER Ocxdisp_OleContainerEnumObjects;
EIF_PROC       Ocxdisp_OleContainerLockContainer;

// IOleInPlaceUIWindow

EIF_FN_POINTER Ocxdisp_OleInPlaceUIWindowGetBorder;
EIF_PROC       Ocxdisp_OleInPlaceUIWindowRequestBorderSpace;
EIF_PROC       Ocxdisp_OleInPlaceUIWindowSetBorderSpace;
EIF_PROC       Ocxdisp_OleInPlaceUIWindowSetActiveObject;

// IOleInPlaceFrame

EIF_PROC       Ocxdisp_OleInPlaceFrameInsertMenus;
EIF_PROC       Ocxdisp_OleInPlaceFrameSetMenu;
EIF_PROC       Ocxdisp_OleInPlaceFrameRemoveMenus;
EIF_PROC       Ocxdisp_OleInPlaceFrameSetStatusText;
EIF_PROC       Ocxdisp_OleInPlaceFrameEnableModeless;
EIF_PROC       Ocxdisp_OleInPlaceFrameTranslateAccelerator;


// IOleClientSite

EIF_PROC       Ocxdisp_OleClientSiteSaveObject;
EIF_FN_POINTER Ocxdisp_OleClientSiteGetMoniker;
EIF_FN_POINTER Ocxdisp_OleClientSiteGetContainer;
EIF_PROC       Ocxdisp_OleClientSiteShowObject;
EIF_PROC       Ocxdisp_OleClientSiteOnShowWindow;
EIF_PROC       Ocxdisp_OleClientSiteRequestNewObjectLayout;

// IOleInPlaceSite

EIF_PROC       Ocxdisp_OleInPlaceSiteCanInPlaceActivate;
EIF_PROC       Ocxdisp_OleInPlaceSiteOnInPlaceActivate;
EIF_PROC       Ocxdisp_OleInPlaceSiteOnUIActivate;
EIF_FN_POINTER Ocxdisp_OleInPlaceSiteGetWindowContext;
EIF_PROC       Ocxdisp_OleInPlaceSiteScroll;
EIF_PROC       Ocxdisp_OleInPlaceSiteOnUIDeactivate;
EIF_PROC       Ocxdisp_OleInPlaceSiteOnInPlaceDeactivate;
EIF_PROC       Ocxdisp_OleInPlaceSiteDiscardUndoState;
EIF_PROC       Ocxdisp_OleInPlaceSiteDeactivateAndUndo;
EIF_PROC       Ocxdisp_OleInPlaceSiteOnPosRectChange;

// IOleControlSite

EIF_PROC       Ocxdisp_OleControlSiteOnControlInfoChanged;
EIF_PROC       Ocxdisp_OleControlSiteLockInPlaceActivate;
EIF_FN_POINTER Ocxdisp_OleControlSiteGetExtendedControl;
EIF_PROC       Ocxdisp_OleControlSiteTransformCoords;
EIF_PROC       Ocxdisp_OleControlSiteTranslateAccelerator;
EIF_PROC       Ocxdisp_OleControlSiteOnFocus;
EIF_PROC       Ocxdisp_OleControlSiteShowPropertyFrame;

// IPropertyNotifySink

EIF_PROC       Ocxdisp_PropertyNotifySinkOnChanged;
EIF_PROC       Ocxdisp_PropertyNotifySinkOnRequestEdit;

// IAdviseSink

EIF_PROC       Ocxdisp_AdviseSinkOnDataChange;
EIF_PROC       Ocxdisp_AdviseSinkOnViewChange;
EIF_PROC       Ocxdisp_AdviseSinkOnRename;
EIF_PROC       Ocxdisp_AdviseSinkOnSave;
EIF_PROC       Ocxdisp_AdviseSinkOnClose;

// IDispatch

EIF_FN_INT     Ocxdisp_DispatchGetTypeInfoCount;
EIF_FN_POINTER Ocxdisp_DispatchGetTypeInfo;
EIF_FN_POINTER Ocxdisp_DispatchGetIdsOfNames;
EIF_PROC       Ocxdisp_DispatchInvoke;

// IFont

EIF_FN_POINTER Ocxdisp_FontGetName;
EIF_PROC       Ocxdisp_FontPutName;
EIF_FN_POINTER Ocxdisp_FontGetSize;
EIF_PROC       Ocxdisp_FontPutSize;
EIF_FN_BOOL    Ocxdisp_FontGetBold;
EIF_PROC       Ocxdisp_FontPutBold;
EIF_FN_BOOL    Ocxdisp_FontGetItalic;
EIF_PROC       Ocxdisp_FontPutItalic;
EIF_FN_BOOL    Ocxdisp_FontGetUnderline;
EIF_PROC       Ocxdisp_FontPutUnderline;
EIF_FN_BOOL    Ocxdisp_FontGetStrikethrough;
EIF_PROC       Ocxdisp_FontPutStrikethrough;
EIF_FN_INT     Ocxdisp_FontGetWeight;
EIF_PROC       Ocxdisp_FontPutWeight;
EIF_FN_INT     Ocxdisp_FontGetCharset;
EIF_PROC       Ocxdisp_FontPutCharset;
EIF_FN_INT     Ocxdisp_FontGetHFont;
EIF_FN_POINTER Ocxdisp_FontClone;
EIF_PROC       Ocxdisp_FontIsEqual;
EIF_PROC       Ocxdisp_FontSetRatio;
EIF_FN_POINTER Ocxdisp_FontQueryTextMetrics;
EIF_PROC       Ocxdisp_FontAddRefHfont;
EIF_PROC       Ocxdisp_FontReleaseHfont;
EIF_PROC       Ocxdisp_FontSetHdc;

// IFontDisp

EIF_PROC       Ocxdisp_FontDispInvoke;

// IPicture

EIF_FN_INT     Ocxdisp_PictureGetHandle;
EIF_FN_INT     Ocxdisp_PictureGetHpal;
EIF_FN_INT     Ocxdisp_PictureGetType;
EIF_FN_INT     Ocxdisp_PictureGetWidth;
EIF_FN_INT     Ocxdisp_PictureGetHeight;
EIF_FN_INT     Ocxdisp_PictureGetCurDc;
EIF_FN_BOOL    Ocxdisp_PictureGetKeepOriginalFormat;
EIF_FN_INT     Ocxdisp_PictureGetAttributes;
EIF_PROC       Ocxdisp_PictureRender;
EIF_PROC       Ocxdisp_PictureSetHpal;
EIF_FN_POINTER Ocxdisp_PictureSelectPicture;
EIF_PROC       Ocxdisp_PicturePutKeepOriginalFormat;
EIF_PROC       Ocxdisp_PicturePictureChanged;
EIF_FN_INT     Ocxdisp_PictureSaveAsFile;
	
// IPictureDisp

EIF_PROC       Ocxdisp_PictureDispInvoke;

// IProvideClassInfo

EIF_FN_POINTER Ocxdisp_ProvideClassInfoGetClassInfo;

// IConnectionPointContainer

EIF_FN_POINTER Ocxdisp_ConnectionPointContainerEnumConnectionPoints;
EIF_FN_POINTER Ocxdisp_ConnectionPointContainerFindConnectionPoint;

// IConnectionPoint

EIF_FN_INT 		Ocxdisp_ConnectionPointAdvise;
EIF_PROC 		Ocxdisp_ConnectionPointUnadvise;
EIF_FN_POINTER 	Ocxdisp_ConnectionPointGetConnectionInterface;
EIF_FN_POINTER 	Ocxdisp_ConnectionPointGetConnectionPointContainer;
EIF_FN_POINTER 	Ocxdisp_ConnectionPointEnumConnections;

// IEnumConnectionPoints

EIF_FN_POINTER Ocxdisp_EnumConnPointNext;
EIF_PROC Ocxdisp_EnumConnPointSkip;
EIF_PROC Ocxdisp_EnumConnPointReset;
EIF_FN_POINTER Ocxdisp_EnumConnPointClone;

// IEnumConnections

EIF_FN_POINTER Ocxdisp_EnumConnectionsNext;
EIF_PROC Ocxdisp_EnumConnectionsSkip;
EIF_PROC Ocxdisp_EnumConnectionsReset;
EIF_FN_POINTER Ocxdisp_EnumConnectionsClone;

// IEnumUnknown

EIF_FN_POINTER	Ocxdisp_EnumUnknownNext;
EIF_PROC		Ocxdisp_EnumUnknownSkip;
EIF_PROC		Ocxdisp_EnumUnknownReset;
EIF_FN_POINTER Ocxdisp_EnumUnknownClone;

// ITypeInfo

EIF_FN_POINTER Ocxdisp_TypeInfoGetTypeAttr;
EIF_FN_POINTER Ocxdisp_TypeInfoGetTypeComp;
EIF_FN_POINTER Ocxdisp_TypeInfoGetFuncDesc;
EIF_FN_POINTER Ocxdisp_TypeInfoGetVarDesc;
EIF_FN_INT     Ocxdisp_TypeInfoGetRefTypeOfImplType;
EIF_FN_INT     Ocxdisp_TypeInfoGetImplTypeFlags;
EIF_FN_POINTER Ocxdisp_TypeInfoGetIDsOfNames;
EIF_PROC       Ocxdisp_TypeInfoInvoke;
EIF_FN_POINTER Ocxdisp_TypeInfoGetDocumentation;
EIF_FN_POINTER Ocxdisp_TypeInfoGetDllEntry;
EIF_FN_POINTER Ocxdisp_TypeInfoGetRefTypeInfo;
EIF_FN_POINTER Ocxdisp_TypeInfoAddressOfMember;
EIF_FN_POINTER Ocxdisp_TypeInfoCreateInstance;
EIF_FN_POINTER Ocxdisp_TypeInfoGetMops;
EIF_FN_POINTER Ocxdisp_TypeInfoGetContainingTypeLib;
EIF_PROC       Ocxdisp_TypeInfoReleaseTypeAttr;
EIF_PROC       Ocxdisp_TypeInfoReleaseFuncDesc;
EIF_PROC       Ocxdisp_TypeInfoReleaseVarDesc;
EIF_FN_POINTER Ocxdisp_TypeInfoGetNames;

/*---------------------------------------------------------------------------*/

//extern "C" void eole2_setup_ocx_dispatcher( EIF_REFERENCE ocxModule, Useless for Eiffelcom_cfa
//        EIF_REFERENCE oleCallDispatcher )
extern "C" void eole2_setup_ocx_dispatcher (EIF_REFERENCE oleCallDispatcher)
{
    // Setup global references to main OCX objects
//    eiffelOcxModule = ocxModule;	Useless for EIffelCOM_CFA (no module yet)
    eoleOcxDisp = henter (oleCallDispatcher);

    // Setup the dispatcher type id
    eocdTypeId = eif_type_id( "EOLE_CALL_DISPATCHER" );

    // Retrieve the pointers to dispatcher functions
    //

    // EOLE_OCX_MODULE dispatching functions -- No Module for CFA version

//    Ocxdisp_ModuleGetStatusCode =
//            eif_fn_int( "on_ocx_module_status_code", eocdTypeId );
//    Ocxdisp_ModuleSetStatusCode =
//            eif_proc( "on_ocx_module_set_status_code", eocdTypeId );
//    Ocxdisp_ModuleRegister =
//            eif_proc( "on_ocx_module_register", eocdTypeId );
//    Ocxdisp_ModuleUnregister =
//            eif_proc( "on_ocx_module_unregister", eocdTypeId );
//    Ocxdisp_ModuleCanUnloadNow =
//            eif_fn_bool( "on_ocx_module_can_unload_now", eocdTypeId );
//    Ocxdisp_ModuleGetClassFactory =
//            eif_fn_pointer( "on_ocx_module_get_class_factory", eocdTypeId );

    // EOLE_UNKNOWN dispatching functions

    Ocxdisp_UnknownGetStatusCode =
            eif_fn_int( "on_unknown_status_code", eocdTypeId );
    Ocxdisp_UnknownSetStatusCode =
            eif_proc( "on_unknown_set_last_hresult", eocdTypeId );
    Ocxdisp_UnknownQueryInterface =
            eif_fn_pointer( "on_unknown_query_interface", eocdTypeId );
    Ocxdisp_UnknownAddRef =
            eif_fn_int( "on_unknown_add_ref", eocdTypeId );
    Ocxdisp_UnknownRelease =
            eif_fn_int( "on_unknown_release", eocdTypeId );
	Ocxdisp_UnknownReferenceCounter =
			eif_fn_int( "on_unknown_reference_counter", eocdTypeId );

	// EOLE_ENUM_UNKNOWN dispatching functions

	Ocxdisp_EnumUnknownNext =
            eif_fn_pointer( "on_enum_unknown_next", eocdTypeId );
	Ocxdisp_EnumUnknownSkip =
            eif_proc( "on_enum_unknown_skip", eocdTypeId );
	Ocxdisp_EnumUnknownReset =
            eif_proc( "on_enum_unknown_reset", eocdTypeId );
	Ocxdisp_EnumUnknownClone =
            eif_fn_pointer( "on_enum_unknown_clone", eocdTypeId );

	// EOLE_ENUM_CONNECTION_POINTS dispatching functions

	Ocxdisp_EnumConnPointNext =
            eif_fn_pointer( "on_enum_connection_points_next", eocdTypeId );
	Ocxdisp_EnumConnPointSkip =
            eif_proc( "on_enum_connection_points_skip", eocdTypeId );
	Ocxdisp_EnumConnPointReset =
            eif_proc( "on_enum_connection_points_reset", eocdTypeId );
	Ocxdisp_EnumConnPointClone =
            eif_fn_pointer( "on_enum_connection_points_clone", eocdTypeId );

	// EOLE_ENUM_CONNECTIONS dispatching functions

	Ocxdisp_EnumConnectionsNext =
            eif_fn_pointer( "on_enum_connections_next", eocdTypeId );
	Ocxdisp_EnumConnectionsSkip =
            eif_proc( "on_enum_connections_skip", eocdTypeId );
	Ocxdisp_EnumConnectionsReset =
            eif_proc( "on_enum_connections_reset", eocdTypeId );
	Ocxdisp_EnumConnectionsClone =
            eif_fn_pointer( "on_enum_connections_clone", eocdTypeId );

    // EOLE_CLASS_FACTORY dispatching functions

    Ocxdisp_ClassFactoryCreateInstance =
            eif_fn_pointer( "on_clsfact_create_instance", eocdTypeId );
    Ocxdisp_ClassFactoryLockServer =
            eif_proc( "on_clsfact_lock_server", eocdTypeId );


    // EOLE_OLE_OBJECT dispatching functions

//    Ocxdisp_OleObjSetClientSite =
//            eif_proc( "on_oleobject_set_client_site", eocdTypeId );
//    Ocxdisp_OleObjGetClientSite =
//            eif_fn_pointer( "on_oleobject_get_client_site", eocdTypeId );
//    Ocxdisp_OleObjSetHostNames =
//            eif_proc( "on_oleobject_set_host_names", eocdTypeId );
//    Ocxdisp_OleObjClose =
//            eif_proc( "on_oleobject_close", eocdTypeId );
//    Ocxdisp_OleObjSetMoniker =
//            eif_proc( "on_oleobject_set_moniker", eocdTypeId );
//    Ocxdisp_OleObjGetMoniker =
//            eif_fn_pointer( "on_oleobject_get_moniker", eocdTypeId );
//    Ocxdisp_OleObjInitFromData =
//            eif_proc( "on_oleobject_init_from_data", eocdTypeId );
//    Ocxdisp_OleObjGetClipboardData =
//            eif_fn_pointer( "on_oleobject_get_clipboard_data", eocdTypeId );
//    Ocxdisp_OleObjDoVerb =
//            eif_proc( "on_oleobject_do_verb", eocdTypeId );
//    Ocxdisp_OleObjEnumVerbs =
//            eif_fn_pointer( "on_oleobject_enum_verbs", eocdTypeId );
//    Ocxdisp_OleObjUpdate =
//            eif_proc( "on_oleobject_update", eocdTypeId );
//    Ocxdisp_OleObjIsUpToDate =
//            eif_proc( "on_oleobject_is_up_to_date", eocdTypeId );
//    Ocxdisp_OleObjGetUserClassId =
//           eif_fn_pointer( "on_oleobject_get_user_class_id", eocdTypeId );
//   Ocxdisp_OleObjGetUserType =
//            eif_fn_pointer( "on_oleobject_get_user_type", eocdTypeId );
//    Ocxdisp_OleObjSetExtent =
//            eif_proc( "on_oleobject_set_extent", eocdTypeId );
//    Ocxdisp_OleObjGetExtent =
//            eif_proc( "on_oleobject_get_extent", eocdTypeId );
//    Ocxdisp_OleObjAdvise =
//            eif_fn_int( "on_oleobject_advise", eocdTypeId );
//    Ocxdisp_OleObjUnadvise =
//            eif_proc( "on_oleobject_unadvise", eocdTypeId );
//    Ocxdisp_OleObjEnumAdvise =
//            eif_fn_pointer( "on_oleobject_enum_advise", eocdTypeId );
//    Ocxdisp_OleObjGetMiscStatus =
//            eif_fn_int( "on_oleobject_get_misc_status", eocdTypeId );
//    Ocxdisp_OleObjSetColorScheme =
//            eif_proc( "on_oleobject_set_color_scheme", eocdTypeId );

    // EOLE_PERSIST dispatching functions

    Ocxdisp_PersistGetClassId =
            eif_fn_pointer( "on_persist_get_class_id", eocdTypeId );

    // EOLE_PERSIST_STORAGE dispatching functions

//    Ocxdisp_PersistStgIsDirtyStg =
//            eif_proc( "on_pstg_is_dirty_stg", eocdTypeId );
//    Ocxdisp_PersistStgInitNewStg =
//            eif_proc( "on_pstg_init_new_stg", eocdTypeId );
//    Ocxdisp_PersistStgLoadStg =
//            eif_proc( "on_pstg_load_stg", eocdTypeId );
//    Ocxdisp_PersistStgSaveStg =
//            eif_proc( "on_pstg_save_stg", eocdTypeId );
//    Ocxdisp_PersistStgSaveCompleted =
//            eif_proc( "on_pstg_save_completed", eocdTypeId );
//    Ocxdisp_PersistStgHandsOffStorage =
//            eif_proc( "on_pstg_hands_off_storage", eocdTypeId );

    // EOLE_VIEW_OBJECT dispatching functions

//   Ocxdisp_ViewDraw =
//            eif_proc( "on_view_draw", eocdTypeId );
//    Ocxdisp_ViewGetColorSet =
//            eif_fn_pointer( "on_view_get_color_set", eocdTypeId );
//    Ocxdisp_ViewFreeze =
//            eif_fn_int( "on_view_freeze", eocdTypeId );
//    Ocxdisp_ViewUnfreeze =
//            eif_proc( "on_view_unfreeze", eocdTypeId );
//    Ocxdisp_ViewSetAdvise =
//            eif_proc( "on_view_set_advise", eocdTypeId );
//    Ocxdisp_ViewGetAdvise =
//            eif_proc( "on_view_get_advise", eocdTypeId );
//    Ocxdisp_ViewGetExtent =
//            eif_proc( "on_view_get_view_extent", eocdTypeId );

    // EOLE_RUNNABLE_OBJECT

//    Ocxdisp_RunnableGetRunningClass =
//            eif_fn_pointer( "on_ro_get_running_class", eocdTypeId );
//    Ocxdisp_RunnableRun =
//            eif_proc( "on_ro_run", eocdTypeId );
//    Ocxdisp_RunnableIsRunning =
//            eif_fn_bool( "on_ro_is_running", eocdTypeId );
//    Ocxdisp_RunnableLockRunning =
//            eif_proc( "on_ro_lock_running", eocdTypeId );
//    Ocxdisp_RunnableSetContainedObject =
//            eif_proc( "on_ro_set_contained_object", eocdTypeId );

    // EOLE_OLE_CONTROL

//    Ocxdisp_ControlGetControlInfo =
//            eif_proc( "on_ctrl_get_controlinfo", eocdTypeId );
//    Ocxdisp_ControlOnMnemonic =
//            eif_proc( "on_ctrl_on_mnemonic", eocdTypeId );
//    Ocxdisp_ControlOnAmbientPropertyChange =
//            eif_proc( "on_ctrl_on_ambient_property_change", eocdTypeId );
//    Ocxdisp_ControlFreezeEvents =
//            eif_proc( "on_ctrl_freeze_events", eocdTypeId );

    // EOLE_OLE_WINDOW

//    Ocxdisp_OleWndGetWindow =
//            eif_fn_int( "on_ole_wnd_get_window", eocdTypeId );
//    Ocxdisp_OleWndContextSensitiveHelp =
//            eif_proc( "on_ole_wnd_context_sensitive_help", eocdTypeId );

    // EOLE_INPLACE_OBJECT

//    Ocxdisp_IpoInPlaceDeactivate =
//            eif_proc( "on_ipo_in_place_deactivate", eocdTypeId );
//    Ocxdisp_IpoUIDeactivate =
//            eif_proc( "on_ipo_ui_deactivate", eocdTypeId );
//    Ocxdisp_IpoSetObjectRects =
//            eif_proc( "on_ipo_set_object_rects", eocdTypeId );
//    Ocxdisp_IpoReactivateAndUndo =
//            eif_proc( "on_ipo_reactivate_and_undo", eocdTypeId );
			
    // EOLE_INPLACE_ACTIVE_OBJECT
	
//    Ocxdisp_IpaoTranslateActivator =
//	            eif_proc( "on_ipao_translate_activator", eocdTypeId );
//    Ocxdisp_IpaoOnFrameWindowActivate =
//	            eif_proc( "on_ipao_on_frame_window_activate", eocdTypeId );
//    Ocxdisp_IpaoOnDocWindowActivate =
//	            eif_proc( "on_ipao_on_doc_window_activate", eocdTypeId );
//    Ocxdisp_IpaoResizeBorder =
//	            eif_proc( "on_ipao_resize_border", eocdTypeId );
//    Ocxdisp_IpaoEnableModeless =
//	            eif_proc( "on_ipao_enable_modeless", eocdTypeId );

    // EOLE_PARSE_DISPLAY_NAME

//    Ocxdisp_PdnParseDisplayName =
//            eif_fn_pointer("on_pdn_parse_display_name", eocdTypeId);

    // EOLE_CONTAINER

//    Ocxdisp_OleContainerEnumObjects =
//            eif_fn_pointer("on_olecontainer_enum_objects", eocdTypeId);
//    Ocxdisp_OleContainerLockContainer =
//            eif_proc("on_olecontainer_lock_container", eocdTypeId);

    // EOLE_INPLACE_UI_WINDOW

//    Ocxdisp_OleInPlaceUIWindowGetBorder =
//            eif_fn_pointer("on_inplaceuiwindow_get_border", eocdTypeId);
//    Ocxdisp_OleInPlaceUIWindowRequestBorderSpace =
//            eif_proc("on_inplaceuiwindow_request_border_space", eocdTypeId);
//    Ocxdisp_OleInPlaceUIWindowSetBorderSpace =
//            eif_proc("on_inplaceuiwindow_set_border_space", eocdTypeId);
//    Ocxdisp_OleInPlaceUIWindowSetActiveObject =
//            eif_proc("on_inplaceuiwindow_set_active_object", eocdTypeId);

    // EOLE_INPLACE_FRAME

//    Ocxdisp_OleInPlaceFrameInsertMenus =
//            eif_proc("on_inplaceframe_insert_menus", eocdTypeId);
//    Ocxdisp_OleInPlaceFrameSetMenu =
//            eif_proc("on_inplaceframe_set_menu", eocdTypeId);
//    Ocxdisp_OleInPlaceFrameRemoveMenus =
//            eif_proc("on_inplaceframe_remove_menus", eocdTypeId);
//    Ocxdisp_OleInPlaceFrameSetStatusText =
//            eif_proc("on_inplaceframe_set_status_text", eocdTypeId);
//    Ocxdisp_OleInPlaceFrameEnableModeless =
//            eif_proc("on_inplaceframe_enable_modeless", eocdTypeId);
//    Ocxdisp_OleInPlaceFrameTranslateAccelerator =
//            eif_proc("on_inplaceframe_translate_accelerator", eocdTypeId);

    // EOLE_CLIENT_SITE

//    Ocxdisp_OleClientSiteSaveObject =
//            eif_proc("on_clientsite_save_object", eocdTypeId);
//    Ocxdisp_OleClientSiteGetMoniker =
//            eif_fn_pointer("on_clientsite_get_moniker", eocdTypeId);
//    Ocxdisp_OleClientSiteGetContainer =
//            eif_fn_pointer("on_clientsite_get_container", eocdTypeId);
//    Ocxdisp_OleClientSiteShowObject =
//            eif_proc("on_clientsite_show_object", eocdTypeId);
//    Ocxdisp_OleClientSiteOnShowWindow =
//            eif_proc("on_clientsite_on_show_window", eocdTypeId);
//    Ocxdisp_OleClientSiteRequestNewObjectLayout =
//            eif_proc("on_clientsite_request_new_object_layout", eocdTypeId);

    // EOLE_INPLACE_SITE

//    Ocxdisp_OleInPlaceSiteCanInPlaceActivate =
//            eif_proc("on_inplacesite_can_inplace_activate", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteOnInPlaceActivate =
//            eif_proc("on_inplacesite_on_inplace_activate", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteOnUIActivate =
//            eif_proc("on_inplacesite_on_ui_activate", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteGetWindowContext =
//            eif_fn_pointer("on_inplacesite_get_window_context", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteScroll =
//            eif_proc("on_inplacesite_scroll", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteOnUIDeactivate =
//            eif_proc("on_inplacesite_on_ui_deactivate", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteOnInPlaceDeactivate =
//            eif_proc("on_inplacesite_on_inplace_deactivate", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteDiscardUndoState =
//            eif_proc("on_inplacesite_discard_undo_state", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteDeactivateAndUndo =
//            eif_proc("on_inplacesite_deactivate_and_undo", eocdTypeId);
//    Ocxdisp_OleInPlaceSiteOnPosRectChange =
//            eif_proc("on_inplacesite_on_pos_rect_change", eocdTypeId);

    // EOLE_CONTROL_SITE

//    Ocxdisp_OleControlSiteOnControlInfoChanged =
//            eif_proc("on_controlsite_on_controlinfo_changed", eocdTypeId);
//    Ocxdisp_OleControlSiteLockInPlaceActivate =
//            eif_proc("on_controlsite_lock_inplace_activate", eocdTypeId);
//    Ocxdisp_OleControlSiteGetExtendedControl =
//            eif_fn_pointer("on_controlsite_get_extended_control", eocdTypeId);
//    Ocxdisp_OleControlSiteTransformCoords =
//            eif_proc("on_controlsite_transform_coords", eocdTypeId);
//    Ocxdisp_OleControlSiteTranslateAccelerator =
//            eif_proc("on_controlsite_translate_accelerator", eocdTypeId);
//    Ocxdisp_OleControlSiteOnFocus =
//            eif_proc("on_controlsite_on_focus", eocdTypeId);
//    Ocxdisp_OleControlSiteShowPropertyFrame =
//            eif_proc("on_controlsite_show_property_frame", eocdTypeId);

    // EOLE_PROPERTY_NOTIFY_SINK

//    Ocxdisp_PropertyNotifySinkOnChanged =
//            eif_proc("on_propertynotifysink_on_changed", eocdTypeId);
//    Ocxdisp_PropertyNotifySinkOnRequestEdit =
//            eif_proc("on_propertynotifysink_on_request_edit", eocdTypeId);

    // EOLE_ADVISE_SINK

//    Ocxdisp_AdviseSinkOnDataChange =
//            eif_proc("on_advisesink_on_data_change", eocdTypeId);
//    Ocxdisp_AdviseSinkOnViewChange =
//            eif_proc("on_advisesink_on_view_change", eocdTypeId);
//    Ocxdisp_AdviseSinkOnRename =
//            eif_proc("on_advisesink_on_rename", eocdTypeId);
//    Ocxdisp_AdviseSinkOnSave =
//            eif_proc("on_advisesink_on_save", eocdTypeId);
//    Ocxdisp_AdviseSinkOnClose =
//            eif_proc("on_advisesink_on_close", eocdTypeId);

    // EOLE_DISPATCH

    Ocxdisp_DispatchGetTypeInfoCount =
            eif_fn_int("on_dispatch_get_type_info_count", eocdTypeId);
    Ocxdisp_DispatchGetTypeInfo =
            eif_fn_pointer("on_dispatch_get_type_info", eocdTypeId);
    Ocxdisp_DispatchGetIdsOfNames =
            eif_fn_pointer("on_dispatch_get_ids_of_names", eocdTypeId);
    Ocxdisp_DispatchInvoke =
            eif_proc("on_dispatch_invoke", eocdTypeId);
			
	// EOLE_FONT
	
	Ocxdisp_FontGetName =
			eif_fn_pointer("on_font_get_name", eocdTypeId);
	Ocxdisp_FontPutName =
			eif_proc("on_font_put_name", eocdTypeId);
	Ocxdisp_FontGetSize =
			eif_fn_pointer("on_font_get_size", eocdTypeId);
	Ocxdisp_FontPutSize =
			eif_proc("on_font_put_size", eocdTypeId);
	Ocxdisp_FontGetBold =
			eif_fn_bool("on_font_get_bold", eocdTypeId);
	Ocxdisp_FontPutBold =
			eif_proc("on_font_put_bold", eocdTypeId);
	Ocxdisp_FontGetItalic =
			eif_fn_bool("on_font_get_italic", eocdTypeId);
	Ocxdisp_FontPutItalic =
			eif_proc("on_font_put_italic", eocdTypeId);
	Ocxdisp_FontGetUnderline =
			eif_fn_bool("on_font_get_underline", eocdTypeId);
	Ocxdisp_FontPutUnderline =
			eif_proc("on_font_put_underline", eocdTypeId);
	Ocxdisp_FontGetStrikethrough =
			eif_fn_bool("on_font_get_strikethrough", eocdTypeId);
	Ocxdisp_FontPutStrikethrough =
			eif_proc("on_font_put_strikethrough", eocdTypeId);
	Ocxdisp_FontGetWeight =
			eif_fn_int("on_font_get_weight", eocdTypeId);
	Ocxdisp_FontPutWeight =
			eif_proc("on_font_put_weight", eocdTypeId);
	Ocxdisp_FontGetCharset =
			eif_fn_int("on_font_get_charset", eocdTypeId);
	Ocxdisp_FontPutCharset =
			eif_proc("on_font_put_charset", eocdTypeId);
	Ocxdisp_FontGetHFont =
			eif_fn_int("on_font_get_hfont", eocdTypeId);
	Ocxdisp_FontClone =
			eif_fn_pointer("on_font_clone", eocdTypeId);
	Ocxdisp_FontIsEqual =
			eif_proc("on_font_is_equal", eocdTypeId);
	Ocxdisp_FontSetRatio =
			eif_proc("on_font_set_ratio", eocdTypeId);
	Ocxdisp_FontQueryTextMetrics =
			eif_fn_pointer("on_font_query_text_metrics", eocdTypeId);
	Ocxdisp_FontAddRefHfont =
			eif_proc("on_font_add_ref_hfont", eocdTypeId);
	Ocxdisp_FontReleaseHfont =
			eif_proc("on_font_release_hfont", eocdTypeId);
	Ocxdisp_FontSetHdc =
			eif_proc("on_font_set_hdc", eocdTypeId);

	// EOLE_FONT_DISP
	
	Ocxdisp_FontDispInvoke =
			eif_proc("on_font_disp_invoke", eocdTypeId);
			
	// EOLE_PICTURE
	
     Ocxdisp_PictureGetHandle =
	 		eif_fn_int("on_picture_get_handle", eocdTypeId);
     Ocxdisp_PictureGetHpal =
	 		eif_fn_int("on_picture_get_hpal", eocdTypeId);
     Ocxdisp_PictureGetType =
	 		eif_fn_int("on_picture_get_type", eocdTypeId);
     Ocxdisp_PictureGetWidth =
	 		eif_fn_int("on_picture_get_width", eocdTypeId);
     Ocxdisp_PictureGetHeight =
	 		eif_fn_int("on_picture_get_height", eocdTypeId);
     Ocxdisp_PictureGetCurDc =
	 		eif_fn_int("on_picture_get_cur_dc", eocdTypeId);
     Ocxdisp_PictureGetKeepOriginalFormat =
	 		eif_fn_bool("on_picture_get_keep_original_format", eocdTypeId);
     Ocxdisp_PictureGetAttributes =
	 		eif_fn_int("on_picture_get_attributes", eocdTypeId);
     Ocxdisp_PictureRender =
	   		eif_proc("on_picture_render", eocdTypeId);
     Ocxdisp_PictureSetHpal =
	   		eif_proc("on_picture_set_hpal", eocdTypeId);
     Ocxdisp_PictureSelectPicture =
	 		eif_fn_pointer("on_picture_select_picture", eocdTypeId);
     Ocxdisp_PicturePutKeepOriginalFormat =
	   		eif_proc("on_picture_put_keep_original_format", eocdTypeId);
     Ocxdisp_PicturePictureChanged =
	   		eif_proc("on_picture_picture_changed", eocdTypeId);
     Ocxdisp_PictureSaveAsFile =
	 		eif_fn_int("on_picture_save_as_file", eocdTypeId);
			
	// EOLE_PICTURE_DISP
	
	Ocxdisp_PictureDispInvoke =
			eif_proc("on_picture_disp_invoke", eocdTypeId);
	
    // EOLE_PROVIDE_CLASS_INFO

    Ocxdisp_ProvideClassInfoGetClassInfo =
            eif_fn_pointer("on_provide_class_info_get_class_info", eocdTypeId);

    // EOLE_CONNECTION_POINT_CONTAINER

	Ocxdisp_ConnectionPointContainerEnumConnectionPoints =
            eif_fn_pointer("on_connection_point_container_enum_connection_points", eocdTypeId);
	Ocxdisp_ConnectionPointContainerFindConnectionPoint =
            eif_fn_pointer("on_connection_point_container_find_connection_point", eocdTypeId);
	 
	// EOLE_CONNECTION_POINT

	Ocxdisp_ConnectionPointAdvise =
            eif_fn_int("on_connection_point_advise", eocdTypeId);
	Ocxdisp_ConnectionPointUnadvise =
            eif_proc("on_connection_point_unadvise", eocdTypeId);
	Ocxdisp_ConnectionPointGetConnectionInterface =
            eif_fn_pointer("on_connection_point_get_connection_interface", eocdTypeId);
	Ocxdisp_ConnectionPointGetConnectionPointContainer =
            eif_fn_pointer("on_connection_point_get_connection_point_container", eocdTypeId);
	Ocxdisp_ConnectionPointEnumConnections =
            eif_fn_pointer("on_connection_point_enum_connections", eocdTypeId);
}

/*---------------------------------------------------------------------------*/

extern "C" void eole2_output_debug_string( EIF_POINTER pStr )
{
   OutputDebugString( (LPCTSTR)pStr );
}

/*---------------------------------------------------------------------------*/

extern "C" void EiffelStringToGuid( EIF_POINTER str, GUID *guid )
{
   CLSIDFromString (Eif2OleString (str), guid);
}

//---------------------------------------------------------------------------

extern "C" char* GuidToCString( REFGUID refguid )
{
   char *result;
   HRESULT res;
   LPOLESTR poleStr;

   res = StringFromCLSID (refguid, &poleStr);
   Ole2CString (poleStr, &result);
   CoTaskMemFree (poleStr);
   return result;
}

//---------------------------------------------------------------------------

extern "C" EIF_REFERENCE GuidToEiffelString (REFIID guid) {

    return EStringFromCString (GuidToCString (guid));
}

//---------------------------------------------------------------------------

extern "C" LPOLESTR Eif2OleString( EIF_POINTER eifString )
{
    LPOLESTR result;
    int len, wlen;

    // Calculate the length of ANSI string
    len = strlen( eifString );
    // Calculate the appropriate length of corresponding UNICODE str
    wlen = ( len + 1 ) * 2;
    // Allocate the space for the UNICODE string
    result = (LPOLESTR)calloc( 1, wlen );
    // Zeroize it
    memset( result, 0, wlen );
    // Convert ANSI string to UNICODE string
    MultiByteToWideChar( CP_ACP, MB_PRECOMPOSED, eifString,
            len, result, wlen );
    // return the UNICODE string
    return result;
}

//---------------------------------------------------------------------------

extern "C" EIF_REFERENCE Ole2EifString( LPCOLESTR oleString )
{
    static char* space = " ";
    BOOL flag = FALSE;
    char* buffer;
    int len;
    int i;

    // Calculate the length of the UNICODE string
    i = 0;
    while( oleString[i] != 0 )
    {
        i++;
    }

    len = i;
    // Allocate the space for the ANSI string
    buffer = (char*)calloc( 1, len + 1 );
    memset( buffer, 0, len + 1 );
    // Convert UNICODE string to ANSI string
    WideCharToMultiByte( CP_ACP, 0, oleString,
            len, buffer, len + 1, space, &flag );
    return makestr(buffer, len);
}

//---------------------------------------------------------------------------

extern "C" void Ole2CString( LPCOLESTR oleString, char** result )
{
    static char* space = " ";
    BOOL flag = FALSE;
    int len;
    int i;

    // Calculate the length of the UNICODE string
    i = 0;
    while( oleString[i] != 0 )
    {
        i++;
    }

    len = i;
	*result = (char*)(malloc ((len + 1)* sizeof (char)));
    memset( *result, 0, len + 1 );
    // Convert UNICODE string to ANSI string
    WideCharToMultiByte( CP_ACP, 0, oleString,
            len, *result, len + 1, space, &flag );
}

//---------------------------------------------------------------------------

extern "C" EIF_REFERENCE EStringFromCString( char* cstring )
{
	return makestr (cstring, strlen (cstring));
}

/////// END OF FILE /////////////////////////////////////////////////////////
