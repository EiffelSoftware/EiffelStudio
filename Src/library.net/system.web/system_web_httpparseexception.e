indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpParseException"

frozen external class
	SYSTEM_WEB_HTTPPARSEEXCEPTION

inherit
	SYSTEM_WEB_HTTPEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_httpparseexception

feature {NONE} -- Initialization

	frozen make_httpparseexception (message: STRING; inner_exception: SYSTEM_EXCEPTION; file_name: STRING; line: INTEGER) is
		external
			"IL creator signature (System.String, System.Exception, System.String, System.Int32) use System.Web.HttpParseException"
		end

feature -- Access

	frozen get_line: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpParseException"
		alias
			"get_Line"
		end

	frozen get_file_name: STRING is
		external
			"IL signature (): System.String use System.Web.HttpParseException"
		alias
			"get_FileName"
		end

end -- class SYSTEM_WEB_HTTPPARSEEXCEPTION
