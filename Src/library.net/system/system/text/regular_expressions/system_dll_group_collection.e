indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.GroupCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_GROUP_COLLECTION

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

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.GroupCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (groupname: SYSTEM_STRING): SYSTEM_DLL_GROUP is
		external
			"IL signature (System.String): System.Text.RegularExpressions.Group use System.Text.RegularExpressions.GroupCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Text.RegularExpressions.GroupCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.GroupCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Text.RegularExpressions.GroupCollection"
		alias
			"get_IsReadOnly"
		end

	frozen get_item_int32 (groupnum: INTEGER): SYSTEM_DLL_GROUP is
		external
			"IL signature (System.Int32): System.Text.RegularExpressions.Group use System.Text.RegularExpressions.GroupCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Text.RegularExpressions.GroupCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Text.RegularExpressions.GroupCollection"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Text.RegularExpressions.GroupCollection"
		alias
			"ToString"
		end

	frozen copy_to (array: SYSTEM_ARRAY; array_index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Text.RegularExpressions.GroupCollection"
		alias
			"CopyTo"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Text.RegularExpressions.GroupCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Text.RegularExpressions.GroupCollection"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_GROUP_COLLECTION
