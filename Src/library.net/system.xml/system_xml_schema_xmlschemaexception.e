indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaException"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_xmlschemaexception

feature {NONE} -- Initialization

	frozen make_xmlschemaexception (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Xml.Schema.XmlSchemaException"
		end

feature -- Access

	frozen get_source_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaException"
		alias
			"get_SourceUri"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaException"
		alias
			"get_LineNumber"
		end

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaException"
		alias
			"get_LinePosition"
		end

	frozen get_source_schema_object: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObject use System.Xml.Schema.XmlSchemaException"
		alias
			"get_SourceSchemaObject"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Xml.Schema.XmlSchemaException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAEXCEPTION
