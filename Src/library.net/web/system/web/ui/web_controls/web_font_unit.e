indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.FontUnit"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen expanded external class
	WEB_FONT_UNIT

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end

feature -- Initialization

	frozen make_web_font_unit_4 (value: SYSTEM_STRING; culture: CULTURE_INFO) is
		external
			"IL creator signature (System.String, System.Globalization.CultureInfo) use System.Web.UI.WebControls.FontUnit"
		end

	frozen make_web_font_unit (type: WEB_FONT_SIZE) is
		external
			"IL creator signature (System.Web.UI.WebControls.FontSize) use System.Web.UI.WebControls.FontUnit"
		end

	frozen make_web_font_unit_1 (value: WEB_UNIT) is
		external
			"IL creator signature (System.Web.UI.WebControls.Unit) use System.Web.UI.WebControls.FontUnit"
		end

	frozen make_web_font_unit_3 (value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.WebControls.FontUnit"
		end

	frozen make_web_font_unit_2 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Web.UI.WebControls.FontUnit"
		end

feature -- Access

	frozen xsmall: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"XSmall"
		end

	frozen medium: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Medium"
		end

	frozen xxlarge: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"XXLarge"
		end

	frozen larger: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Larger"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.FontUnit"
		alias
			"get_IsEmpty"
		end

	frozen get_unit: WEB_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.FontUnit"
		alias
			"get_Unit"
		end

	frozen xlarge: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"XLarge"
		end

	frozen empty: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Empty"
		end

	frozen smaller: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Smaller"
		end

	frozen get_type_font_size: WEB_FONT_SIZE is
		external
			"IL signature (): System.Web.UI.WebControls.FontSize use System.Web.UI.WebControls.FontUnit"
		alias
			"get_Type"
		end

	frozen small: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Small"
		end

	frozen large: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Large"
		end

	frozen xxsmall: WEB_FONT_UNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"XXSmall"
		end

feature -- Basic Operations

	frozen point (n: INTEGER): WEB_FONT_UNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Point"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.FontUnit"
		alias
			"GetHashCode"
		end

	frozen to_string_culture_info (culture: CULTURE_INFO): SYSTEM_STRING is
		external
			"IL signature (System.Globalization.CultureInfo): System.String use System.Web.UI.WebControls.FontUnit"
		alias
			"ToString"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.FontUnit"
		alias
			"ToString"
		end

	frozen parse_string_culture_info (s: SYSTEM_STRING; culture: CULTURE_INFO): WEB_FONT_UNIT is
		external
			"IL static signature (System.String, System.Globalization.CultureInfo): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Parse"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.FontUnit"
		alias
			"Equals"
		end

	frozen parse (s: SYSTEM_STRING): WEB_FONT_UNIT is
		external
			"IL static signature (System.String): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Parse"
		end

feature -- Binary Operators

	frozen infix "#==" (right: WEB_FONT_UNIT): BOOLEAN is
		external
			"IL operator signature (System.Web.UI.WebControls.FontUnit): System.Boolean use System.Web.UI.WebControls.FontUnit"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: WEB_FONT_UNIT): BOOLEAN is
		external
			"IL operator signature (System.Web.UI.WebControls.FontUnit): System.Boolean use System.Web.UI.WebControls.FontUnit"
		alias
			"op_Inequality"
		end

feature -- Specials

	frozen op_implicit (n: INTEGER): WEB_FONT_UNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"op_Implicit"
		end

end -- class WEB_FONT_UNIT
