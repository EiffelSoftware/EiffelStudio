indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.CompilerServices.MethodImplAttribute"

frozen external class
	SYSTEM_RUNTIME_COMPILERSERVICES_METHODIMPLATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_methodimplattribute_2,
	make_methodimplattribute_1,
	make_methodimplattribute

feature {NONE} -- Initialization

	frozen make_methodimplattribute_2 is
		external
			"IL creator use System.Runtime.CompilerServices.MethodImplAttribute"
		end

	frozen make_methodimplattribute_1 (value: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.CompilerServices.MethodImplAttribute"
		end

	frozen make_methodimplattribute (method_impl_options: SYSTEM_RUNTIME_COMPILERSERVICES_METHODIMPLOPTIONS) is
		external
			"IL creator signature (System.Runtime.CompilerServices.MethodImplOptions) use System.Runtime.CompilerServices.MethodImplAttribute"
		end

feature -- Access

	frozen method_code_type: SYSTEM_RUNTIME_COMPILERSERVICES_METHODCODETYPE is
		external
			"IL field signature :System.Runtime.CompilerServices.MethodCodeType use System.Runtime.CompilerServices.MethodImplAttribute"
		alias
			"MethodCodeType"
		end

	frozen get_value: SYSTEM_RUNTIME_COMPILERSERVICES_METHODIMPLOPTIONS is
		external
			"IL signature (): System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_COMPILERSERVICES_METHODIMPLATTRIBUTE
