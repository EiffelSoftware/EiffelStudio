indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlUrlResolver"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_URL_RESOLVER

inherit
	SYSTEM_XML_XML_RESOLVER

create
	make_system_xml_xml_url_resolver

feature {NONE} -- Initialization

	frozen make_system_xml_xml_url_resolver is
		external
			"IL creator use System.Xml.XmlUrlResolver"
		end

feature -- Element Change

	set_credentials (value: SYSTEM_DLL_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Xml.XmlUrlResolver"
		alias
			"set_Credentials"
		end

feature -- Basic Operations

	get_entity (absolute_uri: SYSTEM_DLL_URI; role: SYSTEM_STRING; of_object_to_return: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.Uri, System.String, System.Type): System.Object use System.Xml.XmlUrlResolver"
		alias
			"GetEntity"
		end

	resolve_uri (base_uri: SYSTEM_DLL_URI; relative_uri: SYSTEM_STRING): SYSTEM_DLL_URI is
		external
			"IL signature (System.Uri, System.String): System.Uri use System.Xml.XmlUrlResolver"
		alias
			"ResolveUri"
		end

end -- class SYSTEM_XML_XML_URL_RESOLVER
