indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.TypeFilter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	TYPE_FILTER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_type_filter

feature {NONE} -- Initialization

	frozen make_type_filter (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Reflection.TypeFilter"
		end

feature -- Basic Operations

	begin_invoke (m: TYPE; filter_criteria: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Type, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Reflection.TypeFilter"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Reflection.TypeFilter"
		alias
			"EndInvoke"
		end

	invoke (m: TYPE; filter_criteria: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Type, System.Object): System.Boolean use System.Reflection.TypeFilter"
		alias
			"Invoke"
		end

end -- class TYPE_FILTER
