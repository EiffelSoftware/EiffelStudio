indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TextBoxControlBuilder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TEXTBOXCONTROLBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			html_decode_literals,
			allow_whitespace_literals
		end

create
	make_textboxcontrolbuilder

feature {NONE} -- Initialization

	frozen make_textboxcontrolbuilder is
		external
			"IL creator use System.Web.UI.WebControls.TextBoxControlBuilder"
		end

feature -- Basic Operations

	html_decode_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TextBoxControlBuilder"
		alias
			"HtmlDecodeLiterals"
		end

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TextBoxControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TEXTBOXCONTROLBUILDER
