indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.MemberFilter"

frozen external class
	SYSTEM_REFLECTION_MEMBERFILTER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_member_filter

feature {NONE} -- Initialization

	frozen make_member_filter (object: ANY; method2: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Reflection.MemberFilter"
		end

feature -- Basic Operations

	begin_invoke (m: SYSTEM_REFLECTION_MEMBERINFO; filterCriteria: ANY; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Reflection.MemberInfo, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Reflection.MemberFilter"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Reflection.MemberFilter"
		alias
			"EndInvoke"
		end

	invoke (m: SYSTEM_REFLECTION_MEMBERINFO; filterCriteria: ANY): BOOLEAN is
		external
			"IL signature (System.Reflection.MemberInfo, System.Object): System.Boolean use System.Reflection.MemberFilter"
		alias
			"Invoke"
		end

end -- class SYSTEM_REFLECTION_MEMBERFILTER
