indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.XmlSyntaxException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	XML_SYNTAX_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_xml_syntax_exception_4,
	make_xml_syntax_exception_2,
	make_xml_syntax_exception_3,
	make_xml_syntax_exception,
	make_xml_syntax_exception_1

feature {NONE} -- Initialization

	frozen make_xml_syntax_exception_4 (line_number: INTEGER; message: SYSTEM_STRING) is
		external
			"IL creator signature (System.Int32, System.String) use System.Security.XmlSyntaxException"
		end

	frozen make_xml_syntax_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.XmlSyntaxException"
		end

	frozen make_xml_syntax_exception_3 (line_number: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.XmlSyntaxException"
		end

	frozen make_xml_syntax_exception is
		external
			"IL creator use System.Security.XmlSyntaxException"
		end

	frozen make_xml_syntax_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.XmlSyntaxException"
		end

end -- class XML_SYNTAX_EXCEPTION
