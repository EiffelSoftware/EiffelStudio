indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ToolboxItemFilterAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_TOOLBOXITEMFILTERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			match,
			get_type_id,
			get_hash_code,
			equals_object
		end

create
	make_toolboxitemfilterattribute,
	make_toolboxitemfilterattribute_1

feature {NONE} -- Initialization

	frozen make_toolboxitemfilterattribute (filter_string: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.ToolboxItemFilterAttribute"
		end

	frozen make_toolboxitemfilterattribute_1 (filter_string: STRING; filter_type: SYSTEM_COMPONENTMODEL_TOOLBOXITEMFILTERTYPE) is
		external
			"IL creator signature (System.String, System.ComponentModel.ToolboxItemFilterType) use System.ComponentModel.ToolboxItemFilterAttribute"
		end

feature -- Access

	frozen get_filter_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"get_FilterString"
		end

	frozen get_filter_type: SYSTEM_COMPONENTMODEL_TOOLBOXITEMFILTERTYPE is
		external
			"IL signature (): System.ComponentModel.ToolboxItemFilterType use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"get_FilterType"
		end

	get_type_id: ANY is
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

	match (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"Match"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ToolboxItemFilterAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_TOOLBOXITEMFILTERATTRIBUTE
