indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XPath.XPathException"

external class
	SYSTEM_XML_XPATH_XPATHEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		redefine
			get_object_data,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_xpathexception_1,
	make_xpathexception_4,
	make_xpathexception_5,
	make_xpathexception_2,
	make_xpathexception_3,
	make_xpathexception

feature {NONE} -- Initialization

	frozen make_xpathexception_1 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Xml.XPath.XPathException"
		end

	frozen make_xpathexception_4 (res: STRING; arg1: STRING; arg2: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Xml.XPath.XPathException"
		end

	frozen make_xpathexception_5 (res: STRING; args: ARRAY [STRING]) is
		external
			"IL creator signature (System.String, System.String[]) use System.Xml.XPath.XPathException"
		end

	frozen make_xpathexception_2 (res: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.XPath.XPathException"
		end

	frozen make_xpathexception_3 (res: STRING; arg: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Xml.XPath.XPathException"
		end

	frozen make_xpathexception (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL creator signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext) use System.Xml.XPath.XPathException"
		end

feature -- Access

	get_message: STRING is
		external
			"IL signature (): System.String use System.Xml.XPath.XPathException"
		alias
			"get_Message"
		end

feature -- Basic Operations

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Xml.XPath.XPathException"
		alias
			"GetObjectData"
		end

end -- class SYSTEM_XML_XPATH_XPATHEXCEPTION
