indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapAttributeOverrides"

external class
	SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTEOVERRIDES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.SoapAttributeOverrides"
		end

feature -- Access

	frozen get_item (type: SYSTEM_TYPE): SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTES is
		external
			"IL signature (System.Type): System.Xml.Serialization.SoapAttributes use System.Xml.Serialization.SoapAttributeOverrides"
		alias
			"get_Item"
		end

	frozen get_item_type_string (type: SYSTEM_TYPE; member: STRING): SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTES is
		external
			"IL signature (System.Type, System.String): System.Xml.Serialization.SoapAttributes use System.Xml.Serialization.SoapAttributeOverrides"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen add (type: SYSTEM_TYPE; attributes: SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTES) is
		external
			"IL signature (System.Type, System.Xml.Serialization.SoapAttributes): System.Void use System.Xml.Serialization.SoapAttributeOverrides"
		alias
			"Add"
		end

	frozen add_type_string (type: SYSTEM_TYPE; member: STRING; attributes: SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTES) is
		external
			"IL signature (System.Type, System.String, System.Xml.Serialization.SoapAttributes): System.Void use System.Xml.Serialization.SoapAttributeOverrides"
		alias
			"Add"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTEOVERRIDES
