indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.DataBinding"

frozen external class
	SYSTEM_WEB_UI_DATABINDING

inherit
	ANY
		rename
			equals as equals_object
		redefine
			get_hash_code,
			equals_object
		end

create
	make

feature {NONE} -- Initialization

	frozen make (property_name: STRING; property_type: SYSTEM_TYPE; expression: STRING) is
		external
			"IL creator signature (System.String, System.Type, System.String) use System.Web.UI.DataBinding"
		end

feature -- Access

	frozen get_property_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Web.UI.DataBinding"
		alias
			"get_PropertyType"
		end

	frozen get_expression: STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBinding"
		alias
			"get_Expression"
		end

	frozen get_property_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBinding"
		alias
			"get_PropertyName"
		end

feature -- Element Change

	frozen set_expression (value: STRING) is
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

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.DataBinding"
		alias
			"Equals"
		end

end -- class SYSTEM_WEB_UI_DATABINDING
