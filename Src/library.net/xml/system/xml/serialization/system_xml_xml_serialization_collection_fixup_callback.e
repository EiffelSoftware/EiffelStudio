indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSerializationCollectionFixupCallback"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_XML_XML_SERIALIZATION_COLLECTION_FIXUP_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_system_xml_xml_serialization_collection_fixup_callback

feature {NONE} -- Initialization

	frozen make_system_xml_xml_serialization_collection_fixup_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Xml.Serialization.XmlSerializationCollectionFixupCallback"
		end

feature -- Basic Operations

	begin_invoke (collection: SYSTEM_OBJECT; collection_items: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.XmlSerializationCollectionFixupCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Serialization.XmlSerializationCollectionFixupCallback"
		alias
			"EndInvoke"
		end

	invoke (collection: SYSTEM_OBJECT; collection_items: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object, System.Object): System.Void use System.Xml.Serialization.XmlSerializationCollectionFixupCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_XML_SERIALIZATION_COLLECTION_FIXUP_CALLBACK
