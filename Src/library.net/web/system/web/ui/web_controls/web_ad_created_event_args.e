indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.WebControls.AdCreatedEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_AD_CREATED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_ad_created_event_args

feature {NONE} -- Initialization

	frozen make_web_ad_created_event_args (ad_properties: IDICTIONARY) is
		external
			"IL creator signature (System.Collections.IDictionary) use System.Web.UI.WebControls.AdCreatedEventArgs"
		end

feature -- Access

	frozen get_alternate_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"get_AlternateText"
		end

	frozen get_ad_properties: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"get_AdProperties"
		end

	frozen get_image_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"get_ImageUrl"
		end

	frozen get_navigate_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"get_NavigateUrl"
		end

feature -- Element Change

	frozen set_image_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"set_ImageUrl"
		end

	frozen set_navigate_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"set_NavigateUrl"
		end

	frozen set_alternate_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"set_AlternateText"
		end

end -- class WEB_AD_CREATED_EVENT_ARGS
