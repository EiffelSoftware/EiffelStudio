indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MethodInvoker"

frozen external class
	SYSTEM_WINDOWS_FORMS_METHODINVOKER

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
	make_methodinvoker

feature {NONE} -- Initialization

	frozen make_methodinvoker (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.MethodInvoker"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.MethodInvoker"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.MethodInvoker"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.Windows.Forms.MethodInvoker"
		alias
			"Invoke"
		end

end -- class SYSTEM_WINDOWS_FORMS_METHODINVOKER
