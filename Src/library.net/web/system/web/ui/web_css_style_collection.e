indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.CssStyleCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_CSS_STYLE_COLLECTION

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_item (key: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.CssStyleCollection"
		alias
			"get_Item"
		end

	frozen get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Web.UI.CssStyleCollection"
		alias
			"get_Keys"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.CssStyleCollection"
		alias
			"get_Count"
		end

feature -- Element Change

	frozen set_item (key: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.CssStyleCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add (key: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.CssStyleCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.CssStyleCollection"
		alias
			"Clear"
		end

	frozen remove (key: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.CssStyleCollection"
		alias
			"Remove"
		end

end -- class WEB_CSS_STYLE_COLLECTION
