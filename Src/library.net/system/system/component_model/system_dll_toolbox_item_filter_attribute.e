indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ToolboxItemFilterAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_TOOLBOX_ITEM_FILTER_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			match,
			get_type_id,
			get_hash_code,
			equals
		end

create
	make_system_dll_toolbox_item_filter_attribute,
	make_system_dll_toolbox_item_filter_attribute_1

feature {NONE} -- Initialization

	frozen make_system_dll_toolbox_item_filter_attribute (filter_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.ToolboxItemFilterAttribute"
		end

	frozen make_system_dll_toolbox_item_filter_attribute_1 (filter_string: SYSTEM_STRING; filter_type: SYSTEM_DLL_TOOLBOX_ITEM_FILTER_TYPE) is
		external
			"IL creator signature (System.String, System.ComponentModel.ToolboxItemFilterType) use System.ComponentModel.ToolboxItemFilterAttribute"
		end

feature -- Access

	frozen get_filter_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"get_FilterString"
		end

	frozen get_filter_type: SYSTEM_DLL_TOOLBOX_ITEM_FILTER_TYPE is
		external
			"IL signature (): System.ComponentModel.ToolboxItemFilterType use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"get_FilterType"
		end

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"GetHashCode"
		end

	match (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"Match"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_TOOLBOX_ITEM_FILTER_ATTRIBUTE
