indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.LinkButtonControlBuilder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_LINKBUTTONCONTROLBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			allow_whitespace_literals
		end

create
	make_linkbuttoncontrolbuilder

feature {NONE} -- Initialization

	frozen make_linkbuttoncontrolbuilder is
		external
			"IL creator use System.Web.UI.WebControls.LinkButtonControlBuilder"
		end

feature -- Basic Operations

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.LinkButtonControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_LINKBUTTONCONTROLBUILDER
