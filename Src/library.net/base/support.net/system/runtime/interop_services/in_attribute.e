indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.InAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	IN_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_in_attribute

feature {NONE} -- Initialization

	frozen make_in_attribute is
		external
			"IL creator use System.Runtime.InteropServices.InAttribute"
		end

end -- class IN_ATTRIBUTE
