indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSerializationReader+Fixup"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_FIXUP_IN_SYSTEM_XML_XML_SERIALIZATION_READER

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (o: SYSTEM_OBJECT; callback: SYSTEM_XML_XML_SERIALIZATION_FIXUP_CALLBACK; count: INTEGER) is
		external
			"IL creator signature (System.Object, System.Xml.Serialization.XmlSerializationFixupCallback, System.Int32) use System.Xml.Serialization.XmlSerializationReader+Fixup"
		end

	frozen make_1 (o: SYSTEM_OBJECT; callback: SYSTEM_XML_XML_SERIALIZATION_FIXUP_CALLBACK; ids: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.Object, System.Xml.Serialization.XmlSerializationFixupCallback, System.String[]) use System.Xml.Serialization.XmlSerializationReader+Fixup"
		end

feature -- Access

	frozen get_ids: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Xml.Serialization.XmlSerializationReader+Fixup"
		alias
			"get_Ids"
		end

	frozen get_source: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReader+Fixup"
		alias
			"get_Source"
		end

	frozen get_callback: SYSTEM_XML_XML_SERIALIZATION_FIXUP_CALLBACK is
		external
			"IL signature (): System.Xml.Serialization.XmlSerializationFixupCallback use System.Xml.Serialization.XmlSerializationReader+Fixup"
		alias
			"get_Callback"
		end

feature -- Element Change

	frozen set_source (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader+Fixup"
		alias
			"set_Source"
		end

end -- class SYSTEM_XML_FIXUP_IN_SYSTEM_XML_XML_SERIALIZATION_READER
