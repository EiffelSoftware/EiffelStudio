indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.IConfigurationSectionHandler"

deferred external class
	SYSTEM_CONFIGURATION_ICONFIGURATIONSECTIONHANDLER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	Create_ (parent: ANY; config_context: ANY; section: SYSTEM_XML_XMLNODE): ANY is
		external
			"IL deferred signature (System.Object, System.Object, System.Xml.XmlNode): System.Object use System.Configuration.IConfigurationSectionHandler"
		alias
			"Create"
		end

end -- class SYSTEM_CONFIGURATION_ICONFIGURATIONSECTIONHANDLER
