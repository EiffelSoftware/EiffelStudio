indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.DictionarySectionHandler"

external class
	SYSTEM_CONFIGURATION_DICTIONARYSECTIONHANDLER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_CONFIGURATION_ICONFIGURATIONSECTIONHANDLER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Configuration.DictionarySectionHandler"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Configuration.DictionarySectionHandler"
		alias
			"GetHashCode"
		end

	Create_ (parent: ANY; context: ANY; section: SYSTEM_XML_XMLNODE): ANY is
		external
			"IL signature (System.Object, System.Object, System.Xml.XmlNode): System.Object use System.Configuration.DictionarySectionHandler"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Configuration.DictionarySectionHandler"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Configuration.DictionarySectionHandler"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Configuration.DictionarySectionHandler"
		alias
			"Finalize"
		end

	get_value_attribute_name: STRING is
		external
			"IL signature (): System.String use System.Configuration.DictionarySectionHandler"
		alias
			"get_ValueAttributeName"
		end

	get_key_attribute_name: STRING is
		external
			"IL signature (): System.String use System.Configuration.DictionarySectionHandler"
		alias
			"get_KeyAttributeName"
		end

end -- class SYSTEM_CONFIGURATION_DICTIONARYSECTIONHANDLER
