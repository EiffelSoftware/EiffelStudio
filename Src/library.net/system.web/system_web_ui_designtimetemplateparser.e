indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.DesignTimeTemplateParser"

frozen external class
	SYSTEM_WEB_UI_DESIGNTIMETEMPLATEPARSER

create {NONE}

feature -- Basic Operations

	frozen parse_template (data: SYSTEM_WEB_UI_DESIGNTIMEPARSEDATA): SYSTEM_WEB_UI_ITEMPLATE is
		external
			"IL static signature (System.Web.UI.DesignTimeParseData): System.Web.UI.ITemplate use System.Web.UI.DesignTimeTemplateParser"
		alias
			"ParseTemplate"
		end

	frozen parse_control (data: SYSTEM_WEB_UI_DESIGNTIMEPARSEDATA): SYSTEM_WEB_UI_CONTROL is
		external
			"IL static signature (System.Web.UI.DesignTimeParseData): System.Web.UI.Control use System.Web.UI.DesignTimeTemplateParser"
		alias
			"ParseControl"
		end

end -- class SYSTEM_WEB_UI_DESIGNTIMETEMPLATEPARSER
