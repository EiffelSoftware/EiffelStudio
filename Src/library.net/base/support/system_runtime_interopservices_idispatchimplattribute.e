indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.IDispatchImplAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_IDISPATCHIMPLATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_idispatch_impl_attribute_1,
	make_idispatch_impl_attribute

feature {NONE} -- Initialization

	frozen make_idispatch_impl_attribute_1 (implType: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.IDispatchImplAttribute"
		end

	frozen make_idispatch_impl_attribute (impl_type: INTEGER) is
			-- Valid values for `impl_type' are:
			-- SystemDefinedImpl = 0
			-- InternalImpl = 1
			-- CompatibleImpl = 2
		require
			valid_idispatch_impl_type: impl_type = 0 or impl_type = 1 or impl_type = 2
		external
			"IL creator signature (enum System.Runtime.InteropServices.IDispatchImplType) use System.Runtime.InteropServices.IDispatchImplAttribute"
		end

feature -- Access

	frozen get_value: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.IDispatchImplType use System.Runtime.InteropServices.IDispatchImplAttribute"
		alias
			"get_Value"
		ensure
			valid_idispatch_impl_type: Result = 0 or Result = 1 or Result = 2
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_IDISPATCHIMPLATTRIBUTE
