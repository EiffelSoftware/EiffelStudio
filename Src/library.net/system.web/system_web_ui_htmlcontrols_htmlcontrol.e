indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlControl"

deferred external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTROL

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_CONTROL
		redefine
			create_control_collection,
			get_view_state_ignores_case,
			render
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

feature -- Access

	get_tag_name: STRING is
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

	frozen get_style: SYSTEM_WEB_UI_CSSSTYLECOLLECTION is
		external
			"IL signature (): System.Web.UI.CssStyleCollection use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"get_Style"
		end

	frozen get_attributes: SYSTEM_WEB_UI_ATTRIBUTECOLLECTION is
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

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"RenderAttributes"
		end

	frozen system_web_ui_iattribute_accessor_set_attribute (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"System.Web.UI.IAttributeAccessor.SetAttribute"
		end

	frozen system_web_ui_iattribute_accessor_get_attribute (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"System.Web.UI.IAttributeAccessor.GetAttribute"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"CreateControlCollection"
		end

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"Render"
		end

	render_begin_tag (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlControl"
		alias
			"RenderBeginTag"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTROL
