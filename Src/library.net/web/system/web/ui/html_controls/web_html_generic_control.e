indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlGenericControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTML_GENERIC_CONTROL

inherit
	WEB_HTML_CONTAINER_CONTROL
		rename
			get_tag_name as get_tag_name_string
		redefine
			get_tag_name_string
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
	make_web_html_generic_control_1,
	make_web_html_generic_control

feature {NONE} -- Initialization

	frozen make_web_html_generic_control_1 (tag: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.UI.HtmlControls.HtmlGenericControl"
		end

	frozen make_web_html_generic_control is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlGenericControl"
		end

feature -- Access

	frozen get_tag_name_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlGenericControl"
		alias
			"get_TagName"
		end

feature -- Element Change

	frozen set_tag_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlGenericControl"
		alias
			"set_TagName"
		end

end -- class WEB_HTML_GENERIC_CONTROL
