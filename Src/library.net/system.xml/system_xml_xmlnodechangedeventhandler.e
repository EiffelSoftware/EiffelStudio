indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNodeChangedEventHandler"

frozen external class
	SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER

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
	make_xmlnodechangedeventhandler

feature {NONE} -- Initialization

	frozen make_xmlnodechangedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Xml.XmlNodeChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_XML_XMLNODECHANGEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Xml.XmlNodeChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.XmlNodeChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.XmlNodeChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_XML_XMLNODECHANGEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Xml.XmlNodeChangedEventArgs): System.Void use System.Xml.XmlNodeChangedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_XMLNODECHANGEDEVENTHANDLER
