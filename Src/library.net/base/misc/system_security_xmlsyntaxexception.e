indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Security.XmlSyntaxException"

frozen external class
	SYSTEM_SECURITY_XMLSYNTAXEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_xmlsyntaxexception,
	make_xmlsyntaxexception_4,
	make_xmlsyntaxexception_3,
	make_xmlsyntaxexception_2,
	make_xmlsyntaxexception_1

feature {NONE} -- Initialization

	frozen make_xmlsyntaxexception is
		external
			"IL creator use System.Security.XmlSyntaxException"
		end

	frozen make_xmlsyntaxexception_4 (line_number: INTEGER; message: STRING) is
		external
			"IL creator signature (System.Int32, System.String) use System.Security.XmlSyntaxException"
		end

	frozen make_xmlsyntaxexception_3 (line_number: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Security.XmlSyntaxException"
		end

	frozen make_xmlsyntaxexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Security.XmlSyntaxException"
		end

	frozen make_xmlsyntaxexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Security.XmlSyntaxException"
		end

end -- class SYSTEM_SECURITY_XMLSYNTAXEXCEPTION
