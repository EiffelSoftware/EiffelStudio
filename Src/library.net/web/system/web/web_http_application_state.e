indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpApplicationState"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_APPLICATION_STATE

inherit
	SYSTEM_DLL_NAME_OBJECT_COLLECTION_BASE
		redefine
			get_count
		end
	ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			copy_to as system_collections_icollection_copy_to
		end
	IENUMERABLE
	ISERIALIZABLE
	IDESERIALIZATION_CALLBACK

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Web.HttpApplicationState"
		alias
			"get_Item"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpApplicationState"
		alias
			"get_Count"
		end

	frozen get_static_objects: WEB_HTTP_STATIC_OBJECTS_COLLECTION is
		external
			"IL signature (): System.Web.HttpStaticObjectsCollection use System.Web.HttpApplicationState"
		alias
			"get_StaticObjects"
		end

	frozen get_contents: WEB_HTTP_APPLICATION_STATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Web.HttpApplicationState"
		alias
			"get_Contents"
		end

	frozen get_item_string (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.HttpApplicationState"
		alias
			"get_Item"
		end

	frozen get_all_keys: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpApplicationState"
		alias
			"get_AllKeys"
		end

feature -- Element Change

	frozen set_item (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.HttpApplicationState"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen get_key (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Web.HttpApplicationState"
		alias
			"GetKey"
		end

	frozen get_string (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.HttpApplicationState"
		alias
			"Get"
		end

	frozen get (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.Web.HttpApplicationState"
		alias
			"Get"
		end

	frozen remove (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpApplicationState"
		alias
			"Remove"
		end

	frozen remove_all is
		external
			"IL signature (): System.Void use System.Web.HttpApplicationState"
		alias
			"RemoveAll"
		end

	frozen un_lock is
		external
			"IL signature (): System.Void use System.Web.HttpApplicationState"
		alias
			"UnLock"
		end

	frozen add (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.HttpApplicationState"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.HttpApplicationState"
		alias
			"Clear"
		end

	frozen set (name: SYSTEM_STRING; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.HttpApplicationState"
		alias
			"Set"
		end

	frozen lock is
		external
			"IL signature (): System.Void use System.Web.HttpApplicationState"
		alias
			"Lock"
		end

	frozen remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.HttpApplicationState"
		alias
			"RemoveAt"
		end

end -- class WEB_HTTP_APPLICATION_STATE
