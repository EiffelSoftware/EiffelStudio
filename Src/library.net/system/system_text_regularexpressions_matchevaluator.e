indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Text.RegularExpressions.MatchEvaluator"

frozen external class
	SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHEVALUATOR

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
	make_matchevaluator

feature {NONE} -- Initialization

	frozen make_matchevaluator (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Text.RegularExpressions.MatchEvaluator"
		end

feature -- Basic Operations

	begin_invoke (match: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Text.RegularExpressions.Match, System.AsyncCallback, System.Object): System.IAsyncResult use System.Text.RegularExpressions.MatchEvaluator"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT): STRING is
		external
			"IL signature (System.IAsyncResult): System.String use System.Text.RegularExpressions.MatchEvaluator"
		alias
			"EndInvoke"
		end

	invoke (match: SYSTEM_TEXT_REGULAREXPRESSIONS_MATCH): STRING is
		external
			"IL signature (System.Text.RegularExpressions.Match): System.String use System.Text.RegularExpressions.MatchEvaluator"
		alias
			"Invoke"
		end

end -- class SYSTEM_TEXT_REGULAREXPRESSIONS_MATCHEVALUATOR
