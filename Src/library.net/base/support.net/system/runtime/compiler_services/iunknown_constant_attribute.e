indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.IUnknownConstantAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	IUNKNOWN_CONSTANT_ATTRIBUTE

inherit
	CUSTOM_CONSTANT_ATTRIBUTE

create
	make_iunknown_constant_attribute

feature {NONE} -- Initialization

	frozen make_iunknown_constant_attribute is
		external
			"IL creator use System.Runtime.CompilerServices.IUnknownConstantAttribute"
		end

feature -- Access

	get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Runtime.CompilerServices.IUnknownConstantAttribute"
		alias
			"get_Value"
		end

end -- class IUNKNOWN_CONSTANT_ATTRIBUTE
