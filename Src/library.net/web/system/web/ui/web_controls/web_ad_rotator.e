indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.AdRotator"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_AD_ROTATOR

inherit
	WEB_WEB_CONTROL
		redefine
			get_font,
			create_control_collection,
			render,
			on_pre_render
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
	make_web_ad_rotator

feature {NONE} -- Initialization

	frozen make_web_ad_rotator is
		external
			"IL creator use System.Web.UI.WebControls.AdRotator"
		end

feature -- Access

	frozen get_keyword_filter: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdRotator"
		alias
			"get_KeywordFilter"
		end

	frozen get_advertisement_file: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdRotator"
		alias
			"get_AdvertisementFile"
		end

	frozen get_target: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdRotator"
		alias
			"get_Target"
		end

	get_font: WEB_FONT_INFO is
		external
			"IL signature (): System.Web.UI.WebControls.FontInfo use System.Web.UI.WebControls.AdRotator"
		alias
			"get_Font"
		end

feature -- Element Change

	frozen set_keyword_filter (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"set_KeywordFilter"
		end

	frozen set_advertisement_file (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"set_AdvertisementFile"
		end

	frozen remove_ad_created (value: WEB_AD_CREATED_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.AdCreatedEventHandler): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"remove_AdCreated"
		end

	frozen add_ad_created (value: WEB_AD_CREATED_EVENT_HANDLER) is
		external
			"IL signature (System.Web.UI.WebControls.AdCreatedEventHandler): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"add_AdCreated"
		end

	frozen set_target (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"set_Target"
		end

feature {NONE} -- Implementation

	on_pre_render (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"OnPreRender"
		end

	on_ad_created (e: WEB_AD_CREATED_EVENT_ARGS) is
		external
			"IL signature (System.Web.UI.WebControls.AdCreatedEventArgs): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"OnAdCreated"
		end

	create_control_collection: WEB_CONTROL_COLLECTION is
		external
			"IL signature (): System.Web.UI.ControlCollection use System.Web.UI.WebControls.AdRotator"
		alias
			"CreateControlCollection"
		end

	render (writer: WEB_HTML_TEXT_WRITER) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter): System.Void use System.Web.UI.WebControls.AdRotator"
		alias
			"Render"
		end

end -- class WEB_AD_ROTATOR
