indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.UnreferencedObjectEventHandler"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_XML_UNREFERENCED_OBJECT_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_system_xml_unreferenced_object_event_handler

feature {NONE} -- Initialization

	frozen make_system_xml_unreferenced_object_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Xml.Serialization.UnreferencedObjectEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: SYSTEM_XML_UNREFERENCED_OBJECT_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Xml.Serialization.UnreferencedObjectEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.UnreferencedObjectEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Serialization.UnreferencedObjectEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: SYSTEM_XML_UNREFERENCED_OBJECT_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Xml.Serialization.UnreferencedObjectEventArgs): System.Void use System.Xml.Serialization.UnreferencedObjectEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_UNREFERENCED_OBJECT_EVENT_HANDLER
