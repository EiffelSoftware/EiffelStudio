indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.HtmlControls.HtmlControl"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_HTML_CONTROL

inherit
	WEB_CONTROL
		redefine
			create_control_collection,
			get_view_state_ignores_case,
			render
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

feature -- Access

	get_tag_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"get_TagName"
		end

	frozen get_disabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"get_Disabled"
		end

	frozen get_style: WEB_CSS_STYLE_COLLECTION is
		external
			"IL signature (): System.Web.UI.CssStyleCollection use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"get_Style"
		end

	frozen get_attributes: WEB_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.Web.UI.AttributeCollection use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_disabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"set_Disabled"
		end

feature {NONE} -- Implementation

	get_view_state_ignores_case: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"get_ViewStateIgnoresCase"
		end

	render_attributes (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"RenderAttributes"
		end

	frozen system_web_ui_iattribute_accessor_set_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"System.Web.UI.IAttributeAccessor.SetAttribute"
		end

	frozen system_web_ui_iattribute_accessor_get_attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"System.Web.UI.IAttributeAccessor.GetAttribute"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"CreateControlCollection"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"Render"
		end

	render_begin_tag (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"RenderBeginTag"
		end

end -- class WEB_HTML_CONTROL
