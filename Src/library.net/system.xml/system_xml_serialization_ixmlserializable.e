indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.IXmlSerializable"

deferred external class
	SYSTEM_XML_SERIALIZATION_IXMLSERIALIZABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	write_xml (writer: SYSTEM_XML_XMLWRITER) is
		external
			"IL deferred signature (System.Xml.XmlWriter): System.Void use System.Xml.Serialization.IXmlSerializable"
		alias
			"WriteXml"
		end

	read_xml (reader: SYSTEM_XML_XMLREADER) is
		external
			"IL deferred signature (System.Xml.XmlReader): System.Void use System.Xml.Serialization.IXmlSerializable"
		alias
			"ReadXml"
		end

	get_schema: SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL deferred signature (): System.Xml.Schema.XmlSchema use System.Xml.Serialization.IXmlSerializable"
		alias
			"GetSchema"
		end

end -- class SYSTEM_XML_SERIALIZATION_IXMLSERIALIZABLE
