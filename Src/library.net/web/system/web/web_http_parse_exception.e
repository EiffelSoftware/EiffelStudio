indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpParseException"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_PARSE_EXCEPTION

inherit
	WEB_HTTP_EXCEPTION
	ISERIALIZABLE

create {NONE}

feature -- Access

	frozen get_line: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpParseException"
		alias
			"get_Line"
		end

	frozen get_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.HttpParseException"
		alias
			"get_FileName"
		end

end -- class WEB_HTTP_PARSE_EXCEPTION
