indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.PagedDataSource"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_PAGEDDATASOURCE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COMPONENTMODEL_ITYPEDLIST
	SYSTEM_COLLECTIONS_IENUMERABLE

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

	frozen get_data_source: SYSTEM_COLLECTIONS_IENUMERABLE is
		external
			"IL signature (): System.Collections.IEnumerable use System.Web.UI.WebControls.PagedDataSource"
		alias
			"get_DataSource"
		end

	frozen get_sync_root: ANY is
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

	frozen set_data_source (value: SYSTEM_COLLECTIONS_IENUMERABLE) is
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

	frozen get_list_name (list_accessors: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR]): STRING is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.WebControls.PagedDataSource"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
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

	frozen get_item_properties (list_accessors: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL signature (System.ComponentModel.PropertyDescriptor[]): System.ComponentModel.PropertyDescriptorCollection use System.Web.UI.WebControls.PagedDataSource"
		alias
			"GetItemProperties"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_WEB_UI_WEBCONTROLS_PAGEDDATASOURCE
