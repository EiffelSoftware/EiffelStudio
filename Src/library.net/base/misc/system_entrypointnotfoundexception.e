indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.EntryPointNotFoundException"

external class
	SYSTEM_ENTRYPOINTNOTFOUNDEXCEPTION

inherit
	SYSTEM_TYPELOADEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_entrypointnotfoundexception_1,
	make_entrypointnotfoundexception,
	make_entrypointnotfoundexception_2

feature {NONE} -- Initialization

	frozen make_entrypointnotfoundexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.EntryPointNotFoundException"
		end

	frozen make_entrypointnotfoundexception is
		external
			"IL creator use System.EntryPointNotFoundException"
		end

	frozen make_entrypointnotfoundexception_2 (message: STRING; inner: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.EntryPointNotFoundException"
		end

end -- class SYSTEM_ENTRYPOINTNOTFOUNDEXCEPTION
