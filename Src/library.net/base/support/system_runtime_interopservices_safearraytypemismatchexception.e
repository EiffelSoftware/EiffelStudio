indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.SafeArrayTypeMismatchException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_SAFEARRAYTYPEMISMATCHEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_safearraytypemismatchexception_2,
	make_safearraytypemismatchexception_1,
	make_safearraytypemismatchexception

feature {NONE} -- Initialization

	frozen make_safearraytypemismatchexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.SafeArrayTypeMismatchException"
		end

	frozen make_safearraytypemismatchexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.SafeArrayTypeMismatchException"
		end

	frozen make_safearraytypemismatchexception is
		external
			"IL creator use System.Runtime.InteropServices.SafeArrayTypeMismatchException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_SAFEARRAYTYPEMISMATCHEXCEPTION
