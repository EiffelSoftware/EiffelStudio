indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ToolboxDataAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_TOOLBOX_DATA_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_web_toolbox_data_attribute

feature {NONE} -- Initialization

	frozen make_web_toolbox_data_attribute (data: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.ToolboxDataAttribute"
		end

feature -- Access

	frozen default_: WEB_TOOLBOX_DATA_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.ToolboxDataAttribute use System.Web.UI.ToolboxDataAttribute"
		alias
			"Default"
		end

	frozen get_data: SYSTEM_STRING is
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

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ToolboxDataAttribute"
		alias
			"Equals"
		end

end -- class WEB_TOOLBOX_DATA_ATTRIBUTE
