indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.CodeIdentifier"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_CODE_IDENTIFIER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.CodeIdentifier"
		end

feature -- Basic Operations

	frozen make_pascal (identifier: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.CodeIdentifier"
		alias
			"MakePascal"
		end

	frozen make_camel (identifier: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.CodeIdentifier"
		alias
			"MakeCamel"
		end

	frozen make_valid (identifier: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.CodeIdentifier"
		alias
			"MakeValid"
		end

end -- class SYSTEM_XML_CODE_IDENTIFIER
