indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.StackOverflowException"

frozen external class
	SYSTEM_STACKOVERFLOWEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_stackoverflowexception_1,
	make_stackoverflowexception_2,
	make_stackoverflowexception

feature {NONE} -- Initialization

	frozen make_stackoverflowexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.StackOverflowException"
		end

	frozen make_stackoverflowexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.StackOverflowException"
		end

	frozen make_stackoverflowexception is
		external
			"IL creator use System.StackOverflowException"
		end

end -- class SYSTEM_STACKOVERFLOWEXCEPTION
