indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.LiteralControlBuilder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_LITERAL_CONTROL_BUILDER

inherit
	WEB_CONTROL_BUILDER
		redefine
			append_sub_builder,
			allow_whitespace_literals
		end

create
	make_web_literal_control_builder

feature {NONE} -- Initialization

	frozen make_web_literal_control_builder is
		external
			"IL creator use System.Web.UI.WebControls.LiteralControlBuilder"
		end

feature -- Basic Operations

	append_sub_builder (sub_builder: WEB_CONTROL_BUILDER) is
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

end -- class WEB_LITERAL_CONTROL_BUILDER
