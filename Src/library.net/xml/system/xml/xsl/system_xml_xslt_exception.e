indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Xsl.XsltException"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XSLT_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_system_xml_xslt_exception

feature {NONE} -- Initialization

	frozen make_system_xml_xslt_exception (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Xml.Xsl.XsltException"
		end

feature -- Access

	frozen get_source_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Xsl.XsltException"
		alias
			"get_SourceUri"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Xsl.XsltException"
		alias
			"get_LineNumber"
		end

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Xsl.XsltException"
		alias
			"get_LinePosition"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Xsl.XsltException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Xml.Xsl.XsltException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_XML_XSLT_EXCEPTION
