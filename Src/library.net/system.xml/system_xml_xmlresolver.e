indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlResolver"

deferred external class
	SYSTEM_XML_XMLRESOLVER

feature -- Element Change

	set_credentials (value: SYSTEM_NET_ICREDENTIALS) is
		external
			"IL deferred signature (System.Net.ICredentials): System.Void use System.Xml.XmlResolver"
		alias
			"set_Credentials"
		end

feature -- Basic Operations

	get_entity (absolute_uri: SYSTEM_URI; role: STRING; of_object_to_return: SYSTEM_TYPE): ANY is
		external
			"IL deferred signature (System.Uri, System.String, System.Type): System.Object use System.Xml.XmlResolver"
		alias
			"GetEntity"
		end

	resolve_uri (base_uri: SYSTEM_URI; relative_uri: STRING): SYSTEM_URI is
		external
			"IL deferred signature (System.Uri, System.String): System.Uri use System.Xml.XmlResolver"
		alias
			"ResolveUri"
		end

end -- class SYSTEM_XML_XMLRESOLVER
