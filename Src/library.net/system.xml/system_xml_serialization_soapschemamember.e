indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapSchemaMember"

external class
	SYSTEM_XML_SERIALIZATION_SOAPSCHEMAMEMBER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.SoapSchemaMember"
		end

feature -- Access

	frozen get_member_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapSchemaMember"
		alias
			"get_MemberName"
		end

	frozen get_member_type: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Serialization.SoapSchemaMember"
		alias
			"get_MemberType"
		end

feature -- Element Change

	frozen set_member_type (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.SoapSchemaMember"
		alias
			"set_MemberType"
		end

	frozen set_member_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapSchemaMember"
		alias
			"set_MemberName"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPSCHEMAMEMBER
