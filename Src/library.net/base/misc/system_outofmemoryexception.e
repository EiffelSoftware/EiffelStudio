indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.OutOfMemoryException"

external class
	SYSTEM_OUTOFMEMORYEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_outofmemoryexception_1,
	make_outofmemoryexception,
	make_outofmemoryexception_2

feature {NONE} -- Initialization

	frozen make_outofmemoryexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.OutOfMemoryException"
		end

	frozen make_outofmemoryexception is
		external
			"IL creator use System.OutOfMemoryException"
		end

	frozen make_outofmemoryexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.OutOfMemoryException"
		end

end -- class SYSTEM_OUTOFMEMORYEXCEPTION
