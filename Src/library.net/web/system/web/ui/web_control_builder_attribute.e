indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ControlBuilderAttribute"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_CONTROL_BUILDER_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_web_control_builder_attribute

feature {NONE} -- Initialization

	frozen make_web_control_builder_attribute (builder_type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Web.UI.ControlBuilderAttribute"
		end

feature -- Access

	frozen default_: WEB_CONTROL_BUILDER_ATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.ControlBuilderAttribute use System.Web.UI.ControlBuilderAttribute"
		alias
			"Default"
		end

	frozen get_builder_type: TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.ControlBuilderAttribute"
		alias
			"get_BuilderType"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ControlBuilderAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.ControlBuilderAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ControlBuilderAttribute"
		alias
			"Equals"
		end

end -- class WEB_CONTROL_BUILDER_ATTRIBUTE
