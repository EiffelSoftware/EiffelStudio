indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlText"

external class
	SYSTEM_XML_XMLTEXT

inherit
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_XML_XMLCHARACTERDATA
		redefine
			set_value,
			get_value
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create {NONE}

feature -- Access

	get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlText"
		alias
			"get_Value"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlText"
		alias
			"get_LocalName"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlText"
		alias
			"get_NodeType"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlText"
		alias
			"get_Name"
		end

feature -- Element Change

	set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlText"
		alias
			"set_Value"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlText"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlText"
		alias
			"CloneNode"
		end

	split_text (offset: INTEGER): SYSTEM_XML_XMLTEXT is
		external
			"IL signature (System.Int32): System.Xml.XmlText use System.Xml.XmlText"
		alias
			"SplitText"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlText"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XMLTEXT
