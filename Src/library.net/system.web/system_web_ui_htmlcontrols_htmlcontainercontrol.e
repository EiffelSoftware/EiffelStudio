indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlContainerControl"

deferred external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTAINERCONTROL

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
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTROL
		redefine
			render_attributes,
			create_control_collection,
			render,
			load_view_state
		end
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

feature -- Access

	get_inner_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"get_InnerText"
		end

	get_inner_html: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"get_InnerHtml"
		end

feature -- Element Change

	set_inner_html (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"set_InnerHtml"
		end

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"set_InnerText"
		end

feature {NONE} -- Implementation

	load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"LoadViewState"
		end

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"RenderAttributes"
		end

	render_end_tag (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"RenderEndTag"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"CreateControlCollection"
		end

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlContainerControl"
		alias
			"Render"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTAINERCONTROL
