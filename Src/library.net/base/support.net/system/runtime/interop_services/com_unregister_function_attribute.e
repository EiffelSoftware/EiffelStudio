indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ComUnregisterFunctionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	COM_UNREGISTER_FUNCTION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_com_unregister_function_attribute

feature {NONE} -- Initialization

	frozen make_com_unregister_function_attribute is
		external
			"IL creator use System.Runtime.InteropServices.ComUnregisterFunctionAttribute"
		end

end -- class COM_UNREGISTER_FUNCTION_ATTRIBUTE
