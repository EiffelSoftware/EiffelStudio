indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.DesignerCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DESIGNER_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (designers: NATIVE_ARRAY [SYSTEM_DLL_IDESIGNER_HOST]) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost[]) use System.ComponentModel.Design.DesignerCollection"
		end

	frozen make_1 (designers: ILIST) is
		external
			"IL creator signature (System.Collections.IList) use System.ComponentModel.Design.DesignerCollection"
		end

feature -- Access

	get_item (index: INTEGER): SYSTEM_DLL_IDESIGNER_HOST is
		external
			"IL signature (System.Int32): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.DesignerCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.DesignerCollection"
		alias
			"get_Count"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.DesignerCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.Design.DesignerCollection"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.DesignerCollection"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Design.DesignerCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.DesignerCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.ComponentModel.Design.DesignerCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_DLL_DESIGNER_COLLECTION
