indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Text.RegularExpressions.MatchEvaluator"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_MATCH_EVALUATOR

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_system_dll_match_evaluator

feature {NONE} -- Initialization

	frozen make_system_dll_match_evaluator (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Text.RegularExpressions.MatchEvaluator"
		end

feature -- Basic Operations

	begin_invoke (match: SYSTEM_DLL_MATCH; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Text.RegularExpressions.Match, System.AsyncCallback, System.Object): System.IAsyncResult use System.Text.RegularExpressions.MatchEvaluator"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): SYSTEM_STRING is
		external
			"IL signature (System.IAsyncResult): System.String use System.Text.RegularExpressions.MatchEvaluator"
		alias
			"EndInvoke"
		end

	invoke (match: SYSTEM_DLL_MATCH): SYSTEM_STRING is
		external
			"IL signature (System.Text.RegularExpressions.Match): System.String use System.Text.RegularExpressions.MatchEvaluator"
		alias
			"Invoke"
		end

end -- class SYSTEM_DLL_MATCH_EVALUATOR
