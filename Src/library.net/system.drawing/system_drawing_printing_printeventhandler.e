indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PrintEventHandler"

frozen external class
	SYSTEM_DRAWING_PRINTING_PRINTEVENTHANDLER

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
	make_printeventhandler

feature {NONE} -- Initialization

	frozen make_printeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Drawing.Printing.PrintEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Drawing.Printing.PrintEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Drawing.Printing.PrintEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Drawing.Printing.PrintEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DRAWING_PRINTING_PRINTEVENTARGS) is
		external
			"IL signature (System.Object, System.Drawing.Printing.PrintEventArgs): System.Void use System.Drawing.Printing.PrintEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DRAWING_PRINTING_PRINTEVENTHANDLER
