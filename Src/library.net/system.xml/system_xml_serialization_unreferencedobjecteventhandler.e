indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.UnreferencedObjectEventHandler"

frozen external class
	SYSTEM_XML_SERIALIZATION_UNREFERENCEDOBJECTEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
		rename
			is_equal as equals_object	
		end
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			is_equal as equals_object
		end

create
	make_unreferencedobjecteventhandler

feature {NONE} -- Initialization

	frozen make_unreferencedobjecteventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Xml.Serialization.UnreferencedObjectEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_XML_SERIALIZATION_UNREFERENCEDOBJECTEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Xml.Serialization.UnreferencedObjectEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.UnreferencedObjectEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Serialization.UnreferencedObjectEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_XML_SERIALIZATION_UNREFERENCEDOBJECTEVENTARGS) is
		external
			"IL signature (System.Object, System.Xml.Serialization.UnreferencedObjectEventArgs): System.Void use System.Xml.Serialization.UnreferencedObjectEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_SERIALIZATION_UNREFERENCEDOBJECTEVENTHANDLER
