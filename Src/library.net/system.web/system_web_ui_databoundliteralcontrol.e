indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.DataBoundLiteralControl"

frozen external class
	SYSTEM_WEB_UI_DATABOUNDLITERALCONTROL

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
			render,
			save_view_state,
			load_view_state
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_databoundliteralcontrol

feature {NONE} -- Initialization

	frozen make_databoundliteralcontrol (static_literals_count: INTEGER; data_bound_literal_count: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Web.UI.DataBoundLiteralControl"
		end

feature -- Access

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.DataBoundLiteralControl"
		alias
			"get_Text"
		end

feature -- Basic Operations

	frozen set_static_string (index: INTEGER; s: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Web.UI.DataBoundLiteralControl"
		alias
			"SetStaticString"
		end

	frozen set_data_bound_string (index: INTEGER; s: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Web.UI.DataBoundLiteralControl"
		alias
			"SetDataBoundString"
		end

feature {NONE} -- Implementation

	load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.DataBoundLiteralControl"
		alias
			"LoadViewState"
		end

	save_view_state: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.DataBoundLiteralControl"
		alias
			"SaveViewState"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.DataBoundLiteralControl"
		alias
			"CreateControlCollection"
		end

	render (output: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.DataBoundLiteralControl"
		alias
			"Render"
		end

end -- class SYSTEM_WEB_UI_DATABOUNDLITERALCONTROL
