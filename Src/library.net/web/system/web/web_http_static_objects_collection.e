indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpStaticObjectsCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_STATIC_OBJECTS_COLLECTION

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

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.HttpStaticObjectsCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpStaticObjectsCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.HttpStaticObjectsCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.HttpStaticObjectsCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpStaticObjectsCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpStaticObjectsCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpStaticObjectsCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.HttpStaticObjectsCollection"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpStaticObjectsCollection"
		alias
			"ToString"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.HttpStaticObjectsCollection"
		alias
			"CopyTo"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.HttpStaticObjectsCollection"
		alias
			"Equals"
		end

	frozen get_object (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Web.HttpStaticObjectsCollection"
		alias
			"GetObject"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.HttpStaticObjectsCollection"
		alias
			"Finalize"
		end

end -- class WEB_HTTP_STATIC_OBJECTS_COLLECTION
