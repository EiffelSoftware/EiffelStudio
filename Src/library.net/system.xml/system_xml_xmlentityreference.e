indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlEntityReference"

external class
	SYSTEM_XML_XMLENTITYREFERENCE

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
			get_base_uri,
			get_is_read_only,
			set_value,
			get_value
		end

create {NONE}

feature -- Access

	get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntityReference"
		alias
			"get_Value"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntityReference"
		alias
			"get_LocalName"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntityReference"
		alias
			"get_Name"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlEntityReference"
		alias
			"get_NodeType"
		end

	get_base_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntityReference"
		alias
			"get_BaseURI"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlEntityReference"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlEntityReference"
		alias
			"set_Value"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlEntityReference"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlEntityReference"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlEntityReference"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XMLENTITYREFERENCE
