indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.FontInfo"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_FONT_INFO

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.FontInfo"
		alias
			"get_Name"
		end

	frozen get_italic: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.FontInfo"
		alias
			"get_Italic"
		end

	frozen get_names: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Web.UI.WebControls.FontInfo"
		alias
			"get_Names"
		end

	frozen get_underline: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.FontInfo"
		alias
			"get_Underline"
		end

	frozen get_size: WEB_FONT_UNIT is
		external
			"IL signature (): System.Web.UI.WebControls.FontUnit use System.Web.UI.WebControls.FontInfo"
		alias
			"get_Size"
		end

	frozen get_strikeout: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.FontInfo"
		alias
			"get_Strikeout"
		end

	frozen get_overline: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.FontInfo"
		alias
			"get_Overline"
		end

	frozen get_bold: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.FontInfo"
		alias
			"get_Bold"
		end

feature -- Element Change

	frozen set_names (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL signature (System.String[]): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Names"
		end

	frozen set_overline (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Overline"
		end

	frozen set_strikeout (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Strikeout"
		end

	frozen set_bold (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Bold"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Name"
		end

	frozen set_size (value: WEB_FONT_UNIT) is
		external
			"IL signature (System.Web.UI.WebControls.FontUnit): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Size"
		end

	frozen set_italic (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Italic"
		end

	frozen set_underline (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Underline"
		end

feature -- Basic Operations

	frozen copy_from (f: WEB_FONT_INFO) is
		external
			"IL signature (System.Web.UI.WebControls.FontInfo): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"CopyFrom"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.FontInfo"
		alias
			"ToString"
		end

	frozen should_serialize_names: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.FontInfo"
		alias
			"ShouldSerializeNames"
		end

	frozen merge_with (f: WEB_FONT_INFO) is
		external
			"IL signature (System.Web.UI.WebControls.FontInfo): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"MergeWith"
		end

end -- class WEB_FONT_INFO
