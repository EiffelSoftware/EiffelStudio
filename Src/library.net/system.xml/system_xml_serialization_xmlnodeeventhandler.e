indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlNodeEventHandler"

frozen external class
	SYSTEM_XML_SERIALIZATION_XMLNODEEVENTHANDLER

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
	make_xmlnodeeventhandler

feature {NONE} -- Initialization

	frozen make_xmlnodeeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Xml.Serialization.XmlNodeEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_XML_SERIALIZATION_XMLNODEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Xml.Serialization.XmlNodeEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.XmlNodeEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Serialization.XmlNodeEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_XML_SERIALIZATION_XMLNODEEVENTARGS) is
		external
			"IL signature (System.Object, System.Xml.Serialization.XmlNodeEventArgs): System.Void use System.Xml.Serialization.XmlNodeEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLNODEEVENTHANDLER
