indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.TypeLibTypeAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBTYPEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_type_lib_type_attribute,
	make_type_lib_type_attribute_1

feature {NONE} -- Initialization

	frozen make_type_lib_type_attribute (flags: INTEGER) is
			-- Valid values for `flags' are:
			-- FAppObject = 1
			-- FCanCreate = 2
			-- FLicensed = 4
			-- FPreDeclId = 8
			-- FHidden = 16
			-- FControl = 32
			-- FDual = 64
			-- FNonExtensible = 128
			-- FOleAutomation = 256
			-- FRestricted = 512
			-- FAggregatable = 1024
			-- FReplaceable = 2048
			-- FDispatchable = 4096
			-- FReverseBind = 8192
		require
			valid_type_lib_type_flags: flags = 1 or flags = 2 or flags = 4 or flags = 8 or flags = 16 or flags = 32 or flags = 64 or flags = 128 or flags = 256 or flags = 512 or flags = 1024 or flags = 2048 or flags = 4096 or flags = 8192
		external
			"IL creator signature (enum System.Runtime.InteropServices.TypeLibTypeFlags) use System.Runtime.InteropServices.TypeLibTypeAttribute"
		end

	frozen make_type_lib_type_attribute_1 (flags: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.TypeLibTypeAttribute"
		end

feature -- Access

	frozen get_value: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.TypeLibTypeFlags use System.Runtime.InteropServices.TypeLibTypeAttribute"
		alias
			"get_Value"
		ensure
			valid_type_lib_type_flags: Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 256 or Result = 512 or Result = 1024 or Result = 2048 or Result = 4096 or Result = 8192
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBTYPEATTRIBUTE
