indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.SafeArrayRankMismatchException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SAFE_ARRAY_RANK_MISMATCH_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_safe_array_rank_mismatch_exception_1,
	make_safe_array_rank_mismatch_exception,
	make_safe_array_rank_mismatch_exception_2

feature {NONE} -- Initialization

	frozen make_safe_array_rank_mismatch_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

	frozen make_safe_array_rank_mismatch_exception is
		external
			"IL creator use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

	frozen make_safe_array_rank_mismatch_exception_2 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

end -- class SAFE_ARRAY_RANK_MISMATCH_EXCEPTION
