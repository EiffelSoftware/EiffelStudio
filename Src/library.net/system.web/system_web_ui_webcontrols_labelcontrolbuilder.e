indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.LabelControlBuilder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_LABELCONTROLBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			allow_whitespace_literals
		end

create
	make_labelcontrolbuilder

feature {NONE} -- Initialization

	frozen make_labelcontrolbuilder is
		external
			"IL creator use System.Web.UI.WebControls.LabelControlBuilder"
		end

feature -- Basic Operations

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.LabelControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_LABELCONTROLBUILDER
