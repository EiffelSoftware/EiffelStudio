indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpStaticObjectsCollection"

frozen external class
	SYSTEM_WEB_HTTPSTATICOBJECTSCOLLECTION

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

	frozen get_item (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.HttpStaticObjectsCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.HttpStaticObjectsCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.HttpStaticObjectsCollection"
		alias
			"Equals"
		end

	frozen get_object (name: STRING): ANY is
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

end -- class SYSTEM_WEB_HTTPSTATICOBJECTSCOLLECTION
