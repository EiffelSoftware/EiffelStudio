indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ControlBuilderAttribute"

frozen external class
	SYSTEM_WEB_UI_CONTROLBUILDERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_controlbuilderattribute

feature {NONE} -- Initialization

	frozen make_controlbuilderattribute (builder_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Web.UI.ControlBuilderAttribute"
		end

feature -- Access

	frozen default: SYSTEM_WEB_UI_CONTROLBUILDERATTRIBUTE is
		external
			"IL static_field signature :System.Web.UI.ControlBuilderAttribute use System.Web.UI.ControlBuilderAttribute"
		alias
			"Default"
		end

	frozen get_builder_type: SYSTEM_TYPE is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ControlBuilderAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_WEB_UI_CONTROLBUILDERATTRIBUTE
