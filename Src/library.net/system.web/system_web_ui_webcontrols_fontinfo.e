indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.FontInfo"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_FONTINFO

inherit
	ANY
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_name: STRING is
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

	frozen get_names: ARRAY [STRING] is
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

	frozen get_size: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT is
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

	frozen set_names (value: ARRAY [STRING]) is
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

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"set_Name"
		end

	frozen set_size (value: SYSTEM_WEB_UI_WEBCONTROLS_FONTUNIT) is
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

	frozen copy_from (f: SYSTEM_WEB_UI_WEBCONTROLS_FONTINFO) is
		external
			"IL signature (System.Web.UI.WebControls.FontInfo): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"CopyFrom"
		end

	to_string: STRING is
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

	frozen merge_with (f: SYSTEM_WEB_UI_WEBCONTROLS_FONTINFO) is
		external
			"IL signature (System.Web.UI.WebControls.FontInfo): System.Void use System.Web.UI.WebControls.FontInfo"
		alias
			"MergeWith"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_FONTINFO
