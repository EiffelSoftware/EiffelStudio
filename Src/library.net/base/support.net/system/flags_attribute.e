indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.FlagsAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	FLAGS_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_flags_attribute

feature {NONE} -- Initialization

	frozen make_flags_attribute is
		external
			"IL creator use System.FlagsAttribute"
		end

end -- class FLAGS_ATTRIBUTE
