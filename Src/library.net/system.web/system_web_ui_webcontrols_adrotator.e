indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.AdRotator"

external class
	SYSTEM_WEB_UI_WEBCONTROLS_ADROTATOR

inherit
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
		rename
			set_attribute as system_web_ui_iattribute_accessor_set_attribute,
			get_attribute as system_web_ui_iattribute_accessor_get_attribute
		end
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_UI_WEBCONTROLS_WEBCONTROL
		redefine
			get_font,
			create_control_collection,
			render,
			on_pre_render
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
	make_adrotator

feature {NONE} -- Initialization

	frozen make_adrotator is
		external
			"IL creator use System.Web.UI.WebControls.AdRotator"
		end

feature -- Access

	frozen get_keyword_filter: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdRotator"
		alias
			"get_KeywordFilter"
		end

	frozen get_advertisement_file: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdRotator"
		alias
			"get_AdvertisementFile"
		end

	frozen get_target: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdRotator"
		alias
			"get_Target"
		end

	get_font: SYSTEM_WEB_UI_WEBCONTROLS_FONTINFO is
		external
			"IL signature (): System.Web.UI.WebControls.FontInfo use System.Web.UI.WebControls.AdRotator"
		alias
			"get_Font"
		end

feature -- Element Change

	frozen set_keyword_filter (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"set_KeywordFilter"
		end

	frozen set_advertisement_file (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"set_AdvertisementFile"
		end

	frozen remove_ad_created (value: SYSTEM_WEB_UI_WEBCONTROLS_ADCREATEDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.AdCreatedEventHandler): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"remove_AdCreated"
		end

	frozen add_ad_created (value: SYSTEM_WEB_UI_WEBCONTROLS_ADCREATEDEVENTHANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.AdCreatedEventHandler): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"add_AdCreated"
		end

	frozen set_target (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"set_Target"
		end

feature {NONE} -- Implementation

	on_pre_render (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"OnPreRender"
		end

	on_ad_created (e: SYSTEM_WEB_UI_WEBCONTROLS_ADCREATEDEVENTARGS) is
		external
			"IL signature (System.Web.UI.WebControls.AdCreatedEventArgs): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"OnAdCreated"
		end

	create_control_collection: SYSTEM_WEB_UI_CONTROLCOLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.AdRotator"
		alias
			"CreateControlCollection"
		end

	render (writer: SYSTEM_WEB_UI_HTMLTEXTWRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"Render"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_ADROTATOR
