indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlTableRow+HtmlTableCellControlCollection"

external class
	HTMLTABLECELLCONTROLCOLLECTION_IN_SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROW

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_WEB_UI_CONTROLCOLLECTION
		redefine
			add_at,
			add
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Basic Operations

	add_at (index: INTEGER; child: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Int32, System.Web.UI.Control): System.Void use System.Web.UI.HtmlControls.HtmlTableRow+HtmlTableCellControlCollection"
		alias
			"AddAt"
		end

	add (child: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.HtmlControls.HtmlTableRow+HtmlTableCellControlCollection"
		alias
			"Add"
		end

end -- class HTMLTABLECELLCONTROLCOLLECTION_IN_SYSTEM_WEB_UI_HTMLCONTROLS_HTMLTABLEROW
