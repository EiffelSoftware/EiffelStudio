indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlMembersMapping"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_MEMBERS_MAPPING

inherit
	SYSTEM_XML_XML_MAPPING

create {NONE}

feature -- Access

	frozen get_type_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_TypeNamespace"
		end

	frozen get_item (index: INTEGER): SYSTEM_XML_XML_MEMBER_MAPPING is
		external
			"IL signature (System.Int32): System.Xml.Serialization.XmlMemberMapping use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_Item"
		end

	frozen get_element_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_ElementName"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_Count"
		end

	frozen get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_TypeName"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_Namespace"
		end

end -- class SYSTEM_XML_XML_MEMBERS_MAPPING
