indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.BaseCollection"

external class
	SYSTEM_WINDOWS_FORMS_BASECOLLECTION

inherit
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION

create
	make_basecollection

feature {NONE} -- Initialization

	frozen make_basecollection is
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

	frozen get_sync_root: ANY is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
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

	get_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Windows.Forms.BaseCollection"
		alias
			"get_List"
		end

end -- class SYSTEM_WINDOWS_FORMS_BASECOLLECTION
