indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.DesignTimeParseData"

frozen external class
	SYSTEM_WEB_UI_DESIGNTIMEPARSEDATA

create
	make

feature {NONE} -- Initialization

	frozen make (designer_host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST; parse_text: STRING) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost, System.String) use System.Web.UI.DesignTimeParseData"
		end

feature -- Access

	frozen get_designer_host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.Web.UI.DesignTimeParseData"
		alias
			"get_DesignerHost"
		end

	frozen get_parse_text: STRING is
		external
			"IL signature (): System.String use System.Web.UI.DesignTimeParseData"
		alias
			"get_ParseText"
		end

	frozen get_document_url: STRING is
		external
			"IL signature (): System.String use System.Web.UI.DesignTimeParseData"
		alias
			"get_DocumentUrl"
		end

	frozen get_data_binding_handler: SYSTEM_EVENTHANDLER is
		external
			"IL signature (): System.EventHandler use System.Web.UI.DesignTimeParseData"
		alias
			"get_DataBindingHandler"
		end

feature -- Element Change

	frozen set_data_binding_handler (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.UI.DesignTimeParseData"
		alias
			"set_DataBindingHandler"
		end

	frozen set_document_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.UI.DesignTimeParseData"
		alias
			"set_DocumentUrl"
		end

end -- class SYSTEM_WEB_UI_DESIGNTIMEPARSEDATA
