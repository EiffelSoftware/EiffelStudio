indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.IConfigurationSectionHandler"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICONFIGURATION_SECTION_HANDLER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_ (parent: SYSTEM_OBJECT; config_context: SYSTEM_OBJECT; section: SYSTEM_XML_XML_NODE): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Object, System.Object, System.Xml.XmlNode): System.Object use System.Configuration.IConfigurationSectionHandler"
		alias
			"Create"
		end

end -- class SYSTEM_DLL_ICONFIGURATION_SECTION_HANDLER
