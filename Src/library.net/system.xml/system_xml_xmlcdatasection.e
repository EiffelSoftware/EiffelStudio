indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlCDataSection"

external class
	SYSTEM_XML_XMLCDATASECTION

inherit
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_XML_XMLCHARACTERDATA
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create {NONE}

feature -- Access

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlCDataSection"
		alias
			"get_LocalName"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlCDataSection"
		alias
			"get_NodeType"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlCDataSection"
		alias
			"get_Name"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlCDataSection"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlCDataSection"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlCDataSection"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XMLCDATASECTION
