indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpApplicationState"

frozen external class
	SYSTEM_WEB_HTTPAPPLICATIONSTATE

inherit
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as icollection_get_is_synchronized,
			get_sync_root as icollection_get_sync_root,
			copy_to as icollection_copy_to
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
	SYSTEM_COLLECTIONS_SPECIALIZED_NAMEOBJECTCOLLECTIONBASE
		redefine
			get_count
		end

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): ANY is
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

	frozen get_static_objects: SYSTEM_WEB_HTTPSTATICOBJECTSCOLLECTION is
		external
			"IL signature (): System.Web.HttpStaticObjectsCollection use System.Web.HttpApplicationState"
		alias
			"get_StaticObjects"
		end

	frozen get_contents: SYSTEM_WEB_HTTPAPPLICATIONSTATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Web.HttpApplicationState"
		alias
			"get_Contents"
		end

	frozen get_item_string (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.HttpApplicationState"
		alias
			"get_Item"
		end

	frozen get_all_keys: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpApplicationState"
		alias
			"get_AllKeys"
		end

feature -- Element Change

	frozen put_i_th (name: STRING; value: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Web.HttpApplicationState"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen get_key (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Web.HttpApplicationState"
		alias
			"GetKey"
		end

	frozen get_string (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.HttpApplicationState"
		alias
			"Get"
		end

	frozen get (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Web.HttpApplicationState"
		alias
			"Get"
		end

	frozen remove (name: STRING) is
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

	frozen extend (name: STRING; value: ANY) is
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

	frozen set (name: STRING; value: ANY) is
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

	frozen prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.HttpApplicationState"
		alias
			"RemoveAt"
		end

end -- class SYSTEM_WEB_HTTPAPPLICATIONSTATE
