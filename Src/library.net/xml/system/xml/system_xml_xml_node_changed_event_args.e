indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlNodeChangedEventArgs"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_NODE_CHANGED_EVENT_ARGS

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_node: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNodeChangedEventArgs"
		alias
			"get_Node"
		end

	frozen get_new_parent: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNodeChangedEventArgs"
		alias
			"get_NewParent"
		end

	frozen get_old_parent: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNodeChangedEventArgs"
		alias
			"get_OldParent"
		end

	frozen get_action: SYSTEM_XML_XML_NODE_CHANGED_ACTION is
		external
			"IL signature (): System.Xml.XmlNodeChangedAction use System.Xml.XmlNodeChangedEventArgs"
		alias
			"get_Action"
		end

end -- class SYSTEM_XML_XML_NODE_CHANGED_EVENT_ARGS
