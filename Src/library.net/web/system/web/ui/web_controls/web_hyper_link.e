indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.HyperLink"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HYPER_LINK

inherit
	WEB_WEB_CONTROL
		redefine
			render_contents,
			add_attributes_to_render,
			load_view_state,
			add_parsed_sub_object
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
	make_web_hyper_link

feature {NONE} -- Initialization

	frozen make_web_hyper_link is
		external
			"IL creator use System.Web.UI.WebControls.HyperLink"
		end

feature -- Access

	frozen get_target: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLink"
		alias
			"get_Target"
		end

	get_image_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLink"
		alias
			"get_ImageUrl"
		end

	frozen get_navigate_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLink"
		alias
			"get_NavigateUrl"
		end

	get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLink"
		alias
			"get_Text"
		end

feature -- Element Change

	set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"set_Text"
		end

	set_image_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"set_ImageUrl"
		end

	frozen set_navigate_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"set_NavigateUrl"
		end

	frozen set_target (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"set_Target"
		end

feature {NONE} -- Implementation

	load_view_state (saved_state: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"LoadViewState"
		end

	render_contents (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"RenderContents"
		end

	add_parsed_sub_object (obj: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"AddParsedSubObject"
		end

	add_attributes_to_render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"AddAttributesToRender"
		end

end -- class WEB_HYPER_LINK
