indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.DesignTimeParseData"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DESIGN_TIME_PARSE_DATA

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (designer_host: SYSTEM_DLL_IDESIGNER_HOST; parse_text: SYSTEM_STRING) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost, System.String) use System.Web.UI.DesignTimeParseData"
		end

feature -- Access

	frozen get_designer_host: SYSTEM_DLL_IDESIGNER_HOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.Web.UI.DesignTimeParseData"
		alias
			"get_DesignerHost"
		end

	frozen get_parse_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.DesignTimeParseData"
		alias
			"get_ParseText"
		end

	frozen get_document_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.DesignTimeParseData"
		alias
			"get_DocumentUrl"
		end

	frozen get_data_binding_handler: EVENT_HANDLER is
		external
			"IL signature (): System.EventHandler use System.Web.UI.DesignTimeParseData"
		alias
			"get_DataBindingHandler"
		end

feature -- Element Change

	frozen set_data_binding_handler (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.DesignTimeParseData"
		alias
			"set_DataBindingHandler"
		end

	frozen set_document_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.DesignTimeParseData"
		alias
			"set_DocumentUrl"
		end

end -- class WEB_DESIGN_TIME_PARSE_DATA
