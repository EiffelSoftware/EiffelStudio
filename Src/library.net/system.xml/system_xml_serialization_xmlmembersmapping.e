indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlMembersMapping"

external class
	SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING

inherit
	SYSTEM_XML_SERIALIZATION_XMLMAPPING

create {NONE}

feature -- Access

	frozen get_type_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_TypeNamespace"
		end

	frozen get_item (index: INTEGER): SYSTEM_XML_SERIALIZATION_XMLMEMBERMAPPING is
		external
			"IL signature (System.Int32): System.Xml.Serialization.XmlMemberMapping use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_Item"
		end

	frozen get_element_name: STRING is
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

	frozen get_type_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_TypeName"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlMembersMapping"
		alias
			"get_Namespace"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING
