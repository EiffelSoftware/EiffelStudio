indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.FontUnit"

frozen expanded external class
	SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal,
			to_string
		end



feature -- Initialization

	frozen make_fontunit_3 (value: STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.WebControls.FontUnit"
		end

	frozen make_fontunit_2 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Web.UI.WebControls.FontUnit"
		end

	frozen make_fontunit (type: SYSTEM_WEB_UI_WEBCONTROLS_FONTSIZE) is
		external
			"IL creator signature (System.Web.UI.WebControls.FontSize) use System.Web.UI.WebControls.FontUnit"
		end

	frozen make_fontunit_4 (value: STRING; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL creator signature (System.String, System.Globalization.CultureInfo) use System.Web.UI.WebControls.FontUnit"
		end

	frozen make_fontunit_1 (value: SYSTEM_WEB_UI_WEBCONTROLS_UNIT) is
		external
			"IL creator signature (System.Web.UI.WebControls.Unit) use System.Web.UI.WebControls.FontUnit"
		end

feature -- Access

	frozen xsmall: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"XSmall"
		end

	frozen medium: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Medium"
		end

	frozen xxlarge: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"XXLarge"
		end

	frozen larger: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
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

	frozen get_unit: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.FontUnit"
		alias
			"get_Unit"
		end

	frozen xlarge: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"XLarge"
		end

	frozen empty: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Empty"
		end

	frozen smaller: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Smaller"
		end

	frozen get_type_font_size: SYSTEM_WEB_UI_WEBCONTROLS_FONTSIZE is
		external
			"IL signature (): System.Web.UI.WebControls.FontSize use System.Web.UI.WebControls.FontUnit"
		alias
			"get_Type"
		end

	frozen small: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Small"
		end

	frozen large: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Large"
		end

	frozen xxsmall: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static_field signature :System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"XXSmall"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.WebControls.FontUnit"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.FontUnit"
		alias
			"Equals"
		end

	frozen to_string_culture_info (culture: SYSTEM_GLOBALIZATION_CULTUREINFO): STRING is
		external
			"IL signature (System.Globalization.CultureInfo): System.String use System.Web.UI.WebControls.FontUnit"
		alias
			"ToString"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.FontUnit"
		alias
			"ToString"
		end

	frozen parse_string_culture_info (s: STRING; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static signature (System.String, System.Globalization.CultureInfo): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Parse"
		end

	frozen point (n: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Point"
		end

	frozen parse (s: STRING): SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static signature (System.String): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"Parse"
		end

feature -- Binary Operators

	frozen infix "#==" (right: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT): BOOLEAN is
		external
			"IL operator  signature (System.Web.UI.WebControls.FontUnit): System.Boolean use System.Web.UI.WebControls.FontUnit"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT): BOOLEAN is
		external
			"IL operator  signature (System.Web.UI.WebControls.FontUnit): System.Boolean use System.Web.UI.WebControls.FontUnit"
		alias
			"op_Inequality"
		end

feature -- Specials

	frozen op_implicit (n: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontUnit"
		alias
			"op_Implicit"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT
