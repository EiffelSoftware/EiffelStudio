indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XPath.XPathException"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XPATH_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data,
			get_message
		end
	ISERIALIZABLE

create
	make_system_xml_xpath_exception

feature {NONE} -- Initialization

	frozen make_system_xml_xpath_exception (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Xml.XPath.XPathException"
		end

feature -- Access

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XPath.XPathException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Xml.XPath.XPathException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_XML_XPATH_EXCEPTION
