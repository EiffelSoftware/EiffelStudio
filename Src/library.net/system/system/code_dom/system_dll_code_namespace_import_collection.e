indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeNamespaceImportCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_NAMESPACE_IMPORT_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ILIST
		rename
			remove_at as system_collections_ilist_remove_at,
			remove as system_collections_ilist_remove,
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			contains as system_collections_ilist_contains,
			clear as system_collections_ilist_clear,
			add as system_collections_ilist_add,
			get_enumerator as system_collections_ienumerable_get_enumerator,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_count as system_collections_icollection_get_count,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
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
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.CodeDom.CodeNamespaceImportCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_CODE_NAMESPACE_IMPORT is
		external
			"IL signature (System.Int32): System.CodeDom.CodeNamespaceImport use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"get_Count"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DLL_CODE_NAMESPACE_IMPORT) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeNamespaceImport): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range (value: NATIVE_ARRAY [SYSTEM_DLL_CODE_NAMESPACE_IMPORT]) is
		external
			"IL signature (System.CodeDom.CodeNamespaceImport[]): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"AddRange"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"ToString"
		end

	frozen add (value: SYSTEM_DLL_CODE_NAMESPACE_IMPORT) is
		external
			"IL signature (System.CodeDom.CodeNamespaceImport): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"Clear"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_ilist_remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen system_collections_ilist_set_item (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen system_collections_ilist_remove (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_ilist_insert (index: INTEGER; value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Insert"
		end

	frozen system_collections_ilist_add (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Add"
		end

	finalize is
		external
			"IL signature (): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"Finalize"
		end

	frozen system_collections_ilist_get_item (index: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.Int32): System.Object use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen system_collections_ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_collections_ilist_contains (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen system_collections_ilist_index_of (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_ilist_clear is
		external
			"IL signature (): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen system_collections_ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

end -- class SYSTEM_DLL_CODE_NAMESPACE_IMPORT_COLLECTION
