indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSerializationFixupCallback"

frozen external class
	SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONFIXUPCALLBACK

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
	make_xmlserializationfixupcallback

feature {NONE} -- Initialization

	frozen make_xmlserializationfixupcallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Xml.Serialization.XmlSerializationFixupCallback"
		end

feature -- Basic Operations

	begin_invoke (fixup: ANY; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.XmlSerializationFixupCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Serialization.XmlSerializationFixupCallback"
		alias
			"EndInvoke"
		end

	invoke (fixup: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationFixupCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONFIXUPCALLBACK
