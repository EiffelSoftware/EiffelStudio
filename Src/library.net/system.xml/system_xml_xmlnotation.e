indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNotation"

external class
	SYSTEM_XML_XMLNOTATION

inherit
	SYSTEM_XML_XMLNODE
		redefine
			set_inner_xml,
			get_inner_xml,
			get_outer_xml,
			get_is_read_only
		end
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create {NONE}

feature -- Access

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNotation"
		alias
			"get_Name"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNotation"
		alias
			"get_LocalName"
		end

	frozen get_public_id: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNotation"
		alias
			"get_PublicId"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNotation"
		alias
			"get_IsReadOnly"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlNotation"
		alias
			"get_NodeType"
		end

	get_inner_xml: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNotation"
		alias
			"get_InnerXml"
		end

	frozen get_system_id: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNotation"
		alias
			"get_SystemId"
		end

	get_outer_xml: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNotation"
		alias
			"get_OuterXml"
		end

feature -- Element Change

	set_inner_xml (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNotation"
		alias
			"set_InnerXml"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlNotation"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlNotation"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlNotation"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XMLNOTATION
