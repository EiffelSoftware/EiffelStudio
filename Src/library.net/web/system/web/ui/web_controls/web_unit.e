indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.Unit"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	WEB_UNIT

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_web_unit_1 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Web.UI.WebControls.Unit"
		end

	frozen make_web_unit_3 (value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.WebControls.Unit"
		end

	frozen make_web_unit_2 (value: DOUBLE; type: WEB_UNIT_TYPE) is
		external
			"IL creator signature (System.Double, System.Web.UI.WebControls.UnitType) use System.Web.UI.WebControls.Unit"
		end

	frozen make_web_unit_4 (value: SYSTEM_STRING; culture: CULTURE_INFO) is
		external
			"IL creator signature (System.String, System.Globalization.CultureInfo) use System.Web.UI.WebControls.Unit"
		end

	frozen make_web_unit (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Web.UI.WebControls.Unit"
		end

feature -- Access

	frozen empty: WEB_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Empty"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.Unit"
		alias
			"get_IsEmpty"
		end

	frozen get_value: DOUBLE is
		external
			"IL signature (): System.Double use System.Web.UI.WebControls.Unit"
		alias
			"get_Value"
		end

	frozen get_type_unit_type: WEB_UNIT_TYPE is
		external
			"IL signature (): System.Web.UI.WebControls.UnitType use System.Web.UI.WebControls.Unit"
		alias
			"get_Type"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Unit"
		alias
			"ToString"
		end

	frozen parse_string_culture_info (s: SYSTEM_STRING; culture: CULTURE_INFO): WEB_UNIT is
		external
			"IL static signature (System.String, System.Globalization.CultureInfo): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Parse"
		end

	frozen pixel (n: INTEGER): WEB_UNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Pixel"
		end

	frozen percentage (n: DOUBLE): WEB_UNIT is
		external
			"IL static signature (System.Double): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Percentage"
		end

	frozen point (n: INTEGER): WEB_UNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Point"
		end

	frozen parse (s: SYSTEM_STRING): WEB_UNIT is
		external
			"IL static signature (System.String): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Parse"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.Unit"
		alias
			"Equals"
		end

	frozen to_string_culture_info (culture: CULTURE_INFO): SYSTEM_STRING is
		external
			"IL signature (System.Globalization.CultureInfo): System.String use System.Web.UI.WebControls.Unit"
		alias
			"ToString"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.Unit"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix "#==" (right: WEB_UNIT): BOOLEAN is
		external
			"IL operator signature (System.Web.UI.WebControls.Unit): System.Boolean use System.Web.UI.WebControls.Unit"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: WEB_UNIT): BOOLEAN is
		external
			"IL operator signature (System.Web.UI.WebControls.Unit): System.Boolean use System.Web.UI.WebControls.Unit"
		alias
			"op_Inequality"
		end

feature -- Specials

	frozen op_implicit (n: INTEGER): WEB_UNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"op_Implicit"
		end

end -- class WEB_UNIT
