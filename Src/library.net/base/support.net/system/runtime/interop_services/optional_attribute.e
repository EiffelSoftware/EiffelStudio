indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.OptionalAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	OPTIONAL_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_optional_attribute

feature {NONE} -- Initialization

	frozen make_optional_attribute is
		external
			"IL creator use System.Runtime.InteropServices.OptionalAttribute"
		end

end -- class OPTIONAL_ATTRIBUTE
