indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.CustomConstantAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	CUSTOM_CONSTANT_ATTRIBUTE

inherit
	ATTRIBUTE

feature -- Access

	get_value: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Runtime.CompilerServices.CustomConstantAttribute"
		alias
			"get_Value"
		end

end -- class CUSTOM_CONSTANT_ATTRIBUTE
