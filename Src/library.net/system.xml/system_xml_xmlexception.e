indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlException"

external class
	SYSTEM_XML_XMLEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_xmlexception,
	make_xmlexception_1

feature {NONE} -- Initialization

	frozen make_xmlexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Xml.XmlException"
		end

	frozen make_xmlexception_1 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Xml.XmlException"
		end

feature -- Access

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlException"
		alias
			"get_LineNumber"
		end

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlException"
		alias
			"get_LinePosition"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Xml.XmlException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_XML_XMLEXCEPTION
