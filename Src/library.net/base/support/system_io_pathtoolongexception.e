indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.PathTooLongException"

external class
	SYSTEM_IO_PATHTOOLONGEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_pathtoolongexception_1,
	make_pathtoolongexception_2,
	make_pathtoolongexception

feature {NONE} -- Initialization

	frozen make_pathtoolongexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.IO.PathTooLongException"
		end

	frozen make_pathtoolongexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.IO.PathTooLongException"
		end

	frozen make_pathtoolongexception is
		external
			"IL creator use System.IO.PathTooLongException"
		end

end -- class SYSTEM_IO_PATHTOOLONGEXCEPTION
