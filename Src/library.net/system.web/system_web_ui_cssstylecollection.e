indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.CssStyleCollection"

frozen external class
	SYSTEM_WEB_UI_CSSSTYLECOLLECTION

create {NONE}

feature -- Access

	frozen get_item (key: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.CssStyleCollection"
		alias
			"get_Item"
		end

	frozen get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
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

	frozen set_item (key: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.CssStyleCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add (key: STRING; value: STRING) is
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

	frozen remove (key: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.CssStyleCollection"
		alias
			"Remove"
		end

end -- class SYSTEM_WEB_UI_CSSSTYLECOLLECTION
