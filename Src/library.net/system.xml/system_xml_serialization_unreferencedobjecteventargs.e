indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.UnreferencedObjectEventArgs"

external class
	SYSTEM_XML_SERIALIZATION_UNREFERENCEDOBJECTEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_unreferencedobjecteventargs

feature {NONE} -- Initialization

	frozen make_unreferencedobjecteventargs (o: ANY; id: STRING) is
		external
			"IL creator signature (System.Object, System.String) use System.Xml.Serialization.UnreferencedObjectEventArgs"
		end

feature -- Access

	frozen get_unreferenced_id: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.UnreferencedObjectEventArgs"
		alias
			"get_UnreferencedId"
		end

	frozen get_unreferenced_object: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.UnreferencedObjectEventArgs"
		alias
			"get_UnreferencedObject"
		end

end -- class SYSTEM_XML_SERIALIZATION_UNREFERENCEDOBJECTEVENTARGS
