indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSerializationFixupCallback"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_XML_XML_SERIALIZATION_FIXUP_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_system_xml_xml_serialization_fixup_callback

feature {NONE} -- Initialization

	frozen make_system_xml_xml_serialization_fixup_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Xml.Serialization.XmlSerializationFixupCallback"
		end

feature -- Basic Operations

	begin_invoke (fixup: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.XmlSerializationFixupCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Serialization.XmlSerializationFixupCallback"
		alias
			"EndInvoke"
		end

	invoke (fixup: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationFixupCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_XML_SERIALIZATION_FIXUP_CALLBACK
