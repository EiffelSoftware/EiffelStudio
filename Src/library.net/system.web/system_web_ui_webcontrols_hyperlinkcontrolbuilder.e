indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.HyperLinkControlBuilder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_HYPERLINKCONTROLBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			allow_whitespace_literals
		end

create
	make_hyperlinkcontrolbuilder

feature {NONE} -- Initialization

	frozen make_hyperlinkcontrolbuilder is
		external
			"IL creator use System.Web.UI.WebControls.HyperLinkControlBuilder"
		end

feature -- Basic Operations

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.HyperLinkControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_HYPERLINKCONTROLBUILDER
