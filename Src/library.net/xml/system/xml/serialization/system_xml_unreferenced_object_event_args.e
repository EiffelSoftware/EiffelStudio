indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.UnreferencedObjectEventArgs"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_UNREFERENCED_OBJECT_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_xml_unreferenced_object_event_args

feature {NONE} -- Initialization

	frozen make_system_xml_unreferenced_object_event_args (o: SYSTEM_OBJECT; id: SYSTEM_STRING) is
		external
			"IL creator signature (System.Object, System.String) use System.Xml.Serialization.UnreferencedObjectEventArgs"
		end

feature -- Access

	frozen get_unreferenced_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.UnreferencedObjectEventArgs"
		alias
			"get_UnreferencedId"
		end

	frozen get_unreferenced_object: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.UnreferencedObjectEventArgs"
		alias
			"get_UnreferencedObject"
		end

end -- class SYSTEM_XML_UNREFERENCED_OBJECT_EVENT_ARGS
