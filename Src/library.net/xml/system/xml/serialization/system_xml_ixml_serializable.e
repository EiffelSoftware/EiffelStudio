indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.IXmlSerializable"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_IXML_SERIALIZABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	write_xml (writer: SYSTEM_XML_XML_WRITER) is
		external
			"IL deferred signature (System.Xml.XmlWriter): System.Void use System.Xml.Serialization.IXmlSerializable"
		alias
			"WriteXml"
		end

	read_xml (reader: SYSTEM_XML_XML_READER) is
		external
			"IL deferred signature (System.Xml.XmlReader): System.Void use System.Xml.Serialization.IXmlSerializable"
		alias
			"ReadXml"
		end

	get_schema: SYSTEM_XML_XML_SCHEMA is
		external
			"IL deferred signature (): System.Xml.Schema.XmlSchema use System.Xml.Serialization.IXmlSerializable"
		alias
			"GetSchema"
		end

end -- class SYSTEM_XML_IXML_SERIALIZABLE
