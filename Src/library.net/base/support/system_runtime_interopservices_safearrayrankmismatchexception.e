indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.SafeArrayRankMismatchException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_SAFEARRAYRANKMISMATCHEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_safe_array_rank_mismatch_exception,
	make_safe_array_rank_mismatch_exception_1,
	make_safe_array_rank_mismatch_exception_2

feature {NONE} -- Initialization

	frozen make_safe_array_rank_mismatch_exception is
		external
			"IL creator use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

	frozen make_safe_array_rank_mismatch_exception_1 (message2: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

	frozen make_safe_array_rank_mismatch_exception_2 (message2: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_SAFEARRAYRANKMISMATCHEXCEPTION
