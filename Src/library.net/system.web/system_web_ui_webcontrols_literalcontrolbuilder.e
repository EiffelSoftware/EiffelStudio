indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.LiteralControlBuilder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_LITERALCONTROLBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			append_sub_builder,
			allow_whitespace_literals
		end

create
	make_literalcontrolbuilder

feature {NONE} -- Initialization

	frozen make_literalcontrolbuilder is
		external
			"IL creator use System.Web.UI.WebControls.LiteralControlBuilder"
		end

feature -- Basic Operations

	append_sub_builder (sub_builder: SYSTEM_WEB_UI_CONTROLBUILDER) is
		external
			"IL signature (System.Web.UI.ControlBuilder): System.Void use System.Web.UI.WebControls.LiteralControlBuilder"
		alias
			"AppendSubBuilder"
		end

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.LiteralControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_LITERALCONTROLBUILDER
