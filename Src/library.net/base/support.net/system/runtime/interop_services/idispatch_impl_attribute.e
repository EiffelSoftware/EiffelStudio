indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.IDispatchImplAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	IDISPATCH_IMPL_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_idispatch_impl_attribute_1,
	make_idispatch_impl_attribute

feature {NONE} -- Initialization

	frozen make_idispatch_impl_attribute_1 (impl_type: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.IDispatchImplAttribute"
		end

	frozen make_idispatch_impl_attribute (impl_type: IDISPATCH_IMPL_TYPE) is
		external
			"IL creator signature (System.Runtime.InteropServices.IDispatchImplType) use System.Runtime.InteropServices.IDispatchImplAttribute"
		end

feature -- Access

	frozen get_value: IDISPATCH_IMPL_TYPE is
		external
			"IL signature (): System.Runtime.InteropServices.IDispatchImplType use System.Runtime.InteropServices.IDispatchImplAttribute"
		alias
			"get_Value"
		end

end -- class IDISPATCH_IMPL_ATTRIBUTE
