indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.CompilerServices.MethodImplAttribute"

frozen external class
	SYSTEM_RUNTIME_COMPILERSERVICES_METHODIMPLATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_method_impl_attribute_2,
	make_method_impl_attribute_1,
	make_method_impl_attribute

feature {NONE} -- Initialization

	frozen make_method_impl_attribute_2 is
		external
			"IL creator use System.Runtime.CompilerServices.MethodImplAttribute"
		end

	frozen make_method_impl_attribute_1 (value2: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.CompilerServices.MethodImplAttribute"
		end

	frozen make_method_impl_attribute (method_impl_options: INTEGER) is
			-- Valid values for `method_impl_options' are:
			-- Unmanaged = 4
			-- ForwardRef = 16
			-- PreserveSig = 128
			-- InternalCall = 4096
			-- Synchronized = 32
			-- NoInlining = 8
		require
			valid_method_impl_options: method_impl_options = 4 or method_impl_options = 16 or method_impl_options = 128 or method_impl_options = 4096 or method_impl_options = 32 or method_impl_options = 8
		external
			"IL creator signature (enum System.Runtime.CompilerServices.MethodImplOptions) use System.Runtime.CompilerServices.MethodImplAttribute"
		end

feature -- Access

	frozen method_code_type: INTEGER is
		external
			"IL field signature :System.Runtime.CompilerServices.MethodCodeType use System.Runtime.CompilerServices.MethodImplAttribute"
		alias
			"MethodCodeType"
		end

	frozen get_value: INTEGER is
		external
			"IL signature (): enum System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplAttribute"
		alias
			"get_Value"
		ensure
			valid_method_impl_options: Result = 4 or Result = 16 or Result = 128 or Result = 4096 or Result = 32 or Result = 8
		end

end -- class SYSTEM_RUNTIME_COMPILERSERVICES_METHODIMPLATTRIBUTE
