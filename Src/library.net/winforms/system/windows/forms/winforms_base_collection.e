indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.BaseCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_BASE_COLLECTION

inherit
	MARSHAL_BY_REF_OBJECT
	ICOLLECTION
	IENUMERABLE

create
	make_winforms_base_collection

feature {NONE} -- Initialization

	frozen make_winforms_base_collection is
		external
			"IL creator use System.Windows.Forms.BaseCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.BaseCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.BaseCollection"
		alias
			"get_SyncRoot"
		end

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.BaseCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.BaseCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Windows.Forms.BaseCollection"
		alias
			"GetEnumerator"
		end

	frozen copy_to (ar: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Windows.Forms.BaseCollection"
		alias
			"CopyTo"
		end

feature {NONE} -- Implementation

	get_list: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Windows.Forms.BaseCollection"
		alias
			"get_List"
		end

end -- class WINFORMS_BASE_COLLECTION
