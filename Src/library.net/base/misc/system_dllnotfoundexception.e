indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.DllNotFoundException"

external class
	SYSTEM_DLLNOTFOUNDEXCEPTION

inherit
	SYSTEM_TYPELOADEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_dllnotfoundexception_2,
	make_dllnotfoundexception,
	make_dllnotfoundexception_1

feature {NONE} -- Initialization

	frozen make_dllnotfoundexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.DllNotFoundException"
		end

	frozen make_dllnotfoundexception is
		external
			"IL creator use System.DllNotFoundException"
		end

	frozen make_dllnotfoundexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.DllNotFoundException"
		end

end -- class SYSTEM_DLLNOTFOUNDEXCEPTION
