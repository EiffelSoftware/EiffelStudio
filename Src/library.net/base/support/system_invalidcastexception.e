indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.InvalidCastException"

external class
	SYSTEM_INVALIDCASTEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_invalidcastexception,
	make_invalidcastexception_2,
	make_invalidcastexception_1

feature {NONE} -- Initialization

	frozen make_invalidcastexception is
		external
			"IL creator use System.InvalidCastException"
		end

	frozen make_invalidcastexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.InvalidCastException"
		end

	frozen make_invalidcastexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.InvalidCastException"
		end

end -- class SYSTEM_INVALIDCASTEXCEPTION
