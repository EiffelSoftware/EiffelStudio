indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.RankException"

external class
	SYSTEM_RANKEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_rankexception_2,
	make_rankexception_1,
	make_rankexception

feature {NONE} -- Initialization

	frozen make_rankexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.RankException"
		end

	frozen make_rankexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.RankException"
		end

	frozen make_rankexception is
		external
			"IL creator use System.RankException"
		end

end -- class SYSTEM_RANKEXCEPTION
