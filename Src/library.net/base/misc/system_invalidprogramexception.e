indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.InvalidProgramException"

frozen external class
	SYSTEM_INVALIDPROGRAMEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidprogramexception_2,
	make_invalidprogramexception,
	make_invalidprogramexception_1

feature {NONE} -- Initialization

	frozen make_invalidprogramexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.InvalidProgramException"
		end

	frozen make_invalidprogramexception is
		external
			"IL creator use System.InvalidProgramException"
		end

	frozen make_invalidprogramexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.InvalidProgramException"
		end

end -- class SYSTEM_INVALIDPROGRAMEXCEPTION
