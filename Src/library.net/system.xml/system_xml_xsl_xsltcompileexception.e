indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Xsl.XsltCompileException"

external class
	SYSTEM_XML_XSL_XSLTCOMPILEEXCEPTION

inherit
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_XML_XSL_XSLTEXCEPTION
		redefine
			get_object_data,
			get_message
		end

create
	make_xsltcompileexception_1,
	make_xsltcompileexception

feature {NONE} -- Initialization

	frozen make_xsltcompileexception_1 (inner: SYSTEM_EXCEPTION; source_uri: STRING; line_number: INTEGER; line_position: INTEGER) is
		external
			"IL creator signature (System.Exception, System.String, System.Int32, System.Int32) use System.Xml.Xsl.XsltCompileException"
		end

	frozen make_xsltcompileexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Xml.Xsl.XsltCompileException"
		end

feature -- Access

	get_message: STRING is
		external
			"IL signature (): System.String use System.Xml.Xsl.XsltCompileException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Xml.Xsl.XsltCompileException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_XML_XSL_XSLTCOMPILEEXCEPTION
