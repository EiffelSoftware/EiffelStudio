indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.SystemException"

external class
	SYSTEM_SYSTEMEXCEPTION

inherit
	SYSTEM_EXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_systemexception_2,
	make_systemexception_1,
	make_systemexception

feature {NONE} -- Initialization

	frozen make_systemexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.SystemException"
		end

	frozen make_systemexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.SystemException"
		end

	frozen make_systemexception is
		external
			"IL creator use System.SystemException"
		end

end -- class SYSTEM_SYSTEMEXCEPTION
