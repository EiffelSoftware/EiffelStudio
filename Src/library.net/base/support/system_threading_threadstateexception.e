indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.ThreadStateException"

external class
	SYSTEM_THREADING_THREADSTATEEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_threadstateexception_2,
	make_threadstateexception,
	make_threadstateexception_1

feature {NONE} -- Initialization

	frozen make_threadstateexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Threading.ThreadStateException"
		end

	frozen make_threadstateexception is
		external
			"IL creator use System.Threading.ThreadStateException"
		end

	frozen make_threadstateexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Threading.ThreadStateException"
		end

end -- class SYSTEM_THREADING_THREADSTATEEXCEPTION
