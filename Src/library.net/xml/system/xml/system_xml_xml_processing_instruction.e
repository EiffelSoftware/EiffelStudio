indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlProcessingInstruction"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_PROCESSING_INSTRUCTION

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

create {NONE}

feature -- Access

	frozen get_target: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_Target"
		end

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_Value"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_LocalName"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_InnerText"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlProcessingInstruction"
		alias
			"get_NodeType"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_Name"
		end

	frozen get_data: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlProcessingInstruction"
		alias
			"get_Data"
		end

feature -- Element Change

	frozen set_data (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"set_Data"
		end

	set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"set_Value"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlProcessingInstruction"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlProcessingInstruction"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XML_PROCESSING_INSTRUCTION
