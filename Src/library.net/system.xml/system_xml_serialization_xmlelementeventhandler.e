indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlElementEventHandler"

frozen external class
	SYSTEM_XML_SERIALIZATION_XMLELEMENTEVENTHANDLER

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
	make_xmlelementeventhandler

feature {NONE} -- Initialization

	frozen make_xmlelementeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Xml.Serialization.XmlElementEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_XML_SERIALIZATION_XMLELEMENTEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Xml.Serialization.XmlElementEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.XmlElementEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Serialization.XmlElementEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_XML_SERIALIZATION_XMLELEMENTEVENTARGS) is
		external
			"IL signature (System.Object, System.Xml.Serialization.XmlElementEventArgs): System.Void use System.Xml.Serialization.XmlElementEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLELEMENTEVENTHANDLER
