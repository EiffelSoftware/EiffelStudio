indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlForm"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_FORM

inherit
	WEB_HTML_CONTAINER_CONTROL
		redefine
			render_attributes,
			render_children,
			render,
			on_init
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
	WEB_IATTRIBUTE_ACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end

create
	make_web_html_form

feature {NONE} -- Initialization

	frozen make_web_html_form is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlForm"
		end

feature -- Access

	frozen get_target: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"get_Target"
		end

	frozen get_method: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"get_Method"
		end

	frozen get_enctype: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"get_Enctype"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_enctype (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"set_Enctype"
		end

	set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"set_Name"
		end

	frozen set_method (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"set_Method"
		end

	frozen set_target (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"set_Target"
		end

feature {NONE} -- Implementation

	render_attributes (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"RenderAttributes"
		end

	render_children (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"RenderChildren"
		end

	render (output: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"Render"
		end

	on_init (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"OnInit"
		end

end -- class WEB_HTML_FORM
