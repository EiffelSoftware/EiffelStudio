indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.TypeLibFuncAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBFUNCATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_type_lib_func_attribute,
	make_type_lib_func_attribute_1

feature {NONE} -- Initialization

	frozen make_type_lib_func_attribute (flags: INTEGER) is
			-- Valid values for `flags' are:
			-- FRestricted = 1
			-- FSource = 2
			-- FBindable = 4
			-- FRequestEdit = 8
			-- FDisplayBind = 16
			-- FDefaultBind = 32
			-- FHidden = 64
			-- FUsesGetLastError = 128
			-- FDefaultCollelem = 256
			-- FUiDefault = 512
			-- FNonBrowsable = 1024
			-- FReplaceable = 2048
			-- FImmediateBind = 4096
		require
			valid_type_lib_func_flags: flags = 1 or flags = 2 or flags = 4 or flags = 8 or flags = 16 or flags = 32 or flags = 64 or flags = 128 or flags = 256 or flags = 512 or flags = 1024 or flags = 2048 or flags = 4096
		external
			"IL creator signature (enum System.Runtime.InteropServices.TypeLibFuncFlags) use System.Runtime.InteropServices.TypeLibFuncAttribute"
		end

	frozen make_type_lib_func_attribute_1 (flags: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.TypeLibFuncAttribute"
		end

feature -- Access

	frozen get_value: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.TypeLibFuncFlags use System.Runtime.InteropServices.TypeLibFuncAttribute"
		alias
			"get_Value"
		ensure
			valid_type_lib_func_flags: Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 256 or Result = 512 or Result = 1024 or Result = 2048 or Result = 4096
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_TYPELIBFUNCATTRIBUTE
