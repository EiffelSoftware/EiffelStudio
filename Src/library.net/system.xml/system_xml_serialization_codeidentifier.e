indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.CodeIdentifier"

external class
	SYSTEM_XML_SERIALIZATION_CODEIDENTIFIER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.CodeIdentifier"
		end

feature -- Basic Operations

	frozen make_pascal (identifier: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.CodeIdentifier"
		alias
			"MakePascal"
		end

	frozen make_camel (identifier: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.CodeIdentifier"
		alias
			"MakeCamel"
		end

	frozen make_valid (identifier: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.CodeIdentifier"
		alias
			"MakeValid"
		end

end -- class SYSTEM_XML_SERIALIZATION_CODEIDENTIFIER
