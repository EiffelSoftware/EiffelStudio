indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.ValidationEventHandler"

frozen external class
	SYSTEM_XML_SCHEMA_VALIDATIONEVENTHANDLER

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
	make_validationeventhandler

feature {NONE} -- Initialization

	frozen make_validationeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Xml.Schema.ValidationEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_XML_SCHEMA_VALIDATIONEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Xml.Schema.ValidationEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Xml.Schema.ValidationEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Xml.Schema.ValidationEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_XML_SCHEMA_VALIDATIONEVENTARGS) is
		external
			"IL signature (System.Object, System.Xml.Schema.ValidationEventArgs): System.Void use System.Xml.Schema.ValidationEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_SCHEMA_VALIDATIONEVENTHANDLER
