indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.SessionState.HttpSessionState"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_SESSION_STATE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_is_new_session: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.SessionState.HttpSessionState"
		alias
			"get_IsNewSession"
		end

	frozen get_lcid: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.SessionState.HttpSessionState"
		alias
			"get_LCID"
		end

	frozen get_is_cookieless: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.SessionState.HttpSessionState"
		alias
			"get_IsCookieless"
		end

	frozen get_static_objects: WEB_HTTP_STATIC_OBJECTS_COLLECTION is
		external
			"IL signature (): System.Web.HttpStaticObjectsCollection use System.Web.SessionState.HttpSessionState"
		alias
			"get_StaticObjects"
		end

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.SessionState.HttpSessionState"
		alias
			"get_IsSynchronized"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.SessionState.HttpSessionState"
		alias
			"get_SyncRoot"
		end

	frozen get_mode: WEB_SESSION_STATE_MODE is
		external
			"IL signature (): System.Web.SessionState.SessionStateMode use System.Web.SessionState.HttpSessionState"
		alias
			"get_Mode"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.SessionState.HttpSessionState"
		alias
			"get_Count"
		end

	frozen get_session_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.SessionState.HttpSessionState"
		alias
			"get_SessionID"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.SessionState.HttpSessionState"
		alias
			"get_IsReadOnly"
		end

	frozen get_code_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.SessionState.HttpSessionState"
		alias
			"get_CodePage"
		end

	frozen get_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.SessionState.HttpSessionState"
		alias
			"get_Timeout"
		end

	frozen get_contents: WEB_HTTP_SESSION_STATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Web.SessionState.HttpSessionState"
		alias
			"get_Contents"
		end

	frozen get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Web.SessionState.HttpSessionState"
		alias
			"get_Item"
		end

	frozen get_keys: SYSTEM_DLL_KEYS_COLLECTION_IN_SYSTEM_DLL_NAME_OBJECT_COLLECTION_BASE is
		external
			"IL signature (): System.Collections.Specialized.NameObjectCollectionBase+KeysCollection use System.Web.SessionState.HttpSessionState"
		alias
			"get_Keys"
		end

	frozen get_item_string (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.SessionState.HttpSessionState"
		alias
			"get_Item"
		end

feature -- Element Change

	frozen set_code_page (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"set_CodePage"
		end

	frozen set_lcid (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"set_LCID"
		end

	frozen set_item_string (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"set_Item"
		end

	frozen set_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"set_Timeout"
		end

	frozen set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.SessionState.HttpSessionState"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.SessionState.HttpSessionState"
		alias
			"Equals"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"CopyTo"
		end

	frozen abandon is
		external
			"IL signature (): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"Abandon"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.SessionState.HttpSessionState"
		alias
			"GetEnumerator"
		end

	frozen remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"Remove"
		end

	frozen remove_all is
		external
			"IL signature (): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"RemoveAll"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"RemoveAt"
		end

	frozen add (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"Clear"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.SessionState.HttpSessionState"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"Finalize"
		end

end -- class WEB_HTTP_SESSION_STATE
