indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.SearchResultCollection"

external class
	SYSTEM_DIRECTORYSERVICES_SEARCHRESULTCOLLECTION

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DIRECTORYSERVICES_SEARCHRESULT is
		external
			"IL signature (System.Int32): System.DirectoryServices.SearchResult use System.DirectoryServices.SearchResultCollection"
		alias
			"get_Item"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.DirectoryServices.SearchResultCollection"
		alias
			"get_Count"
		end

	frozen get_properties_loaded: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.DirectoryServices.SearchResultCollection"
		alias
			"get_PropertiesLoaded"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.DirectoryServices.SearchResultCollection"
		alias
			"get_Handle"
		end

feature -- Basic Operations

	frozen dispose is
		external
			"IL signature (): System.Void use System.DirectoryServices.SearchResultCollection"
		alias
			"Dispose"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.DirectoryServices.SearchResultCollection"
		alias
			"GetEnumerator"
		end

	frozen contains (result_: SYSTEM_DIRECTORYSERVICES_SEARCHRESULT): BOOLEAN is
		external
			"IL signature (System.DirectoryServices.SearchResult): System.Boolean use System.DirectoryServices.SearchResultCollection"
		alias
			"Contains"
		end

	frozen index_of (result_: SYSTEM_DIRECTORYSERVICES_SEARCHRESULT): INTEGER is
		external
			"IL signature (System.DirectoryServices.SearchResult): System.Int32 use System.DirectoryServices.SearchResultCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (results: ARRAY [SYSTEM_DIRECTORYSERVICES_SEARCHRESULT]; index: INTEGER) is
		external
			"IL signature (System.DirectoryServices.SearchResult[], System.Int32): System.Void use System.DirectoryServices.SearchResultCollection"
		alias
			"CopyTo"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.DirectoryServices.SearchResultCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	frozen dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.DirectoryServices.SearchResultCollection"
		alias
			"Dispose"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.DirectoryServices.SearchResultCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	finalize is
		external
			"IL signature (): System.Void use System.DirectoryServices.SearchResultCollection"
		alias
			"Finalize"
		end

	frozen system_collections_icollection_get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.DirectoryServices.SearchResultCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

end -- class SYSTEM_DIRECTORYSERVICES_SEARCHRESULTCOLLECTION
