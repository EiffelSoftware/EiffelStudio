indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.ThreadInterruptedException"

external class
	SYSTEM_THREADING_THREADINTERRUPTEDEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_threadinterruptedexception_2,
	make_threadinterruptedexception_1,
	make_threadinterruptedexception

feature {NONE} -- Initialization

	frozen make_threadinterruptedexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Threading.ThreadInterruptedException"
		end

	frozen make_threadinterruptedexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Threading.ThreadInterruptedException"
		end

	frozen make_threadinterruptedexception is
		external
			"IL creator use System.Threading.ThreadInterruptedException"
		end

end -- class SYSTEM_THREADING_THREADINTERRUPTEDEXCEPTION
