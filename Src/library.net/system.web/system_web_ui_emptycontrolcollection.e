indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.EmptyControlCollection"

external class
	SYSTEM_WEB_UI_EMPTYCONTROLCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_WEB_UI_CONTROLCOLLECTION
		redefine
			add_at,
			add
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make_emptycontrolcollection

feature {NONE} -- Initialization

	frozen make_emptycontrolcollection (owner: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL creator signature (System.Web.UI.Control) use System.Web.UI.EmptyControlCollection"
		end

feature -- Basic Operations

	add_at (index: INTEGER; child: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Int32, System.Web.UI.Control): System.Void use System.Web.UI.EmptyControlCollection"
		alias
			"AddAt"
		end

	add (child: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.EmptyControlCollection"
		alias
			"Add"
		end

end -- class SYSTEM_WEB_UI_EMPTYCONTROLCOLLECTION
