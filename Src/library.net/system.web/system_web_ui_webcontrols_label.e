indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.Label"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_LABEL

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
	make_label

feature {NONE} -- Initialization

	frozen make_label is
		external
			"IL creator use System.Web.UI.WebControls.Label"
		end

feature -- Access

	get_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.Label"
		alias
			"get_Text"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.Label"
		alias
			"set_Text"
		end

feature {NONE} -- Implementation

	load_view_state (saved_state: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.Label"
		alias
			"LoadViewState"
		end

	render_contents (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.Label"
		alias
			"RenderContents"
		end

	add_parsed_sub_object (obj: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Web.UI.WebControls.Label"
		alias
			"AddParsedSubObject"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_LABEL
