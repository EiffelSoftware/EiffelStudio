indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlDeclaration"

external class
	SYSTEM_XML_XMLDECLARATION

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

create {NONE}

feature -- Access

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDeclaration"
		alias
			"get_Name"
		end

	get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDeclaration"
		alias
			"get_Value"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDeclaration"
		alias
			"get_LocalName"
		end

	frozen get_encoding: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDeclaration"
		alias
			"get_Encoding"
		end

	frozen get_standalone: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDeclaration"
		alias
			"get_Standalone"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlDeclaration"
		alias
			"get_NodeType"
		end

	frozen get_version: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDeclaration"
		alias
			"get_Version"
		end

	get_inner_text: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlDeclaration"
		alias
			"get_InnerText"
		end

feature -- Element Change

	frozen set_encoding (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDeclaration"
		alias
			"set_Encoding"
		end

	set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDeclaration"
		alias
			"set_Value"
		end

	frozen set_standalone (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDeclaration"
		alias
			"set_Standalone"
		end

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlDeclaration"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDeclaration"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlDeclaration"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlDeclaration"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XMLDECLARATION
