indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.CodeNamespaceImportCollection"

external class
	SYSTEM_CODEDOM_CODENAMESPACEIMPORTCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ILIST
		rename
			prune_i_th as ilist_prune_i_th,
			remove as ilist_remove,
			insert as ilist_insert,
			index_of as ilist_index_of,
			has as ilist_has,
			clear as ilist_clear,
			extend as ilist_extend,
			get_enumerator as ienumerable_get_enumerator,
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_count as icollection_get_count,
			put_i_th as ilist_put_i_th,
			get_item as ilist_get_item,
			get_is_fixed_size as ilist_get_is_fixed_size,
			get_is_read_only as ilist_get_is_read_only
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as ienumerable_get_enumerator
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_enumerator as ienumerable_get_enumerator,
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized,
			get_count as icollection_get_count
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.CodeDom.CodeNamespaceImportCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_CODENAMESPACEIMPORT is
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

	frozen put_i_th (index: INTEGER; value: SYSTEM_CODEDOM_CODENAMESPACEIMPORT) is
		external
			"IL signature (System.Int32, System.CodeDom.CodeNamespaceImport): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_range (value: ARRAY [SYSTEM_CODEDOM_CODENAMESPACEIMPORT]) is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"ToString"
		end

	frozen extend (value: SYSTEM_CODEDOM_CODENAMESPACEIMPORT) is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen ilist_prune_i_th (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.RemoveAt"
		end

	frozen ilist_put_i_th (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.set_Item"
		end

	frozen icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen ilist_remove (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Remove"
		end

	frozen icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen ilist_insert (index: INTEGER; value: ANY) is
		external
			"IL signature (System.Int32, System.Object): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Insert"
		end

	frozen ilist_extend (value: ANY): INTEGER is
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

	frozen ilist_get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.get_Item"
		end

	frozen ilist_get_is_fixed_size: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.get_IsFixedSize"
		end

	frozen icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen ilist_has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Contains"
		end

	frozen ilist_index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.IndexOf"
		end

	frozen icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen ilist_clear is
		external
			"IL signature (): System.Void use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.Clear"
		end

	frozen ilist_get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.CodeNamespaceImportCollection"
		alias
			"System.Collections.IList.get_IsReadOnly"
		end

end -- class SYSTEM_CODEDOM_CODENAMESPACEIMPORTCOLLECTION
