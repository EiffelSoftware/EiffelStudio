indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.UnverifiableCodeAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	UNVERIFIABLE_CODE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_unverifiable_code_attribute

feature {NONE} -- Initialization

	frozen make_unverifiable_code_attribute is
		external
			"IL creator use System.Security.UnverifiableCodeAttribute"
		end

end -- class UNVERIFIABLE_CODE_ATTRIBUTE
