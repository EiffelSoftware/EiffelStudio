indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.SessionState.HttpSessionState"

external class
	SYSTEM_WEB_SESSIONSTATE_HTTPSESSIONSTATE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

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

	frozen get_static_objects: SYSTEM_WEB_HTTPSTATICOBJECTSCOLLECTION is
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

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Web.SessionState.HttpSessionState"
		alias
			"get_SyncRoot"
		end

	frozen get_mode: SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODE is
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

	frozen get_session_id: STRING is
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

	frozen get_contents: SYSTEM_WEB_SESSIONSTATE_HTTPSESSIONSTATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Web.SessionState.HttpSessionState"
		alias
			"get_Contents"
		end

	frozen get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Web.SessionState.HttpSessionState"
		alias
			"get_Item"
		end

	frozen get_keys: KEYSCOLLECTION_IN_SYSTEM_COLLECTIONS_SPECIALIZED_NAMEOBJECTCOLLECTIONBASE is
		external
			"IL signature (): System.Collections.Specialized.NameObjectCollectionBase+KeysCollection use System.Web.SessionState.HttpSessionState"
		alias
			"get_Keys"
		end

	frozen get_item_string (name: STRING): ANY is
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

	frozen set_item_string (name: STRING; value: ANY) is
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

	frozen set_item (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.Web.SessionState.HttpSessionState"
		alias
			"set_Item"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.SessionState.HttpSessionState"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.SessionState.HttpSessionState"
		alias
			"GetEnumerator"
		end

	frozen remove (name: STRING) is
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

	frozen add (name: STRING; value: ANY) is
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

end -- class SYSTEM_WEB_SESSIONSTATE_HTTPSESSIONSTATE
