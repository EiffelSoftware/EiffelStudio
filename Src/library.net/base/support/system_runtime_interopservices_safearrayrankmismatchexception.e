indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.SafeArrayRankMismatchException"

external class
	SYSTEM_RUNTIME_INTEROPSERVICES_SAFEARRAYRANKMISMATCHEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_safearrayrankmismatchexception,
	make_safearrayrankmismatchexception_1,
	make_safearrayrankmismatchexception_2

feature {NONE} -- Initialization

	frozen make_safearrayrankmismatchexception is
		external
			"IL creator use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

	frozen make_safearrayrankmismatchexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

	frozen make_safearrayrankmismatchexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Runtime.InteropServices.SafeArrayRankMismatchException"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_SAFEARRAYRANKMISMATCHEXCEPTION
