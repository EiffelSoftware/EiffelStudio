indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.Unit"

frozen expanded external class
	SYSTEM_WEB_UI_WEBCONTROLS_UNIT

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals_object,
			to_string
		end



feature -- Initialization

	frozen make_unit_1 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Web.UI.WebControls.Unit"
		end

	frozen make_unit_4 (value: STRING; culture: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL creator signature (System.String, System.Globalization.CultureInfo) use System.Web.UI.WebControls.Unit"
		end

	frozen make_unit_2 (value: DOUBLE; type: SYSTEM_WEB_UI_WEBCONTROLS_UNITTYPE) is
		external
			"IL creator signature (System.Double, System.Web.UI.WebControls.UnitType) use System.Web.UI.WebControls.Unit"
		end

	frozen make_unit_3 (value: STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.WebControls.Unit"
		end

	frozen make_unit (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Web.UI.WebControls.Unit"
		end

feature -- Access

	frozen empty: SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
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

	frozen get_type_unit_type: SYSTEM_WEB_UI_WEBCONTROLS_UNITTYPE is
		external
			"IL signature (): System.Web.UI.WebControls.UnitType use System.Web.UI.WebControls.Unit"
		alias
			"get_Type"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Unit"
		alias
			"ToString"
		end

	frozen parse_string_culture_info (s: STRING; culture: SYSTEM_GLOBALIZATION_CULTUREINFO): SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL static signature (System.String, System.Globalization.CultureInfo): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Parse"
		end

	frozen pixel (n: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Pixel"
		end

	frozen percentage (n: DOUBLE): SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL static signature (System.Double): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Percentage"
		end

	frozen point (n: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Point"
		end

	frozen parse (s: STRING): SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL static signature (System.String): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"Parse"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.WebControls.Unit"
		alias
			"Equals"
		end

	frozen to_string_culture_info (culture: SYSTEM_GLOBALIZATION_CULTUREINFO): STRING is
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

	frozen infix "#==" (right: SYSTEM_WEB_UI_WEBCONTROLS_UNIT): BOOLEAN is
		external
			"IL operator  signature (System.Web.UI.WebControls.Unit): System.Boolean use System.Web.UI.WebControls.Unit"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: SYSTEM_WEB_UI_WEBCONTROLS_UNIT): BOOLEAN is
		external
			"IL operator  signature (System.Web.UI.WebControls.Unit): System.Boolean use System.Web.UI.WebControls.Unit"
		alias
			"op_Inequality"
		end

feature -- Specials

	frozen op_implicit (n: INTEGER): SYSTEM_WEB_UI_WEBCONTROLS_UNIT is
		external
			"IL static signature (System.Int32): System.Web.UI.WebControls.Unit use System.Web.UI.WebControls.Unit"
		alias
			"op_Implicit"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_UNIT
