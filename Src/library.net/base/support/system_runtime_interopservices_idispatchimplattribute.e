indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.IDispatchImplAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_IDISPATCHIMPLATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_idispatchimplattribute_1,
	make_idispatchimplattribute

feature {NONE} -- Initialization

	frozen make_idispatchimplattribute_1 (impl_type: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.IDispatchImplAttribute"
		end

	frozen make_idispatchimplattribute (impl_type: SYSTEM_RUNTIME_INTEROPSERVICES_IDISPATCHIMPLTYPE) is
		external
			"IL creator signature (System.Runtime.InteropServices.IDispatchImplType) use System.Runtime.InteropServices.IDispatchImplAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_RUNTIME_INTEROPSERVICES_IDISPATCHIMPLTYPE is
		external
			"IL signature (): System.Runtime.InteropServices.IDispatchImplType use System.Runtime.InteropServices.IDispatchImplAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_IDISPATCHIMPLATTRIBUTE
