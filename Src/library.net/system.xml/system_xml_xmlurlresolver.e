indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlUrlResolver"

external class
	SYSTEM_XML_XMLURLRESOLVER

inherit
	SYSTEM_XML_XMLRESOLVER

create
	make_xmlurlresolver

feature {NONE} -- Initialization

	frozen make_xmlurlresolver is
		external
			"IL creator use System.Xml.XmlUrlResolver"
		end

feature -- Element Change

	set_credentials (value: SYSTEM_NET_ICREDENTIALS) is
		external
			"IL signature (System.Net.ICredentials): System.Void use System.Xml.XmlUrlResolver"
		alias
			"set_Credentials"
		end

feature -- Basic Operations

	get_entity (absolute_uri: SYSTEM_URI; role: STRING; of_object_to_return: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Uri, System.String, System.Type): System.Object use System.Xml.XmlUrlResolver"
		alias
			"GetEntity"
		end

	resolve_uri (base_uri: SYSTEM_URI; relative_uri: STRING): SYSTEM_URI is
		external
			"IL signature (System.Uri, System.String): System.Uri use System.Xml.XmlUrlResolver"
		alias
			"ResolveUri"
		end

end -- class SYSTEM_XML_XMLURLRESOLVER
