indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapAttributeAttribute"

external class
	SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_soapattributeattribute_1,
	make_soapattributeattribute

feature {NONE} -- Initialization

	frozen make_soapattributeattribute_1 (attr_name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.SoapAttributeAttribute"
		end

	frozen make_soapattributeattribute is
		external
			"IL creator use System.Xml.Serialization.SoapAttributeAttribute"
		end

feature -- Access

	frozen get_attribute_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"get_AttributeName"
		end

	frozen get_data_type: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"get_DataType"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_attribute_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"set_AttributeName"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"set_Namespace"
		end

	frozen set_data_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"set_DataType"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTEATTRIBUTE
