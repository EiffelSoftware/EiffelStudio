indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.AxHost+AboutBoxDelegate"

frozen external class
	ABOUTBOXDELEGATE_IN_SYSTEM_WINDOWS_FORMS_AXHOST

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
	make_aboutboxdelegate

feature {NONE} -- Initialization

	frozen make_aboutboxdelegate (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Windows.Forms.AxHost+AboutBoxDelegate"
		end

feature -- Basic Operations

	begin_invoke (callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Windows.Forms.AxHost+AboutBoxDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Windows.Forms.AxHost+AboutBoxDelegate"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.Windows.Forms.AxHost+AboutBoxDelegate"
		alias
			"Invoke"
		end

end -- class ABOUTBOXDELEGATE_IN_SYSTEM_WINDOWS_FORMS_AXHOST
