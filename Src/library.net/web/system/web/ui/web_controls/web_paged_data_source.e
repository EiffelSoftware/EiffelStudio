indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.PagedDataSource"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_PAGED_DATA_SOURCE

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
	SYSTEM_DLL_ITYPED_LIST

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.WebControls.PagedDataSource"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_IsSynchronized"
		end

	frozen get_data_source: IENUMERABLE is
		external
			"IL signature (): System.Collections.IEnumerable use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_DataSource"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_SyncRoot"
		end

	frozen get_data_source_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_DataSourceCount"
		end

	frozen get_is_first_page: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_IsFirstPage"
		end

	frozen get_page_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_PageSize"
		end

	frozen get_is_custom_paging_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_IsCustomPagingEnabled"
		end

	frozen get_current_page_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_CurrentPageIndex"
		end

	frozen get_is_last_page: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_IsLastPage"
		end

	frozen get_allow_custom_paging: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_AllowCustomPaging"
		end

	frozen get_is_paging_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_IsPagingEnabled"
		end

	frozen get_first_index_in_page: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_FirstIndexInPage"
		end

	frozen get_virtual_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_VirtualCount"
		end

	frozen get_page_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_PageCount"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_IsReadOnly"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_Count"
		end

	frozen get_allow_paging: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_AllowPaging"
		end

feature -- Element Change

	frozen set_allow_custom_paging (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.PagedDataSource"
		alias
			"set_AllowCustomPaging"
		end

	frozen set_page_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.PagedDataSource"
		alias
			"set_PageSize"
		end

	frozen set_current_page_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.PagedDataSource"
		alias
			"set_CurrentPageIndex"
		end

	frozen set_virtual_count (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Web.UI.WebControls.PagedDataSource"
		alias
			"set_VirtualCount"
		end

	frozen set_data_source (value: IENUMERABLE) is
		external
			"IL signature (System.Collections.IEnumerable): System.Void use System.Web.UI.WebControls.PagedDataSource"
		alias
			"set_DataSource"
		end

	frozen set_allow_paging (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.PagedDataSource"
		alias
			"set_AllowPaging"
		end

feature -- Basic Operations

	frozen get_list_name (list_accessors: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_DESCRIPTOR]): SYSTEM_STRING is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.String use System.Web.UI.WebControls.PagedDataSource"
		alias
			"GetListName"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.PagedDataSource"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.WebControls.PagedDataSource"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.PagedDataSource"
		alias
			"ToString"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.WebControls.PagedDataSource"
		alias
			"CopyTo"
		end

	frozen get_item_properties (list_accessors: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_DESCRIPTOR]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.ComponentModel.PropertyDescriptorCollection use System.Web.UI.WebControls.PagedDataSource"
		alias
			"GetItemProperties"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.PagedDataSource"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.WebControls.PagedDataSource"
		alias
			"Finalize"
		end

end -- class WEB_PAGED_DATA_SOURCE
