indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Xsl.XsltCompileException"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XSLT_COMPILE_EXCEPTION

inherit
	SYSTEM_XML_XSLT_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_system_xml_xslt_compile_exception

feature {NONE} -- Initialization

	frozen make_system_xml_xslt_compile_exception (inner: EXCEPTION; source_uri: SYSTEM_STRING; line_number: INTEGER; line_position: INTEGER) is
		external
			"IL creator signature (System.Exception, System.String, System.Int32, System.Int32) use System.Xml.Xsl.XsltCompileException"
		end

feature -- Access

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Xsl.XsltCompileException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Xml.Xsl.XsltCompileException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_XML_XSLT_COMPILE_EXCEPTION
