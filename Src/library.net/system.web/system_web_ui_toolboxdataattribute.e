indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ToolboxDataAttribute"

frozen external class
	SYSTEM_WEB_UI_TOOLBOXDATAATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals_object
		end

create
	make_toolboxdataattribute

feature {NONE} -- Initialization

	frozen make_toolboxdataattribute (data: STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.ToolboxDataAttribute"
		end

feature -- Access

	frozen default: SYSTEM_WEB_UI_TOOLBOXDATAATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.ToolboxDataAttribute use System.Web.UI.ToolboxDataAttribute"
		alias
			"Default"
		end

	frozen get_data: STRING is
		external
			"IL signature (): System.String use System.Web.UI.ToolboxDataAttribute"
		alias
			"get_Data"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ToolboxDataAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.ToolboxDataAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ToolboxDataAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_WEB_UI_TOOLBOXDATAATTRIBUTE
