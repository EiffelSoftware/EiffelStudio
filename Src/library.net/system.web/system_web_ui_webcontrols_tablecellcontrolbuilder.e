indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.TableCellControlBuilder"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_TABLECELLCONTROLBUILDER

inherit
	SYSTEM_WEB_UI_CONTROLBUILDER
		redefine
			allow_whitespace_literals
		end

create
	make_tablecellcontrolbuilder

feature {NONE} -- Initialization

	frozen make_tablecellcontrolbuilder is
		external
			"IL creator use System.Web.UI.WebControls.TableCellControlBuilder"
		end

feature -- Basic Operations

	allow_whitespace_literals: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.WebControls.TableCellControlBuilder"
		alias
			"AllowWhitespaceLiterals"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_TABLECELLCONTROLBUILDER
