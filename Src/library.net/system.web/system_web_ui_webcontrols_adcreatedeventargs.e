indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.AdCreatedEventArgs"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_ADCREATEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_adcreatedeventargs

feature {NONE} -- Initialization

	frozen make_adcreatedeventargs (ad_properties: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL creator signature (System.Collections.IDictionary) use System.Web.UI.WebControls.AdCreatedEventArgs"
		end

feature -- Access

	frozen get_alternate_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"get_AlternateText"
		end

	frozen get_ad_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"get_AdProperties"
		end

	frozen get_image_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"get_ImageUrl"
		end

	frozen get_navigate_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"get_NavigateUrl"
		end

feature -- Element Change

	frozen set_image_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"set_ImageUrl"
		end

	frozen set_navigate_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"set_NavigateUrl"
		end

	frozen set_alternate_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.WebControls.AdCreatedEventArgs"
		alias
			"set_AlternateText"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_ADCREATEDEVENTARGS
