indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.LiteralControl"

external class
	SYSTEM_WEB_UI_LITERALCONTROL

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_CONTROL
		redefine
			create_control_collection,
			render
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_literalcontrol,
	make_literalcontrol_1

feature {NONE} -- Initialization

	frozen make_literalcontrol is
		external
			"IL creator use System.Web.UI.LiteralControl"
		end

	frozen make_literalcontrol_1 (text: STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.LiteralControl"
		end

feature -- Access

	get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.LiteralControl"
		alias
			"get_Text"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.LiteralControl"
		alias
			"set_Text"
		end

feature {NONE} -- Implementation

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.LiteralControl"
		alias
			"CreateControlCollection"
		end

	render (output: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.LiteralControl"
		alias
			"Render"
		end

end -- class SYSTEM_WEB_UI_LITERALCONTROL
