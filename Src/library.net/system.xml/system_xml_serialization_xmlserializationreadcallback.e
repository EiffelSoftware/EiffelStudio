indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSerializationReadCallback"

frozen external class
	SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADCALLBACK

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
	make_xmlserializationreadcallback

feature {NONE} -- Initialization

	frozen make_xmlserializationreadcallback (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Xml.Serialization.XmlSerializationReadCallback"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.XmlSerializationReadCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): ANY is
		external
			"IL signature (System.IAsyncResult): System.Object use System.Xml.Serialization.XmlSerializationReadCallback"
		alias
			"EndInvoke"
		end

	invoke: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReadCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADCALLBACK
