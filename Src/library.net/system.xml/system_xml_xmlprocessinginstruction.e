indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlProcessingInstruction"

external class
	SYSTEM_XML_XMLPROCESSINGINSTRUCTION

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

	frozen get_target: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_Target"
		end

	get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_Value"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_LocalName"
		end

	get_inner_text: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_InnerText"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlProcessingInstruction"
		alias
			"get_NodeType"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_Name"
		end

	frozen get_data: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_Data"
		end

feature -- Element Change

	frozen set_data (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"set_Data"
		end

	set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"set_Value"
		end

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlProcessingInstruction"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XMLPROCESSINGINSTRUCTION
