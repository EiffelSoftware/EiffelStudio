indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlCharacterData"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_CHARACTER_DATA

inherit
	SYSTEM_XML_XML_LINKED_NODE
		redefine
			set_inner_text,
			get_inner_text,
			set_value,
			get_value
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_XML_IXPATH_NAVIGABLE

feature -- Access

	get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlCharacterData"
		alias
			"get_Length"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlCharacterData"
		alias
			"get_InnerText"
		end

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlCharacterData"
		alias
			"get_Value"
		end

	get_data: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlCharacterData"
		alias
			"get_Data"
		end

feature -- Element Change

	set_data (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"set_Data"
		end

	set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"set_Value"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	replace_data (offset: INTEGER; count: INTEGER; str_data: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.Int32, System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"ReplaceData"
		end

	append_data (str_data: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"AppendData"
		end

	delete_data (offset: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Xml.XmlCharacterData"
		alias
			"DeleteData"
		end

	substring (offset: INTEGER; count: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32, System.Int32): System.String use System.Xml.XmlCharacterData"
		alias
			"Substring"
		end

	insert_data (offset: INTEGER; str_data: SYSTEM_STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"InsertData"
		end

end -- class SYSTEM_XML_XML_CHARACTER_DATA
