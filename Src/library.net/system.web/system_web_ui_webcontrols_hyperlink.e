indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.HyperLink"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_HYPERLINK

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			render_contents,
			add_attributes_to_render,
			load_view_state,
			add_parsed_sub_object
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end

create
	make_hyperlink

feature {NONE} -- Initialization

	frozen make_hyperlink is
		external
			"IL creator use System.Web.UI.WebControls.HyperLink"
		end

feature -- Access

	frozen get_target: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLink"
		alias
			"get_Target"
		end

	get_image_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLink"
		alias
			"get_ImageUrl"
		end

	frozen get_navigate_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLink"
		alias
			"get_NavigateUrl"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.HyperLink"
		alias
			"get_Text"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"set_Text"
		end

	set_image_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"set_ImageUrl"
		end

	frozen set_navigate_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"set_NavigateUrl"
		end

	frozen set_target (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"set_Target"
		end

feature {NONE} -- Implementation

	load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"LoadViewState"
		end

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"RenderContents"
		end

	add_parsed_sub_object (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"AddParsedSubObject"
		end

	add_attributes_to_render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.HyperLink"
		alias
			"AddAttributesToRender"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_HYPERLINK
