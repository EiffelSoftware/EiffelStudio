indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlCharacterData"

deferred external class
	SYSTEM_XML_XMLCHARACTERDATA

inherit
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_XML_XMLLINKEDNODE
		redefine
			set_inner_text,
			get_inner_text,
			set_value,
			get_value
		end

feature -- Access

	get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlCharacterData"
		alias
			"get_Length"
		end

	get_inner_text: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlCharacterData"
		alias
			"get_InnerText"
		end

	get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlCharacterData"
		alias
			"get_Value"
		end

	get_data: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlCharacterData"
		alias
			"get_Data"
		end

feature -- Element Change

	set_data (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"set_Data"
		end

	set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"set_Value"
		end

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	replace_data (offset: INTEGER; count: INTEGER; str_data: STRING) is
		external
			"IL signature (System.Int32, System.Int32, System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"ReplaceData"
		end

	append_data (str_data: STRING) is
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

	substring (offset: INTEGER; count: INTEGER): STRING is
		external
			"IL signature (System.Int32, System.Int32): System.String use System.Xml.XmlCharacterData"
		alias
			"Substring"
		end

	insert_data (offset: INTEGER; str_data: STRING) is
		external
			"IL signature (System.Int32, System.String): System.Void use System.Xml.XmlCharacterData"
		alias
			"InsertData"
		end

feature {NONE} -- Implementation

	frozen decide_xpnode_type_for_whitespace (node: SYSTEM_XML_XMLNODE; xnt: SYSTEM_XML_XPATH_XPATHNODETYPE): BOOLEAN is
		external
			"IL signature (System.Xml.XmlNode, System.Xml.XPath.XPathNodeType&): System.Boolean use System.Xml.XmlCharacterData"
		alias
			"DecideXPNodeTypeForWhitespace"
		end

end -- class SYSTEM_XML_XMLCHARACTERDATA
