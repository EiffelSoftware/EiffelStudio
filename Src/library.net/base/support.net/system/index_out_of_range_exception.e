indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IndexOutOfRangeException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	INDEX_OUT_OF_RANGE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_index_out_of_range_exception,
	make_index_out_of_range_exception_1,
	make_index_out_of_range_exception_2

feature {NONE} -- Initialization

	frozen make_index_out_of_range_exception is
		external
			"IL creator use System.IndexOutOfRangeException"
		end

	frozen make_index_out_of_range_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.IndexOutOfRangeException"
		end

	frozen make_index_out_of_range_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IndexOutOfRangeException"
		end

end -- class INDEX_OUT_OF_RANGE_EXCEPTION
