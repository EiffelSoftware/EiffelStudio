indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSerializationReader+CollectionFixup"

external class
	COLLECTIONFIXUP_IN_SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER

create
	make

feature {NONE} -- Initialization

	frozen make (collection: ANY; callback: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONCOLLECTIONFIXUPCALLBACK; collection_items: ANY) is
		external
			"IL creator signature (System.Object, System.Xml.Serialization.XmlSerializationCollectionFixupCallback, System.Object) use System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
		end

feature -- Access

	frozen get_collection: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
		alias
			"get_Collection"
		end

	frozen get_collection_items: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
		alias
			"get_CollectionItems"
		end

	frozen get_callback: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONCOLLECTIONFIXUPCALLBACK is
		external
			"IL signature (): System.Xml.Serialization.XmlSerializationCollectionFixupCallback use System.Xml.Serialization.XmlSerializationReader+CollectionFixup"
		alias
			"get_Callback"
		end

end -- class COLLECTIONFIXUP_IN_SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER
