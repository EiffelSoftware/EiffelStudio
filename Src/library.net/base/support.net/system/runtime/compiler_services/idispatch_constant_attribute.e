indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.IDispatchConstantAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	IDISPATCH_CONSTANT_ATTRIBUTE

inherit
	CUSTOM_CONSTANT_ATTRIBUTE

create
	make_idispatch_constant_attribute

feature {NONE} -- Initialization

	frozen make_idispatch_constant_attribute is
		external
			"IL creator use System.Runtime.CompilerServices.IDispatchConstantAttribute"
		end

feature -- Access

	get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.CompilerServices.IDispatchConstantAttribute"
		alias
			"get_Value"
		end

end -- class IDISPATCH_CONSTANT_ATTRIBUTE
