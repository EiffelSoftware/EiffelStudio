indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.PlaceHolderControlBuilder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_PLACEHOLDERCONTROLBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			allow_whitespace_literals
		end

create
	make_placeholdercontrolbuilder

feature {NONE} -- Initialization

	frozen make_placeholdercontrolbuilder is
		external
			"IL creator use System.Web.UI.WebControls.PlaceHolderControlBuilder"
		end

feature -- Basic Operations

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.PlaceHolderControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_PLACEHOLDERCONTROLBUILDER
