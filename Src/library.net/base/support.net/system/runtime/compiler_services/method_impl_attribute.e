indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.MethodImplAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	METHOD_IMPL_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_method_impl_attribute,
	make_method_impl_attribute_2,
	make_method_impl_attribute_1

feature {NONE} -- Initialization

	frozen make_method_impl_attribute (method_impl_options: METHOD_IMPL_OPTIONS) is
		external
			"IL creator signature (System.Runtime.CompilerServices.MethodImplOptions) use System.Runtime.CompilerServices.MethodImplAttribute"
		end

	frozen make_method_impl_attribute_2 is
		external
			"IL creator use System.Runtime.CompilerServices.MethodImplAttribute"
		end

	frozen make_method_impl_attribute_1 (value: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.CompilerServices.MethodImplAttribute"
		end

feature -- Access

	frozen method_code_type: METHOD_CODE_TYPE is
		external
			"IL field signature :System.Runtime.CompilerServices.MethodCodeType use System.Runtime.CompilerServices.MethodImplAttribute"
		alias
			"MethodCodeType"
		end

	frozen get_value: METHOD_IMPL_OPTIONS is
		external
			"IL signature (): System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplAttribute"
		alias
			"get_Value"
		end

end -- class METHOD_IMPL_ATTRIBUTE
