indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.EmptyControlCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_EMPTY_CONTROL_COLLECTION

inherit
	WEB_CONTROL_COLLECTION
		redefine
			add_at,
			add
		end
	ICOLLECTION
	IENUMERABLE

create
	make_web_empty_control_collection

feature {NONE} -- Initialization

	frozen make_web_empty_control_collection (owner: WEB_CONTROL) is
		external
			"IL creator signature (System.Web.UI.Control) use System.Web.UI.EmptyControlCollection"
		end

feature -- Basic Operations

	add_at (index: INTEGER; child: WEB_CONTROL) is
		external
			"IL signature (System.Int32, System.Web.UI.Control): System.Void use System.Web.UI.EmptyControlCollection"
		alias
			"AddAt"
		end

	add (child: WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.EmptyControlCollection"
		alias
			"Add"
		end

end -- class WEB_EMPTY_CONTROL_COLLECTION
