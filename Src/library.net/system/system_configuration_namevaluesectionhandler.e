indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.NameValueSectionHandler"

external class
	SYSTEM_CONFIGURATION_NAMEVALUESECTIONHANDLER

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
			"IL creator use System.Configuration.NameValueSectionHandler"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Configuration.NameValueSectionHandler"
		alias
			"GetHashCode"
		end

	frozen Create_ (parent: ANY; context: ANY; section: SYSTEM_XML_XMLNODE): ANY is
		external
			"IL signature (System.Object, System.Object, System.Xml.XmlNode): System.Object use System.Configuration.NameValueSectionHandler"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Configuration.NameValueSectionHandler"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Configuration.NameValueSectionHandler"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Configuration.NameValueSectionHandler"
		alias
			"Finalize"
		end

	get_value_attribute_name: STRING is
		external
			"IL signature (): System.String use System.Configuration.NameValueSectionHandler"
		alias
			"get_ValueAttributeName"
		end

	get_key_attribute_name: STRING is
		external
			"IL signature (): System.String use System.Configuration.NameValueSectionHandler"
		alias
			"get_KeyAttributeName"
		end

end -- class SYSTEM_CONFIGURATION_NAMEVALUESECTIONHANDLER
