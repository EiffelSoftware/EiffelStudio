indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ToolboxItemAttribute"

external class
	SYSTEM_COMPONENTMODEL_TOOLBOXITEMATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_toolboxitemattribute_1,
	make_toolboxitemattribute_2,
	make_toolboxitemattribute

feature {NONE} -- Initialization

	frozen make_toolboxitemattribute_1 (toolbox_item_type_name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.ToolboxItemAttribute"
		end

	frozen make_toolboxitemattribute_2 (toolbox_item_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.ToolboxItemAttribute"
		end

	frozen make_toolboxitemattribute (default_type: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ToolboxItemAttribute"
		end

feature -- Access

	frozen get_toolbox_item_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.ToolboxItemAttribute"
		alias
			"get_ToolboxItemTypeName"
		end

	frozen default: SYSTEM_COMPONENTMODEL_TOOLBOXITEMATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ToolboxItemAttribute use System.ComponentModel.ToolboxItemAttribute"
		alias
			"Default"
		end

	frozen get_toolbox_item_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.ToolboxItemAttribute"
		alias
			"get_ToolboxItemType"
		end

	frozen none: SYSTEM_COMPONENTMODEL_TOOLBOXITEMATTRIBUTE is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ToolboxItemAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_TOOLBOXITEMATTRIBUTE
