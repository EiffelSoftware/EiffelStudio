indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ToolboxItemAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TOOLBOX_ITEM_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_toolbox_item_attribute_1,
	make_system_dll_toolbox_item_attribute,
	make_system_dll_toolbox_item_attribute_2

feature {NONE} -- Initialization

	frozen make_system_dll_toolbox_item_attribute_1 (toolbox_item_type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.ToolboxItemAttribute"
		end

	frozen make_system_dll_toolbox_item_attribute (default_type: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ToolboxItemAttribute"
		end

	frozen make_system_dll_toolbox_item_attribute_2 (toolbox_item_type: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.ToolboxItemAttribute"
		end

feature -- Access

	frozen get_toolbox_item_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.ToolboxItemAttribute"
		alias
			"get_ToolboxItemTypeName"
		end

	frozen default_: SYSTEM_DLL_TOOLBOX_ITEM_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ToolboxItemAttribute use System.ComponentModel.ToolboxItemAttribute"
		alias
			"Default"
		end

	frozen get_toolbox_item_type: TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.ToolboxItemAttribute"
		alias
			"get_ToolboxItemType"
		end

	frozen none: SYSTEM_DLL_TOOLBOX_ITEM_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ToolboxItemAttribute use System.ComponentModel.ToolboxItemAttribute"
		alias
			"None"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ToolboxItemAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ToolboxItemAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ToolboxItemAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_TOOLBOX_ITEM_ATTRIBUTE
