indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.RankException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RANK_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_rank_exception,
	make_rank_exception_2,
	make_rank_exception_1

feature {NONE} -- Initialization

	frozen make_rank_exception is
		external
			"IL creator use System.RankException"
		end

	frozen make_rank_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.RankException"
		end

	frozen make_rank_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.RankException"
		end

end -- class RANK_EXCEPTION
