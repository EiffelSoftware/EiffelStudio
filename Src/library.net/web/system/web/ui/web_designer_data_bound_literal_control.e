indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.DesignerDataBoundLiteralControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DESIGNER_DATA_BOUND_LITERAL_CONTROL

inherit
	WEB_CONTROL
		redefine
			create_control_collection,
			render,
			save_view_state,
			load_view_state
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	WEB_IPARSER_ACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	WEB_IDATA_BINDINGS_ACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_web_designer_data_bound_literal_control

feature {NONE} -- Initialization

	frozen make_web_designer_data_bound_literal_control is
		external
			"IL creator use System.Web.UI.DesignerDataBoundLiteralControl"
		end

feature -- Access

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.DesignerDataBoundLiteralControl"
		alias
			"get_Text"
		end

feature -- Element Change

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.DesignerDataBoundLiteralControl"
		alias
			"set_Text"
		end

feature {NONE} -- Implementation

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.DesignerDataBoundLiteralControl"
		alias
			"LoadViewState"
		end

	save_view_state: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Web.UI.DesignerDataBoundLiteralControl"
		alias
			"SaveViewState"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.DesignerDataBoundLiteralControl"
		alias
			"CreateControlCollection"
		end

	render (output: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.DesignerDataBoundLiteralControl"
		alias
			"Render"
		end

end -- class WEB_DESIGNER_DATA_BOUND_LITERAL_CONTROL
