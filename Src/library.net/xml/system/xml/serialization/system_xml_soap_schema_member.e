indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapSchemaMember"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_SCHEMA_MEMBER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.SoapSchemaMember"
		end

feature -- Access

	frozen get_member_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapSchemaMember"
		alias
			"get_MemberName"
		end

	frozen get_member_type: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Serialization.SoapSchemaMember"
		alias
			"get_MemberType"
		end

feature -- Element Change

	frozen set_member_type (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.SoapSchemaMember"
		alias
			"set_MemberType"
		end

	frozen set_member_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapSchemaMember"
		alias
			"set_MemberName"
		end

end -- class SYSTEM_XML_SOAP_SCHEMA_MEMBER
