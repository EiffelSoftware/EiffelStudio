indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.DataBinding"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DATA_BINDING

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals
		end

create
	make

feature {NONE} -- Initialization

	frozen make (property_name: SYSTEM_STRING; property_type: TYPE; expression: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.Type, System.String) use System.Web.UI.DataBinding"
		end

feature -- Access

	frozen get_property_type: TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.DataBinding"
		alias
			"get_PropertyType"
		end

	frozen get_expression: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBinding"
		alias
			"get_Expression"
		end

	frozen get_property_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBinding"
		alias
			"get_PropertyName"
		end

feature -- Element Change

	frozen set_expression (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.DataBinding"
		alias
			"set_Expression"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.DataBinding"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.DataBinding"
		alias
			"Equals"
		end

end -- class WEB_DATA_BINDING
