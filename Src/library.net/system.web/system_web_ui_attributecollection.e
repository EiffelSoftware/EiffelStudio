indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.AttributeCollection"

frozen external class
	SYSTEM_WEB_UI_ATTRIBUTECOLLECTION

create
	make

feature {NONE} -- Initialization

	frozen make (bag: SYSTEM_WEB_UI_STATEBAG) is
		external
			"IL creator signature (System.Web.UI.StateBag) use System.Web.UI.AttributeCollection"
		end

feature -- Access

	frozen get_css_style: SYSTEM_WEB_UI_CSSSTYLECOLLECTION is
		external
			"IL signature (): System.Web.UI.CssStyleCollection use System.Web.UI.AttributeCollection"
		alias
			"get_CssStyle"
		end

	frozen get_item (key: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.AttributeCollection"
		alias
			"get_Item"
		end

	frozen get_keys: SYSTEM_COLLECTIONS_ICOLLECTION is
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

	frozen set_item (key: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.AttributeCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen add_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.AttributeCollection"
		alias
			"AddAttributes"
		end

	frozen render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.AttributeCollection"
		alias
			"Render"
		end

	frozen add (key: STRING; value: STRING) is
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

	frozen remove (key: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.AttributeCollection"
		alias
			"Remove"
		end

end -- class SYSTEM_WEB_UI_ATTRIBUTECOLLECTION
