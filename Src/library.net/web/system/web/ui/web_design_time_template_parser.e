indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.DesignTimeTemplateParser"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DESIGN_TIME_TEMPLATE_PARSER

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen parse_template (data: WEB_DESIGN_TIME_PARSE_DATA): WEB_ITEMPLATE is
		external
			"IL static signature (System.Web.UI.DesignTimeParseData): System.Web.UI.ITemplate use System.Web.UI.DesignTimeTemplateParser"
		alias
			"ParseTemplate"
		end

	frozen parse_control (data: WEB_DESIGN_TIME_PARSE_DATA): WEB_CONTROL is
		external
			"IL static signature (System.Web.UI.DesignTimeParseData): System.Web.UI.Control use System.Web.UI.DesignTimeTemplateParser"
		alias
			"ParseControl"
		end

end -- class WEB_DESIGN_TIME_TEMPLATE_PARSER
