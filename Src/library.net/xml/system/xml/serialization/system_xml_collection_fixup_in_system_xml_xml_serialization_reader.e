indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_COLLECTION_FIXUP_IN_SYSTEM_XML_XML_SERIALIZATION_READER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (collection: SYSTEM_OBJECT; callback: SYSTEM_XML_XML_SERIALIZATION_COLLECTION_FIXUP_CALLBACK; collection_items: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object, System.Xml.Serialization.XmlSerializationCollectionFixupCallback, System.Object) use System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
		end

feature -- Access

	frozen get_collection: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
		alias
			"get_Collection"
		end

	frozen get_collection_items: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
		alias
			"get_CollectionItems"
		end

	frozen get_callback: SYSTEM_XML_XML_SERIALIZATION_COLLECTION_FIXUP_CALLBACK is
		external
			"IL signature (): System.Xml.Serialization.XmlSerializationCollectionFixupCallback use System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
		alias
			"get_Callback"
		end

end -- class SYSTEM_XML_COLLECTION_FIXUP_IN_SYSTEM_XML_XML_SERIALIZATION_READER
