indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.AttributeCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_ATTRIBUTE_COLLECTION

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (bag: WEB_STATE_BAG) is
		external
			"IL creator signature (System.Web.UI.StateBag) use System.Web.UI.AttributeCollection"
		end

feature -- Access

	frozen get_css_style: WEB_CSS_STYLE_COLLECTION is
		external
			"IL signature (): System.Web.UI.CssStyleCollection use System.Web.UI.AttributeCollection"
		alias
			"get_CssStyle"
		end

	frozen get_item (key: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.AttributeCollection"
		alias
			"get_Item"
		end

	frozen get_keys: ICOLLECTION is
		external
			"IL signature (): System.Collections.ICollection use System.Web.UI.AttributeCollection"
		alias
			"get_Keys"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.AttributeCollection"
		alias
			"get_Count"
		end

feature -- Element Change

	frozen set_item (key: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.AttributeCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_attributes (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.AttributeCollection"
		alias
			"AddAttributes"
		end

	frozen render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.AttributeCollection"
		alias
			"Render"
		end

	frozen add (key: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.AttributeCollection"
		alias
			"Add"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Web.UI.AttributeCollection"
		alias
			"Clear"
		end

	frozen remove (key: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.AttributeCollection"
		alias
			"Remove"
		end

end -- class WEB_ATTRIBUTE_COLLECTION
