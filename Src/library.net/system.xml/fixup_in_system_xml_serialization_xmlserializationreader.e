indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSerializationReader+Fixup"

external class
	FIXUP_IN_SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (o: ANY; callback: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONFIXUPCALLBACK; count: INTEGER) is
		external
			"IL creator signature (System.Object, System.Xml.Serialization.XmlSerializationFixupCallback, System.Int32) use System.Xml.Serialization.XmlSerializationReader+Fixup"
		end

	frozen make_1 (o: ANY; callback: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONFIXUPCALLBACK; ids: ARRAY [STRING]) is
		external
			"IL creator signature (System.Object, System.Xml.Serialization.XmlSerializationFixupCallback, System.String[]) use System.Xml.Serialization.XmlSerializationReader+Fixup"
		end

feature -- Access

	frozen get_ids: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Xml.Serialization.XmlSerializationReader+Fixup"
		alias
			"get_Ids"
		end

	frozen get_source: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReader+Fixup"
		alias
			"get_Source"
		end

	frozen get_callback: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONFIXUPCALLBACK is
		external
			"IL signature (): System.Xml.Serialization.XmlSerializationFixupCallback use System.Xml.Serialization.XmlSerializationReader+Fixup"
		alias
			"get_Callback"
		end

feature -- Element Change

	frozen set_source (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader+Fixup"
		alias
			"set_Source"
		end

end -- class FIXUP_IN_SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER
