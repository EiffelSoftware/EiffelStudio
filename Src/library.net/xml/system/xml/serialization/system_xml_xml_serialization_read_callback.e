indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSerializationReadCallback"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_XML_XML_SERIALIZATION_READ_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_system_xml_xml_serialization_read_callback

feature {NONE} -- Initialization

	frozen make_system_xml_xml_serialization_read_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Xml.Serialization.XmlSerializationReadCallback"
		end

feature -- Basic Operations

	begin_invoke (callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.XmlSerializationReadCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): SYSTEM_OBJECT is
		external
			"IL signature (System.IAsyncResult): System.Object use System.Xml.Serialization.XmlSerializationReadCallback"
		alias
			"EndInvoke"
		end

	invoke: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReadCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_XML_SERIALIZATION_READ_CALLBACK
