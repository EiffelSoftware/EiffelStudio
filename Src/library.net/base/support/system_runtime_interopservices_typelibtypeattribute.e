indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.TypeLibTypeAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBTYPEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_typelibtypeattribute,
	make_typelibtypeattribute_1

feature {NONE} -- Initialization

	frozen make_typelibtypeattribute (flags: SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBTYPEFLAGS) is
		external
			"IL creator signature (System.Runtime.InteropServices.TypeLibTypeFlags) use System.Runtime.InteropServices.TypeLibTypeAttribute"
		end

	frozen make_typelibtypeattribute_1 (flags: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.TypeLibTypeAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBTYPEFLAGS is
		external
			"IL signature (): System.Runtime.InteropServices.TypeLibTypeFlags use System.Runtime.InteropServices.TypeLibTypeAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBTYPEATTRIBUTE
