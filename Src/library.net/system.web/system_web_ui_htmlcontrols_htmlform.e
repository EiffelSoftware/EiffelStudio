indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.HtmlControls.HtmlForm"

external class
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLFORM

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
		rename
			get_data_bindings as system_web_ui_idata_bindings_accessor_get_data_bindings,
			get_has_data_bindings as system_web_ui_idata_bindings_accessor_get_has_data_bindings
		end
	SYSTEM_WEB_UI_IPARSERACCESSOR
		rename
			add_parsed_sub_object as system_web_ui_iparser_accessor_add_parsed_sub_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WEB_UI_HTMLCONTROLS_HTMLCONTAINERCONTROL
		redefine
			render_attributes,
			render_children,
			render,
			on_init
		end

create
	make_htmlform

feature {NONE} -- Initialization

	frozen make_htmlform is
		external
			"IL creator use System.Web.UI.HtmlControls.HtmlForm"
		end

feature -- Access

	frozen get_target: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"get_Target"
		end

	frozen get_method: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"get_Method"
		end

	frozen get_enctype: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"get_Enctype"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_enctype (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"set_Enctype"
		end

	frozen set_method (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"set_Method"
		end

	frozen set_target (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"set_Target"
		end

feature {NONE} -- Implementation

	render_attributes (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"RenderAttributes"
		end

	render_children (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"RenderChildren"
		end

	render (output: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"Render"
		end

	on_init (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.HtmlControls.HtmlForm"
		alias
			"OnInit"
		end

end -- class SYSTEM_WEB_UI_HTMLCONTROLS_HTMLFORM
