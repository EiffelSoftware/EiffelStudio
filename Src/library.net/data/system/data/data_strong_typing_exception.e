indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.StrongTypingException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_STRONG_TYPING_EXCEPTION

inherit
	DATA_DATA_EXCEPTION
	ISERIALIZABLE

create
	make_data_strong_typing_exception_1,
	make_data_strong_typing_exception

feature {NONE} -- Initialization

	frozen make_data_strong_typing_exception_1 (s: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Data.StrongTypingException"
		end

	frozen make_data_strong_typing_exception is
		external
			"IL creator use System.Data.StrongTypingException"
		end

end -- class DATA_STRONG_TYPING_EXCEPTION
