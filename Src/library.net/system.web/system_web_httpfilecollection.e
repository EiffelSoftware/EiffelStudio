indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpFileCollection"

frozen external class
	SYSTEM_WEB_HTTPFILECOLLECTION

inherit
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			copy_to as system_collections_icollection_copy_to
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
	SYSTEM_COLLECTIONS_SPECIALIZED_NAMEOBJECTCOLLECTIONBASE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_WEB_HTTPPOSTEDFILE is
		external
			"IL signature (System.Int32): System.Web.HttpPostedFile use System.Web.HttpFileCollection"
		alias
			"get_Item"
		end

	frozen get_item_string (name: STRING): SYSTEM_WEB_HTTPPOSTEDFILE is
		external
			"IL signature (System.String): System.Web.HttpPostedFile use System.Web.HttpFileCollection"
		alias
			"get_Item"
		end

	frozen get_all_keys: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Web.HttpFileCollection"
		alias
			"get_AllKeys"
		end

feature -- Basic Operations

	frozen get_key (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Web.HttpFileCollection"
		alias
			"GetKey"
		end

	frozen copy_to (dest: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.HttpFileCollection"
		alias
			"CopyTo"
		end

	frozen get (index: INTEGER): SYSTEM_WEB_HTTPPOSTEDFILE is
		external
			"IL signature (System.Int32): System.Web.HttpPostedFile use System.Web.HttpFileCollection"
		alias
			"Get"
		end

	frozen get_string (name: STRING): SYSTEM_WEB_HTTPPOSTEDFILE is
		external
			"IL signature (System.String): System.Web.HttpPostedFile use System.Web.HttpFileCollection"
		alias
			"Get"
		end

end -- class SYSTEM_WEB_HTTPFILECOLLECTION
