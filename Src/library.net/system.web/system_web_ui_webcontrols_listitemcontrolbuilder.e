indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ListItemControlBuilder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMCONTROLBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			html_decode_literals,
			allow_whitespace_literals
		end

create
	make_listitemcontrolbuilder

feature {NONE} -- Initialization

	frozen make_listitemcontrolbuilder is
		external
			"IL creator use System.Web.UI.WebControls.ListItemControlBuilder"
		end

feature -- Basic Operations

	html_decode_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItemControlBuilder"
		alias
			"HtmlDecodeLiterals"
		end

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.ListItemControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_LISTITEMCONTROLBUILDER
