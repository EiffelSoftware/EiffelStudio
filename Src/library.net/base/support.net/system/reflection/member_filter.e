indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.MemberFilter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MEMBER_FILTER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_member_filter

feature {NONE} -- Initialization

	frozen make_member_filter (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Reflection.MemberFilter"
		end

feature -- Basic Operations

	begin_invoke (m: MEMBER_INFO; filter_criteria: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Reflection.MemberInfo, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Reflection.MemberFilter"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Reflection.MemberFilter"
		alias
			"EndInvoke"
		end

	invoke (m: MEMBER_INFO; filter_criteria: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Reflection.MemberInfo, System.Object): System.Boolean use System.Reflection.MemberFilter"
		alias
			"Invoke"
		end

end -- class MEMBER_FILTER
