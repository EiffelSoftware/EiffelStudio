note

	description: "Definition of COM error codes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_EXCEPTION_CODES

feature -- Access

	Noerror: INTEGER
			-- Success code
		external
			"C [macro <winerror.h>]"
		alias
			"NOERROR"
		end
		
	S_ok: INTEGER
			-- Success code
		external
			"C [macro <winerror.h>]"
		alias
			"S_OK"
		end
					
	S_false: INTEGER
			-- Success code
		external
			"C [macro <winerror.h>]"
		alias
			"S_FALSE"
		end
					
	E_unexpected: INTEGER
			-- Unexpected failure
		external
			"C [macro <winerror.h>]"
		alias
			"E_UNEXPECTED"
		end
					
	E_notimpl: INTEGER
			-- Not implemented
		external
			"C [macro <winerror.h>]"
		alias
			"E_NOTIMPL"
		end
		
	E_outofmemory: INTEGER
			-- Ran out of memory
		external
			"C [macro <winerror.h>]"
		alias
			"E_OUTOFMEMORY"
		end
		
	E_invalidarg: INTEGER
			-- One or more arguments are invalid
		external
			"C [macro <winerror.h>]"
		alias
			"E_INVALIDARG"
		end
		
	E_nointerface: INTEGER
			-- No such interface supported
		external
			"C [macro <winerror.h>]"
		alias
			"E_NOINTERFACE"
		end
		
	E_pointer: INTEGER
			-- Invalid pointer
		external
			"C [macro <winerror.h>]"
		alias
			"E_POINTER"
		end
		
	E_handle: INTEGER
			-- Invalid handle
		external
			"C [macro <winerror.h>]"
		alias
			"E_HANDLE"
		end
		
	E_abort: INTEGER
			-- Operation aborted
		external
			"C [macro <winerror.h>]"
		alias
			"E_ABORT"
		end
		
	E_fail: INTEGER
			-- Unspecified error
		external
			"C [macro <winerror.h>]"
		alias
			"E_FAIL"
		end
		
	E_accessdenied: INTEGER
			-- General access denied error
		external
			"C [macro <winerror.h>]"
		alias
			"E_ACCESSDENIED"
		end
		
	Co_e_init_tls: INTEGER
			-- Thread local storage failure
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_TLS"
		end
		
	Co_e_init_shared_allocator: INTEGER
			-- Get shared memory allocator failure
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_SHARED_ALLOCATOR"
		end
		
	Co_e_init_memory_allocator: INTEGER
			-- Get memory allocator failure
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_MEMORY_ALLOCATOR"
		end
		
	Co_e_init_class_cache: INTEGER
			-- Unable to initialize class cache
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_CLASS_CACHE"
		end
		
	Co_e_init_rpc_channel: INTEGER
			-- Unable to initialize RPC services
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_RPC_CHANNEL"
		end
		
	Co_e_init_tls_set_channel_control: INTEGER
			-- Cannot set thread local storage channel control
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_TLS_SET_CHANNEL_CONTROL"
		end
		
	Co_e_init_tls_channel_control: INTEGER
			-- Could not allocate thread local storage channel control
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_TLS_CHANNEL_CONTROL"
		end
		
	Co_e_init_unaccepted_user_allocator: INTEGER
			-- The user supplied memory allocator is unacceptable
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_UNACCEPTED_USER_ALLOCATOR"
		end
		
	Co_e_init_scm_mutex_exists: INTEGER
			-- The OLE service mutex already exists
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_SCM_MUTEX_EXISTS"
		end
		
	Co_e_init_scm_file_mapping_exists: INTEGER
			-- The OLE service file mapping already exists
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_SCM_FILE_MAPPING_EXISTS"
		end
		
	Co_e_init_scm_map_view_of_file: INTEGER
			-- Unable to map view of file for OLE service
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_SCM_MAP_VIEW_OF_FILE"
		end
		
	Co_e_init_scm_exec_failure: INTEGER
			-- Failure attempting to launch OLE service
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_SCM_EXEC_FAILURE"
		end
		
	Co_e_init_only_single_threaded: INTEGER
			-- There was an attempt to call CoInitialize a second time while single threaded
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_INIT_ONLY_SINGLE_THREADED"
		end
		
	Ole_e_first: INTEGER
			-- Generic OLE error/success code
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_FIRST"
		end
		
	Ole_e_last: INTEGER
			-- Generic OLE error/success code
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_LAST"
		end
		
	Ole_s_first: INTEGER
			-- Generic OLE error/success code
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_S_FIRST"
		end
		
	Ole_s_last: INTEGER
			-- Generic OLE error/success code
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_S_LAST"
		end
		
	E_oleverb: INTEGER
			--Invalid OLEVERB structure
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_OLEVERB"
		end
		
	E_advf: INTEGER
			-- Invalid advise flags
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_ADVF"
		end
		
	E_enum_nomore: INTEGER
			-- Can't enumerate any more, because the associated data is missing
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_ENUM_NOMORE"
		end
		
	E_advisenotsupported: INTEGER
			-- This implementation doesn't take advises
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_ADVISENOTSUPPORTED"
		end
		
	E_noconnection: INTEGER
			-- There is no connection for this connection ID
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_NOCONNECTION"
		end
		
	E_notrunning: INTEGER
			-- Need to run the object to perform this operation
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_NOTRUNNING"
		end
		
	E_nocache: INTEGER
			-- There is no cache to operate on
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_NOCACHE"
		end
		
	E_blank: INTEGER
			-- Uninitialized object
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_BLANK"
		end
		
	E_classdiff: INTEGER
			-- Linked object's source class has changed
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_CLASSDIFF"
		end
		
	E_cant_getmoniker: INTEGER
			-- Not able to get the moniker of the object
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_CANT_GETMONIKER"
		end
		
	E_cant_bindtosource: INTEGER
			-- Not able to bind to the source
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_CANT_BINDTOSOURCE"
		end
		
	E_static: INTEGER
			-- Object is static operation not allowed
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_STATIC"
		end
		
	E_promptsavecancelled: INTEGER
			--0x8004000B
			-- User cancelled out of save dialog
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_PROMPTSAVECANCELLED"
		end
			
	E_invalidrect: INTEGER
			-- Invalid rectangle
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_INVALIDRECT"
		end
		
	E_wrongcompobj: INTEGER
			-- compobj.dll is too old for the ole2.dll initialized
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_WRONGCOMPOBJ"
		end
		
	E_invalidhwnd: INTEGER
			-- Invalid window handle
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_INVALIDHWND"
		end
		
	E_not_inplaceactive: INTEGER
			-- Object is not in any of the inplace active states
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_NOT_INPLACEACTIVE"
		end
		
	E_cantconvert: INTEGER
			-- Not able to convert object
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_CANTCONVERT"
		end
		
	E_nostorage: INTEGER
			-- Not able to perform the operation because object is not given storage yet
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_E_NOSTORAGE"
		end
		
	Dv_e_formatetc: INTEGER
			-- Invalid FORMATETC structure
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_FORMATETC"
		end
		
	Dv_e_dvtargetdevice: INTEGER
			-- Invalid DVTARGETDEVICE structure
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_DVTARGETDEVICE"
		end
		
	Dv_e_stgmedium: INTEGER
			-- Invalid STDGMEDIUM structure
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_STGMEDIUM"
		end
		
	Dv_e_statdata: INTEGER
			-- Invalid STATDATA structure
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_STATDATA"
		end
		
	Dv_e_lindex: INTEGER
			-- Invalid lindex
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_LINDEX"
		end
		
	Dv_e_tymed: INTEGER
			-- Invalid tymed
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_TYMED"
		end
		
	Dv_e_clipformat: INTEGER
			-- Invalid clipboard format
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_CLIPFORMAT"
		end
		
	Dv_e_dvaspect: INTEGER
			-- Invalid aspect(s)
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_DVASPECT"
		end
		
	Dv_e_dvtargetdevice_size: INTEGER
			-- tdSize parameter of the DVTARGETDEVICE structure is invalid
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_DVTARGETDEVICE_SIZE"
		end
		
	Dv_e_noiviewobject: INTEGER
			-- Object doesn't support IViewObject interface
		external
			"C [macro <winerror.h>]"
		alias
			"DV_E_NOIVIEWOBJECT"
		end
		
	Dragdrop_e_first: INTEGER
			-- Drag-and-drop interfaces error support
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_E_FIRST"
		end
		
	Dragdrop_e_last: INTEGER
			-- Drag-and-drop interfaces error support
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_E_LAST"
		end
		
	Dragdrop_s_first: INTEGER
			-- Drag-and-drop interfaces error support
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_S_FIRST"
		end
		
	Dragdrop_s_last: INTEGER
			-- Drag-and-drop interfaces error support
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_S_LAST"
		end
		
	Dragdrop_e_notregistered: INTEGER
			-- Trying to revoke a drop target that has not been registered
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_E_NOTREGISTERED"
		end
		
	Dragdrop_e_alreadyregistered: INTEGER
			-- This window has already been registered as a drop target
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_E_ALREADYREGISTERED"
		end
		
	Dragdrop_e_invalidhwnd: INTEGER
			-- Invalid window handle
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_E_INVALIDHWND"
		end
		
	Classfactory_e_first: INTEGER
			-- Class factory interfaces support
		external
			"C [macro <winerror.h>]"
		alias
			"CLASSFACTORY_E_FIRST"
		end
		
	Classfactory_e_last: INTEGER
			-- Class factory interfaces support
		external
			"C [macro <winerror.h>]"
		alias
			"CLASSFACTORY_E_LAST"
		end
		
	Classfactory_s_first: INTEGER
			-- Class factory interfaces support
		external
			"C [macro <winerror.h>]"
		alias
			"CLASSFACTORY_S_FIRST"
		end
		
	Classfactory_s_last: INTEGER
			-- Class factory interfaces support
		external
			"C [macro <winerror.h>]"
		alias
			"CLASSFACTORY_S_LAST"
		end
		
	Class_e_noaggregation: INTEGER
			-- Class does not support aggregation (or class object is remote)
		external
			"C [macro <winerror.h>]"
		alias
			"CLASS_E_NOAGGREGATION"
		end
		
	Class_e_classnotavailable: INTEGER
			-- ClassFactory cannot supply requested class
		external
			"C [macro <winerror.h>]"
		alias
			"CLASS_E_CLASSNOTAVAILABLE"
		end
		
	Marshal_e_first: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"MARSHAL_E_FIRST"
		end
		
	Marshal_e_last: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"MARSHAL_E_LAST"
		end
		
	Marshal_s_first: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"MARSHAL_S_FIRST"
		end
		
	Marshal_s_last: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"MARSHAL_S_LAST"
		end
		
	Data_e_first: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"DATA_E_FIRST"
		end
		
	Data_e_last: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"DATA_E_LAST"
		end
		
	Data_s_first: INTEGER
			-- Error code boundaries
					external
						"C [macro <winerror.h>]"
					alias
						"DATA_S_FIRST"
					end
					
	Data_s_last: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"DATA_S_LAST"
		end
		
	View_e_first: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"VIEW_E_FIRST"
		end
		
	View_e_last: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"VIEW_E_LAST"
		end
		
	View_s_first: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"VIEW_S_FIRST"
		end
		
	View_s_last: INTEGER
			-- Error code boundaries
		external
			"C [macro <winerror.h>]"
		alias
			"VIEW_S_LAST"
		end
		
	View_e_draw: INTEGER
			-- Error drawing view
		external
			"C [macro <winerror.h>]"
		alias
			"VIEW_E_DRAW"
		end
		
	Regdb_e_first: INTEGER
			-- Registry operations error code
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_E_FIRST"
		end
		
	Regdb_e_last: INTEGER
			-- Registry operations error code
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_E_LAST"
		end
		
	Regdb_s_first: INTEGER
			-- Registry operations error code
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_S_FIRST"
		end
		
	Regdb_s_last: INTEGER
			-- Registry operations error code
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_S_LAST"
		end
		
	Regdb_e_readregdb: INTEGER
			-- Could not read key from registry
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_E_READREGDB"
		end
		
	Regdb_e_writeregdb: INTEGER
			-- Could not write key to registry
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_E_WRITEREGDB"
		end
		
	Regdb_e_keymissing: INTEGER
			--  Could not find the key in the registry
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_E_KEYMISSING"
		end
		
	Regdb_e_invalidvalue: INTEGER
			--  Invalid value for registry
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_E_INVALIDVALUE"
		end
		
	Regdb_e_classnotreg: INTEGER
			--  Class not registered
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_E_CLASSNOTREG"
		end
		
	Regdb_e_iidnotreg: INTEGER
			--  Interface not registered
		external
			"C [macro <winerror.h>]"
		alias
			"REGDB_E_IIDNOTREG"
		end
		
	Cache_e_first: INTEGER
			-- Caching error
		external
			"C [macro <winerror.h>]"
		alias
			"CACHE_E_FIRST"
		end
		
	Cache_e_last: INTEGER
			-- Caching error
		external
			"C [macro <winerror.h>]"
		alias
			"CACHE_E_LAST"
		end
		
	Cache_s_first: INTEGER
			-- Caching error
		external
			"C [macro <winerror.h>]"
		alias
			"CACHE_S_FIRST"
		end
		
	Cache_s_last: INTEGER
			-- Caching error
		external
			"C [macro <winerror.h>]"
		alias
			"CACHE_S_LAST"
		end
		
	Cache_e_nocache_updated: INTEGER
			--  Cache not updated
		external
			"C [macro <winerror.h>]"
		alias
			"CACHE_E_NOCACHE_UPDATED"
		end
		
	Oleobj_e_first: INTEGER
			-- Ole object error code
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_E_FIRST"
		end
		
	Oleobj_e_last: INTEGER
			-- Ole object error code
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_E_LAST"
		end
		
	Oleobj_s_first: INTEGER
			-- Ole object error code
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_S_FIRST"
		end
		
	Oleobj_s_last: INTEGER
			-- Ole object error code
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_S_LAST"
		end
		
	Oleobj_e_noverbs: INTEGER
			--  No verbs for OLE object
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_E_NOVERBS"
		end
		
	Oleobj_e_invalidverb: INTEGER
			--  Invalid verb for OLE object
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_E_INVALIDVERB"
		end
		
	Clientsite_e_first: INTEGER
			-- Client site error code
		external
			"C [macro <winerror.h>]"
		alias
			"CLIENTSITE_E_FIRST"
		end
		
	Clientsite_e_last: INTEGER
			-- Client site error code
		external
			"C [macro <winerror.h>]"
		alias
			"CLIENTSITE_E_LAST"
		end
		
	Clientsite_s_first: INTEGER
			-- Client site error code
		external
			"C [macro <winerror.h>]"
		alias
			"CLIENTSITE_S_FIRST"
		end
		
	Clientsite_s_last: INTEGER
			-- Client site error code
		external
			"C [macro <winerror.h>]"
		alias
			"CLIENTSITE_S_LAST"
		end
		
	Inplace_e_notundoable: INTEGER
			--  Undo is not available
		external
			"C [macro <winerror.h>]"
		alias
			"INPLACE_E_NOTUNDOABLE"
		end
		
	Inplace_e_notoolspace: INTEGER
			--  Space for tools is not available
		external
			"C [macro <winerror.h>]"
		alias
			"INPLACE_E_NOTOOLSPACE"
		end
		
	Inplace_e_first: INTEGER
			-- Inplace activation related error
		external
			"C [macro <winerror.h>]"
		alias
			"INPLACE_E_FIRST"
		end
		
	Inplace_e_last: INTEGER
			-- Inplace activation related error
		external
			"C [macro <winerror.h>]"
		alias
			"INPLACE_E_LAST"
		end
		
	Inplace_s_first: INTEGER
			-- Inplace activation related error
		external
			"C [macro <winerror.h>]"
		alias
			"INPLACE_S_FIRST"
		end
		
	Inplace_s_last: INTEGER
			-- Inplace activation related error
		external
			"C [macro <winerror.h>]"
		alias
			"INPLACE_S_LAST"
		end
		
	Enum_e_first: INTEGER
			-- Enumerator related error
		external
			"C [macro <winerror.h>]"
		alias
			"ENUM_E_FIRST"
		end
		
	Enum_e_last: INTEGER
			-- Enumerator related error
		external
			"C [macro <winerror.h>]"
		alias
			"ENUM_E_LAST"
		end
		
	Enum_s_first: INTEGER
			-- Enumerator related error
		external
			"C [macro <winerror.h>]"
		alias
			"ENUM_S_FIRST"
		end
		
	Enum_s_last: INTEGER
			-- Enumerator related error
		external
			"C [macro <winerror.h>]"
		alias
			"ENUM_S_LAST"
		end
		
	Convert10_e_first: INTEGER
			-- Conversion related error
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_FIRST"
		end
		
	Convert10_e_last: INTEGER
			-- Conversion related error
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_LAST"
		end
		
	Convert10_s_first: INTEGER
			-- Conversion related error
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_S_FIRST"
		end
		
	Convert10_s_last: INTEGER
			-- Conversion related error
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_S_LAST"
		end
		
	Convert10_e_olestream_get: INTEGER
			-- OLESTREAM Get method failed
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_OLESTREAM_GET"
		end
		
	Convert10_e_olestream_put: INTEGER
			-- OLESTREAM Put method failed
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_OLESTREAM_PUT"
		end
		
	Convert10_e_olestream_fmt: INTEGER
			-- Contents of the OLESTREAM not in correct format
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_OLESTREAM_FMT"
		end
		
	Convert10_e_olestream_bitmap_to_dib: INTEGER
			-- There was an error in a Windows GDI call while converting the bitmap to a DIB
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_OLESTREAM_BITMAP_TO_DIB"
		end
		
	Convert10_e_stg_fmt: INTEGER
			-- Contents of the IStorage not in correct format
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_STG_FMT"
		end
		
	Convert10_e_stg_no_std_stream: INTEGER
			-- Contents of IStorage is missing one of the standard streams
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_STG_NO_STD_STREAM"
		end
		
	Convert10_e_stg_dib_to_bitmap: INTEGER
			-- There was an error in a Windows GDI call while converting the DIB to a bitmap.
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_E_STG_DIB_TO_BITMAP"
		end
		
	Clipbrd_e_first: INTEGER
			-- Clipboard related error
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_E_FIRST"
		end
		
	Clipbrd_e_last: INTEGER
			-- Clipboard related error
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_E_LAST"
		end
		
	Clipbrd_s_first: INTEGER
			-- Clipboard related error
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_S_FIRST"
		end
		
	Clipbrd_s_last: INTEGER
			-- Clipboard related error
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_S_LAST"
		end
		
	Clipbrd_e_cant_open: INTEGER
			-- OpenClipboard Failed
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_E_CANT_OPEN"
		end
		
	Clipbrd_e_cant_empty: INTEGER
			-- EmptyClipboard Failed
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_E_CANT_EMPTY"
		end
		
	Clipbrd_e_cant_set: INTEGER
			-- SetClipboard Failed
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_E_CANT_SET"
		end
		
	Clipbrd_e_bad_data: INTEGER
			-- Data on clipboard is invalid
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_E_BAD_DATA"
		end
		
	Clipbrd_e_cant_close: INTEGER
			-- CloseClipboard Failed
		external
			"C [macro <winerror.h>]"
		alias
			"CLIPBRD_E_CANT_CLOSE"
		end
		
	Mk_e_first: INTEGER
			-- Moniker related error
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_FIRST"
		end
		
	Mk_e_last: INTEGER
			-- Moniker related error
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_LAST"
		end
		
	Mk_s_first: INTEGER
			-- Moniker related error
		external
			"C [macro <winerror.h>]"
		alias
			"MK_S_FIRST"
		end
		
	Mk_s_last: INTEGER
			-- Moniker related error
		external
			"C [macro <winerror.h>]"
		alias
			"MK_S_LAST"
		end
		
	Mk_e_connectmanually: INTEGER
			-- Moniker needs to be connected manually
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_CONNECTMANUALLY"
		end
		
	Mk_e_exceededdeadline: INTEGER
			-- Operation exceeded deadline
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_EXCEEDEDDEADLINE"
		end
		
	Mk_e_needgeneric: INTEGER
			-- Moniker needs to be generic
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_NEEDGENERIC"
		end
		
	Mk_e_unavailable: INTEGER
			-- Operation unavailable
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_UNAVAILABLE"
		end
		
	Mk_e_syntax: INTEGER
			-- Invalid syntax
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_SYNTAX"
		end
		
	Mk_e_noobject: INTEGER
			-- No object for moniker
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_NOOBJECT"
		end
		
	Mk_e_invalidextension: INTEGER
			-- Bad extension for file
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_INVALIDEXTENSION"
		end
		
	Mk_e_intermediateinterfacenotsupported: INTEGER
			-- Intermediate operation failed
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_INTERMEDIATEINTERFACENOTSUPPORTED"
		end
		
	Mk_e_notbindable: INTEGER
			-- Moniker is not bindable
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_NOTBINDABLE"
		end
		
	Mk_e_notbound: INTEGER
			-- Moniker is not bound
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_NOTBOUND"
		end
		
	Mk_e_cantopenfile: INTEGER
			-- Moniker cannot open file
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_CANTOPENFILE"
		end
		
	Mk_e_mustbotheruser: INTEGER
			-- User input required for operation to succeed
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_MUSTBOTHERUSER"
		end
		
	Mk_e_noinverse: INTEGER
			-- Moniker class has no inverse
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_NOINVERSE"
		end
		
	Mk_e_nostorage: INTEGER
			-- Moniker does not refer to storage
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_NOSTORAGE"
		end
		
	Mk_e_noprefix: INTEGER
			-- No common prefix
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_NOPREFIX"
		end
		
	Mk_e_enumeration_failed: INTEGER
			-- Moniker could not be enumerated
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_ENUMERATION_FAILED"
		end
		
	Co_e_first: INTEGER
			-- Common object model DLL related error
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_FIRST"
		end
		
	Co_e_last: INTEGER
			-- Common object model DLL related error
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_LAST"
		end
		
	Co_s_first: INTEGER
			-- Common object model DLL related error
		external
			"C [macro <winerror.h>]"
		alias
			"CO_S_FIRST"
		end
		
	Co_s_last: INTEGER
			-- Common object model DLL related error
		external
			"C [macro <winerror.h>]"
		alias
			"CO_S_LAST"
		end
		
	Co_e_notinitialized: INTEGER
			-- CoInitialize has not been called.
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_NOTINITIALIZED"
		end
		
	Co_e_alreadyinitialized: INTEGER
			-- CoInitialize has already been called.
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_ALREADYINITIALIZED"
		end
		
	Co_e_cantdetermineclass: INTEGER
			-- Class of object cannot be determined
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_CANTDETERMINECLASS"
		end
		
	Co_e_classstring: INTEGER
			-- Invalid class string
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_CLASSSTRING"
		end
		
	Co_e_iidstring: INTEGER
			-- Invalid interface string
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_IIDSTRING"
		end
		
	Co_e_appnotfound: INTEGER
			-- Application not found
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_APPNOTFOUND"
		end
		
	Co_e_appsingleuse: INTEGER
			-- Application cannot be run more than once
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_APPSINGLEUSE"
		end
		
	Co_e_errorinapp: INTEGER
			-- Some error in application program
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_ERRORINAPP"
		end
		
	Co_e_dllnotfound: INTEGER
			-- DLL for class not found
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_DLLNOTFOUND"
		end
		
	Co_e_errorindll: INTEGER
			-- Error in the DLL
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_ERRORINDLL"
		end
		
	Co_e_wrongosforapp: INTEGER
			-- Wrong OS or OS version for application
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_WRONGOSFORAPP"
		end
		
	Co_e_objnotreg: INTEGER
			-- Object is not registered
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_OBJNOTREG"
		end
		
	Co_e_objisreg: INTEGER
			-- Object is already registered
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_OBJISREG"
		end
		
	Co_e_objnotconnected: INTEGER
			-- Object is not connected to server
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_OBJNOTCONNECTED"
		end
		
	Co_e_appdidntreg: INTEGER
			-- Application was launched but it didn't register a class factory
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_APPDIDNTREG"
		end
		
	Co_e_released: INTEGER
			-- Object has been released
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_RELEASED"
		end
		
	Ole_s_usereg: INTEGER
			-- Use the registry database to provide the requested information
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_S_USEREG"
		end
		
	Ole_s_static: INTEGER
			-- Success, but static
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_S_STATIC"
		end
		
	Ole_s_mac_clipformat: INTEGER
			-- Macintosh clipboard format
		external
			"C [macro <winerror.h>]"
		alias
			"OLE_S_MAC_CLIPFORMAT"
		end
		
	Dragdrop_s_drop: INTEGER
			-- Successful drop took place
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_S_DROP"
		end
		
	Dragdrop_s_cancel: INTEGER
			-- Drag-drop operation canceled
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_S_CANCEL"
		end
		
	Dragdrop_s_usedefaultcursors: INTEGER
			-- Use the default cursor
		external
			"C [macro <winerror.h>]"
		alias
			"DRAGDROP_S_USEDEFAULTCURSORS"
		end
		
	Data_s_sameformatetc: INTEGER
			-- Data has same FORMATETC
		external
			"C [macro <winerror.h>]"
		alias
			"DATA_S_SAMEFORMATETC"
		end
		
	View_s_already_frozen: INTEGER
			-- View is already frozen
		external
			"C [macro <winerror.h>]"
		alias
			"VIEW_S_ALREADY_FROZEN"
		end
		
	Cache_s_formatetc_notsupported: INTEGER
			-- FORMATETC not supported
		external
			"C [macro <winerror.h>]"
		alias
			"CACHE_S_FORMATETC_NOTSUPPORTED"
		end
		
	Cache_s_samecache: INTEGER
			-- Same cache
		external
			"C [macro <winerror.h>]"
		alias
			"CACHE_S_SAMECACHE"
		end
		
	Cache_s_somecaches_notupdated: INTEGER
			-- Some cache(s) not updated
		external
			"C [macro <winerror.h>]"
		alias
			"CACHE_S_SOMECACHES_NOTUPDATED"
		end
		
	Oleobj_s_invalidverb: INTEGER
			-- Invalid verb for OLE object
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_S_INVALIDVERB"
		end
		
	Oleobj_s_cannot_doverb_now: INTEGER
			-- Verb number is valid but verb cannot be done now
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_S_CANNOT_DOVERB_NOW"
		end
		
	Oleobj_s_invalidhwnd: INTEGER
			-- Invalid window handle passed
		external
			"C [macro <winerror.h>]"
		alias
			"OLEOBJ_S_INVALIDHWND"
		end
		
	Inplace_s_truncated: INTEGER
			-- Message is too long some of it had to be truncated before displaying
		external
			"C [macro <winerror.h>]"
		alias
			"INPLACE_S_TRUNCATED"
		end
		
	Convert10_s_no_presentation: INTEGER
			-- Unable to convert OLESTREAM to IStorage
		external
			"C [macro <winerror.h>]"
		alias
			"CONVERT10_S_NO_PRESENTATION"
		end
		
	Mk_s_reduced_to_self: INTEGER
			-- Moniker reduced to itself
		external
			"C [macro <winerror.h>]"
		alias
			"MK_S_REDUCED_TO_SELF"
		end
		
	Mk_s_me: INTEGER
			-- Common prefix is this moniker
		external
			"C [macro <winerror.h>]"
		alias
			"MK_S_ME"
		end
		
	Mk_s_him: INTEGER
			-- Common prefix is input moniker
		external
			"C [macro <winerror.h>]"
		alias
			"MK_S_HIM"
		end
		
	Mk_s_us: INTEGER
			-- Common prefix is both monikers
		external
			"C [macro <winerror.h>]"
		alias
			"MK_S_US"
		end
		
	Mk_s_monikeralreadyregistered: INTEGER
			-- Moniker is already registered in running object table
		external
			"C [macro <winerror.h>]"
		alias
			"MK_S_MONIKERALREADYREGISTERED"
		end
		
	Co_e_class_create_failed: INTEGER
			--  Attempt to create a class object failed
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_CLASS_CREATE_FAILED"
		end
		
	Co_e_scm_error: INTEGER
			-- OLE service could not bind object
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_SCM_ERROR"
		end
		
	Co_e_scm_rpc_failure: INTEGER
			-- RPC communication failed with OLE service
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_SCM_RPC_FAILURE"
		end
		
	Co_e_bad_path: INTEGER
			-- Bad path to object
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_BAD_PATH"
		end
		
	Co_e_server_exec_failure: INTEGER
			-- Server execution failed
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_SERVER_EXEC_FAILURE"
		end
		
	Co_e_objsrv_rpc_failure: INTEGER
			-- OLE service could not communicate with the object server
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_OBJSRV_RPC_FAILURE"
		end
		
	Mk_e_no_normalized: INTEGER
			-- Moniker path could not be normalized
		external
			"C [macro <winerror.h>]"
		alias
			"MK_E_NO_NORMALIZED"
		end
		
	Co_e_server_stopping: INTEGER
			--0x80080007
			-- Object server is stopping when OLE service contacts it
		external
			"C [macro <winerror.h>]"
		alias
			"CO_E_SERVER_STOPPING"
		end
			

	Mem_e_invalid_root: INTEGER
			-- An invalid root block pointer was specified
		external
			"C [macro <winerror.h>]"
		alias
			"MEM_E_INVALID_ROOT"
		end
		
	Mem_e_invalid_link: INTEGER
			-- An allocation chain contained an invalid link pointer
		external
			"C [macro <winerror.h>]"
		alias
			"MEM_E_INVALID_LINK"
		end
		
	Mem_e_invalid_size: INTEGER
			-- The requested allocation size was too large
		external
			"C [macro <winerror.h>]"
		alias
			"MEM_E_INVALID_SIZE"
		end
		
	Disp_e_unknowninterface: INTEGER
			-- Unknown interface.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_UNKNOWNINTERFACE"
		end
		
	Disp_e_membernotfound: INTEGER
			-- Member not found.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_MEMBERNOTFOUND"
		end
		
	Disp_e_paramnotfound: INTEGER
			-- Parameter not found.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_PARAMNOTFOUND"
		end
		
	Disp_e_typemismatch: INTEGER
			-- Type mismatch.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_TYPEMISMATCH"
		end
		
	Disp_e_unknownname: INTEGER
			-- Unknown name.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_UNKNOWNNAME"
		end
		
	Disp_e_nonamedargs: INTEGER
			-- No named arguments.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_NONAMEDARGS"
		end
		
	Disp_e_badvartype: INTEGER
			-- Bad variable type.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_BADVARTYPE"
		end
		
	Disp_e_exception: INTEGER
			-- Exception occurred.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_EXCEPTION"
		end
		
	Disp_e_overflow: INTEGER
			-- Out of present range.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_OVERFLOW"
		end
		
	Disp_e_badindex: INTEGER
			-- Invalid index.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_BADINDEX"
		end
		
	Disp_e_unknownlcid: INTEGER
			-- Unknown language.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_UNKNOWNLCID"
		end
		
	Disp_e_arrayislocked: INTEGER
			-- Memory is locked.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_ARRAYISLOCKED"
		end
		
	Disp_e_badparamcount: INTEGER
			-- Invalid number of parameters.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_BADPARAMCOUNT"
		end
		
	Disp_e_paramnotoptional: INTEGER
			-- Parameter not optional.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_PARAMNOTOPTIONAL"
		end
		
	Disp_e_badcallee: INTEGER
			-- Invalid callee.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_BADCALLEE"
		end
		
	Disp_e_notacollection: INTEGER
			-- Does not support a collection.
		external
			"C [macro <winerror.h>]"
		alias
			"DISP_E_NOTACOLLECTION"
		end
		
	Type_e_buffertoosmall: INTEGER
			--  Buffer too small.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_BUFFERTOOSMALL"
		end
		
	Type_e_invdataread: INTEGER
			-- Old format or invalid type library.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_INVDATAREAD"
		end
		
	Type_e_unsupformat: INTEGER
			-- Old format or invalid type library.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_UNSUPFORMAT"
		end
		
	Type_e_registryaccess: INTEGER
			-- Error accessing the OLE registry.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_REGISTRYACCESS"
		end
		
	Type_e_libnotregistered: INTEGER
			-- Library not registered.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_LIBNOTREGISTERED"
		end
		
	Type_e_undefinedtype: INTEGER
			-- Bound to unknown type.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_UNDEFINEDTYPE"
		end
		
	Type_e_qualifiednamedisallowed: INTEGER
			-- Qualified name disallowed.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_QUALIFIEDNAMEDISALLOWED"
		end
		
	Type_e_invalidstate: INTEGER
			-- Invalid forward reference, or reference to uncompiled type.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_INVALIDSTATE"
		end
		
	Type_e_wrongtypekind: INTEGER
			-- Type mismatch.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_WRONGTYPEKIND"
		end
		
	Type_e_elementnotfound: INTEGER
			-- Element not found.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_ELEMENTNOTFOUND"
		end
		
	Type_e_ambiguousname: INTEGER
			-- Ambiguous name.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_AMBIGUOUSNAME"
		end
		
	Type_e_nameconflict: INTEGER
			-- Name already exists in the library.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_NAMECONFLICT"
		end
		
	Type_e_unknownlcid: INTEGER
			-- Unknown LCID.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_UNKNOWNLCID"
		end
		
	Type_e_dllfunctionnotfound: INTEGER
			-- Function not defined in specified DLL.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_DLLFUNCTIONNOTFOUND"
		end
		
	Type_e_badmodulekind: INTEGER
			-- Wrong module kind for the operation.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_BADMODULEKIND"
		end
		
	Type_e_sizetoobig: INTEGER
			-- Size may not exceed 64K.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_SIZETOOBIG"
		end
		
	Type_e_duplicateid: INTEGER
			-- Duplicate ID in inheritance hierarchy.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_DUPLICATEID"
		end
		
	Type_e_invalidid: INTEGER
			-- Incorrect inheritance depth in standard OLE hmember.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_INVALIDID"
		end
		
	Type_e_typemismatch: INTEGER
			-- Type mismatch.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_TYPEMISMATCH"
		end
		
	Type_e_outofbounds: INTEGER
			-- Invalid number of arguments.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_OUTOFBOUNDS"
		end
		
	Type_e_ioerror: INTEGER
			-- I/O Error.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_IOERROR"
		end
		
	Type_e_cantcreatetmpfile: INTEGER
			-- Error creating unique tmp file.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_CANTCREATETMPFILE"
		end
		
	Type_e_cantloadlibrary: INTEGER
			-- Error loading type library/DLL.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_CANTLOADLIBRARY"
		end
		
	Type_e_inconsistentpropfuncs: INTEGER
			-- Inconsistent property functions.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_INCONSISTENTPROPFUNCS"
		end
		
	Type_e_circulartype: INTEGER
			-- Circular dependency between types/modules.
		external
			"C [macro <winerror.h>]"
		alias
			"TYPE_E_CIRCULARTYPE"
		end
		
	Stg_e_invalidfunction: INTEGER
			-- Storage related errors
			-- Unable to perform requested operation.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INVALIDFUNCTION"
		end
			

	Stg_e_filenotfound: INTEGER
			--  %1 could not be found.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_FILENOTFOUND"
		end
		
	Stg_e_pathnotfound: INTEGER
			-- The path %1 could not be found.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_PATHNOTFOUND"
		end
		
	Stg_e_toomanyopenfiles: INTEGER
			-- There are insufficient resources to open another file.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_TOOMANYOPENFILES"
		end
		
	Stg_e_accessdenied: INTEGER
			-- Access Denied.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_ACCESSDENIED"
		end
		
	Stg_e_invalidhandle: INTEGER
			-- Attempted an operation on an invalid object.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INVALIDHANDLE"
		end
		
	Stg_e_insufficientmemory: INTEGER
			-- There is insufficient memory available to complete operation.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INSUFFICIENTMEMORY"
		end
		
	Stg_e_invalidpointer: INTEGER
			-- Invalid pointer error.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INVALIDPOINTER"
		end
		
	Stg_e_nomorefiles: INTEGER
			-- There are no more entries to return.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_NOMOREFILES"
		end
		
	Stg_e_diskiswriteprotected: INTEGER
			-- Disk is write-protected.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_DISKISWRITEPROTECTED"
		end
		
	Stg_e_seekerror: INTEGER
			-- An error occurred during a seek operation.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_SEEKERROR"
		end
		
	Stg_e_writefault: INTEGER
			-- A disk error occurred during a write operation.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_WRITEFAULT"
		end
		
	Stg_e_readfault: INTEGER
			-- A disk error occurred during a read operation.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_READFAULT"
		end
		
	Stg_e_shareviolation: INTEGER
			-- A share violation has occurred.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_SHAREVIOLATION"
		end
		
	Stg_e_lockviolation: INTEGER
			-- A lock violation has occurred.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_LOCKVIOLATION"
		end
		
	Stg_e_filealreadyexists: INTEGER
			-- %1 already exists.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_FILEALREADYEXISTS"
		end
		
	Stg_e_invalidparameter: INTEGER
			-- Invalid parameter error.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INVALIDPARAMETER"
		end
		
	Stg_e_mediumfull: INTEGER
			-- There is insufficient disk space to complete operation.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_MEDIUMFULL"
		end
		
	Stg_e_abnormalapiexit: INTEGER
			-- An API call exited abnormally.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_ABNORMALAPIEXIT"
		end
		
	Stg_e_invalidheader: INTEGER
			-- The file %1 is not a valid compound file.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INVALIDHEADER"
		end
		
	Stg_e_invalidname: INTEGER
			-- The name %1 is not valid.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INVALIDNAME"
		end
		
	Stg_e_unknown: INTEGER
			-- An unexpected error occurred.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_UNKNOWN"
		end
		
	Stg_e_unimplementedfunction: INTEGER
			-- That function is not implemented.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_UNIMPLEMENTEDFUNCTION"
		end
		
	Stg_e_invalidflag: INTEGER
			-- Invalid flag error.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INVALIDFLAG"
		end
		
	Stg_e_inuse: INTEGER
			-- Attempted to use an object that is busy.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_INUSE"
		end
		
	Stg_e_notcurrent: INTEGER
			-- The storage has been changed since the last commit.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_NOTCURRENT"
		end
		
	Stg_e_reverted: INTEGER
			-- Attempted to use an object that has ceased to exist.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_REVERTED"
		end
		
	Stg_e_cantsave: INTEGER
			-- Can't save.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_CANTSAVE"
		end
		
	Stg_e_oldformat: INTEGER
			-- The compound file %1 was produced with an incompatible version of storage.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_OLDFORMAT"
		end
		
	Stg_e_olddll: INTEGER
			-- The compound file %1 was produced with a newer version of storage.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_OLDDLL"
		end
		
	Stg_e_sharerequired: INTEGER
			-- Share.exe or equivalent is required for operation.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_SHAREREQUIRED"
		end
		
	Stg_e_notfilebasedstorage: INTEGER
			-- Illegal operation called on non-file based storage.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_NOTFILEBASEDSTORAGE"
		end
		
	Stg_e_extantmarshallings: INTEGER
			-- Illegal operation called on object with extant marshallings.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_E_EXTANTMARSHALLINGS"
		end
		
	Stg_s_converted: INTEGER
			-- The underlying file was converted to compound file format.
		external
			"C [macro <winerror.h>]"
		alias
			"STG_S_CONVERTED"
		end
		
	Rpc_e_call_rejected: INTEGER
			-- Remote procedure call errors
			-- Call was rejected by callee.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CALL_REJECTED"
		end
			

	Rpc_e_call_canceled: INTEGER
			-- Call was canceled by the message filter.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CALL_CANCELED"
		end
		
	Rpc_e_cantpost_insendcall: INTEGER
			-- The caller is dispatching an intertask SendMessage call and
			-- cannot call out via PostMessage.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CANTPOST_INSENDCALL"
		end
			

	Rpc_e_cantcallout_inasynccall: INTEGER
			-- The caller is dispatching an asynchronous call and cannot
			-- make an outgoing call on behalf of this call.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CANTCALLOUT_INASYNCCALL"
		end
			

	Rpc_e_cantcallout_inexternalcall: INTEGER
			-- It is illegal to call out while inside message filter.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CANTCALLOUT_INEXTERNALCALL"
		end
		
	Rpc_e_connection_terminated: INTEGER
			-- The connection terminated or is in a bogus state
			-- and cannot be used any more. Other connections
			-- are still valid.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CONNECTION_TERMINATED"
		end	

	Rpc_e_server_died: INTEGER
			-- The callee (server [not server application]) is not available
			-- and disappeared all connections are invalid.  The call may
			-- have executed.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_SERVER_DIED"
		end
			
	Rpc_e_client_died: INTEGER
			-- The caller (client) disappeared while the callee (server) was
			-- processing a call.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CLIENT_DIED"
		end
			

	Rpc_e_invalid_datapacket: INTEGER
			-- The data packet with the marshalled parameter data is incorrect.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_INVALID_DATAPACKET"
		end
		
	Rpc_e_canttransmit_call: INTEGER
			-- The call was not transmitted properly the message queue
			-- was full and was not emptied after yielding.		
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CANTTRANSMIT_CALL"
		end	

	Rpc_e_client_cantmarshal_data: INTEGER
			-- The client (caller) cannot marshall the parameter data - low memory, etc.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CLIENT_CANTMARSHAL_DATA"
		end
		
	Rpc_e_client_cantunmarshal_data: INTEGER
			-- The client (caller) cannot unmarshall the return data - low memory, etc.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CLIENT_CANTUNMARSHAL_DATA"
		end
		
	Rpc_e_server_cantmarshal_data: INTEGER
			-- The server (callee) cannot marshall the return data - low memory, etc.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_SERVER_CANTMARSHAL_DATA"
		end
		
	Rpc_e_server_cantunmarshal_data: INTEGER
			-- The server (callee) cannot unmarshall the parameter data - low memory, etc.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_SERVER_CANTUNMARSHAL_DATA"
		end
		
	Rpc_e_invalid_data: INTEGER
			-- Received data is invalid could be server or client data.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_INVALID_DATA"
		end
		
	Rpc_e_invalid_parameter: INTEGER
			-- A particular parameter is invalid and cannot be (un)marshalled.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_INVALID_PARAMETER"
		end
		
	Rpc_e_cantcallout_again: INTEGER
			-- There is no second outgoing call on same channel in DDE conversation.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CANTCALLOUT_AGAIN"
		end
		
	Rpc_e_server_died_dne: INTEGER
			-- The callee (server [not server application]) is not available
			-- and disappeared all connections are invalid.  The call did not execute.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_SERVER_DIED_DNE"
		end
			
	Rpc_e_sys_call_failed: INTEGER
			-- System call failed.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_SYS_CALL_FAILED"
		end
		
	Rpc_e_out_of_resources: INTEGER
			-- Could not allocate some required resource (memory, events, ...)
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_OUT_OF_RESOURCES"
		end
		
	Rpc_e_attempted_multithread: INTEGER
			-- Attempted to make calls on more than one thread in single threaded mode.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_ATTEMPTED_MULTITHREAD"
		end
		
	Rpc_e_not_registered: INTEGER
			-- The requested interface is not registered on the server object.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_NOT_REGISTERED"
		end
		
	Rpc_e_fault: INTEGER
			-- RPC could not call the server or could not return the results of calling the server.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_FAULT"
		end
		
	Rpc_e_serverfault: INTEGER
			-- The server threw an exception.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_SERVERFAULT"
		end
		
	Rpc_e_changed_mode: INTEGER
			-- Cannot change thread mode after it is set.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CHANGED_MODE"
		end
		
	Rpc_e_invalidmethod: INTEGER
			-- The method called does not exist on the server.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_INVALIDMETHOD"
		end
		
	Rpc_e_disconnected: INTEGER
			-- The object invoked has disconnected from its clients.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_DISCONNECTED"
		end
		
	Rpc_e_retry: INTEGER
			-- The object invoked chose not to process the call now.  Try again later.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_RETRY"
		end
		
	Rpc_e_servercall_retrylater: INTEGER
			-- The message filter indicated that the application is busy.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_SERVERCALL_RETRYLATER"
		end
		
	Rpc_e_servercall_rejected: INTEGER
			-- The message filter rejected the call.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_SERVERCALL_REJECTED"
		end
		
	Rpc_e_invalid_calldata: INTEGER
			-- A call control interfaces was called with invalid data.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_INVALID_CALLDATA"
		end
		
	Rpc_e_cantcallout_ininputsynccall: INTEGER
			-- An outgoing call cannot be made since the application is dispatching an input-synchronous call.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_CANTCALLOUT_ININPUTSYNCCALL"
		end
		
	Rpc_e_wrong_thread: INTEGER
			-- The application called an interface that was marshalled for a different thread.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_WRONG_THREAD"
		end
		
	Rpc_e_thread_not_init: INTEGER
			-- CoInitialize has not been called on the current thread.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_THREAD_NOT_INIT"
		end
		
	Rpc_e_unexpected: INTEGER
			-- An internal error occurred.
		external
			"C [macro <winerror.h>]"
		alias
			"RPC_E_UNEXPECTED"
		end
		
	E_end_of_stream: INTEGER = 114;
			-- End of stream has been reached while reading

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ECOM_EXCEPTION_CODES

