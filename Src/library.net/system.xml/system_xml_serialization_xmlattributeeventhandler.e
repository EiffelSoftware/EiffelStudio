indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlAttributeEventHandler"

frozen external class
	SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEEVENTHANDLER

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
	make_xmlattributeeventhandler

feature {NONE} -- Initialization

	frozen make_xmlattributeeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Xml.Serialization.XmlAttributeEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Xml.Serialization.XmlAttributeEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Serialization.XmlAttributeEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Serialization.XmlAttributeEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEEVENTARGS) is
		external
			"IL signature (System.Object, System.Xml.Serialization.XmlAttributeEventArgs): System.Void use System.Xml.Serialization.XmlAttributeEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEEVENTHANDLER
