indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.Emit.UnmanagedMarshal"

frozen external class
	SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL

create {NONE}

feature -- Access

	frozen get_base_type: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.UnmanagedType use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"get_BaseType"
		ensure
			valid_unmanaged_type: Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 15 or Result = 19 or Result = 20 or Result = 21 or Result = 22 or Result = 23 or Result = 25 or Result = 26 or Result = 27 or Result = 28 or Result = 29 or Result = 30 or Result = 31 or Result = 32 or Result = 34 or Result = 35 or Result = 36 or Result = 37 or Result = 38 or Result = 40 or Result = 42 or Result = 43 or Result = 44 or Result = 45
		end

	frozen get_element_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"get_ElementCount"
		end

	frozen get_unmanaged_type: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.UnmanagedType use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"get_GetUnmanagedType"
		ensure
			valid_unmanaged_type: Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 15 or Result = 19 or Result = 20 or Result = 21 or Result = 22 or Result = 23 or Result = 25 or Result = 26 or Result = 27 or Result = 28 or Result = 29 or Result = 30 or Result = 31 or Result = 32 or Result = 34 or Result = 35 or Result = 36 or Result = 37 or Result = 38 or Result = 40 or Result = 42 or Result = 43 or Result = 44 or Result = 45
		end

	frozen get_IID_guid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"get_IIDGuid"
		end

feature -- Basic Operations

	frozen define_unmanaged_marshal (unmanaged_type: INTEGER): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
			-- Valid values for `unmanaged_type' are:
			-- Bool = 2
			-- I1 = 3
			-- U1 = 4
			-- I2 = 5
			-- U2 = 6
			-- I4 = 7
			-- U4 = 8
			-- I8 = 9
			-- U8 = 10
			-- R4 = 11
			-- R8 = 12
			-- Currency = 15
			-- BStr = 19
			-- LPStr = 20
			-- LPWStr = 21
			-- LPTStr = 22
			-- ByValTStr = 23
			-- IUnknown = 25
			-- IDispatch = 26
			-- Struct = 27
			-- Interface = 28
			-- SafeArray = 29
			-- ByValArray = 30
			-- SysInt = 31
			-- SysUInt = 32
			-- VBByRefStr = 34
			-- AnsiBStr = 35
			-- TBStr = 36
			-- VariantBool = 37
			-- FunctionPtr = 38
			-- AsAny = 40
			-- LPArray = 42
			-- LPStruct = 43
			-- CustomMarshaler = 44
			-- Error = 45
		require
			valid_unmanaged_type: unmanaged_type = 2 or unmanaged_type = 3 or unmanaged_type = 4 or unmanaged_type = 5 or unmanaged_type = 6 or unmanaged_type = 7 or unmanaged_type = 8 or unmanaged_type = 9 or unmanaged_type = 10 or unmanaged_type = 11 or unmanaged_type = 12 or unmanaged_type = 15 or unmanaged_type = 19 or unmanaged_type = 20 or unmanaged_type = 21 or unmanaged_type = 22 or unmanaged_type = 23 or unmanaged_type = 25 or unmanaged_type = 26 or unmanaged_type = 27 or unmanaged_type = 28 or unmanaged_type = 29 or unmanaged_type = 30 or unmanaged_type = 31 or unmanaged_type = 32 or unmanaged_type = 34 or unmanaged_type = 35 or unmanaged_type = 36 or unmanaged_type = 37 or unmanaged_type = 38 or unmanaged_type = 40 or unmanaged_type = 42 or unmanaged_type = 43 or unmanaged_type = 44 or unmanaged_type = 45
		external
			"IL static signature (enum System.Runtime.InteropServices.UnmanagedType): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineUnmanagedMarshal"
		end

	frozen define_by_val_array (elemCount: INTEGER): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
		external
			"IL static signature (System.Int32): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineByValArray"
		end

	frozen define_safe_array (elem_type: INTEGER): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
			-- Valid values for `elem_type' are:
			-- Bool = 2
			-- I1 = 3
			-- U1 = 4
			-- I2 = 5
			-- U2 = 6
			-- I4 = 7
			-- U4 = 8
			-- I8 = 9
			-- U8 = 10
			-- R4 = 11
			-- R8 = 12
			-- Currency = 15
			-- BStr = 19
			-- LPStr = 20
			-- LPWStr = 21
			-- LPTStr = 22
			-- ByValTStr = 23
			-- IUnknown = 25
			-- IDispatch = 26
			-- Struct = 27
			-- Interface = 28
			-- SafeArray = 29
			-- ByValArray = 30
			-- SysInt = 31
			-- SysUInt = 32
			-- VBByRefStr = 34
			-- AnsiBStr = 35
			-- TBStr = 36
			-- VariantBool = 37
			-- FunctionPtr = 38
			-- AsAny = 40
			-- LPArray = 42
			-- LPStruct = 43
			-- CustomMarshaler = 44
			-- Error = 45
		require
			valid_unmanaged_type: elem_type = 2 or elem_type = 3 or elem_type = 4 or elem_type = 5 or elem_type = 6 or elem_type = 7 or elem_type = 8 or elem_type = 9 or elem_type = 10 or elem_type = 11 or elem_type = 12 or elem_type = 15 or elem_type = 19 or elem_type = 20 or elem_type = 21 or elem_type = 22 or elem_type = 23 or elem_type = 25 or elem_type = 26 or elem_type = 27 or elem_type = 28 or elem_type = 29 or elem_type = 30 or elem_type = 31 or elem_type = 32 or elem_type = 34 or elem_type = 35 or elem_type = 36 or elem_type = 37 or elem_type = 38 or elem_type = 40 or elem_type = 42 or elem_type = 43 or elem_type = 44 or elem_type = 45
		external
			"IL static signature (enum System.Runtime.InteropServices.UnmanagedType): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineSafeArray"
		end

	frozen define_lp_array (elem_type: INTEGER): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
			-- Valid values for `elem_type' are:
			-- Bool = 2
			-- I1 = 3
			-- U1 = 4
			-- I2 = 5
			-- U2 = 6
			-- I4 = 7
			-- U4 = 8
			-- I8 = 9
			-- U8 = 10
			-- R4 = 11
			-- R8 = 12
			-- Currency = 15
			-- BStr = 19
			-- LPStr = 20
			-- LPWStr = 21
			-- LPTStr = 22
			-- ByValTStr = 23
			-- IUnknown = 25
			-- IDispatch = 26
			-- Struct = 27
			-- Interface = 28
			-- SafeArray = 29
			-- ByValArray = 30
			-- SysInt = 31
			-- SysUInt = 32
			-- VBByRefStr = 34
			-- AnsiBStr = 35
			-- TBStr = 36
			-- VariantBool = 37
			-- FunctionPtr = 38
			-- AsAny = 40
			-- LPArray = 42
			-- LPStruct = 43
			-- CustomMarshaler = 44
			-- Error = 45
		require
			valid_unmanaged_type: elem_type = 2 or elem_type = 3 or elem_type = 4 or elem_type = 5 or elem_type = 6 or elem_type = 7 or elem_type = 8 or elem_type = 9 or elem_type = 10 or elem_type = 11 or elem_type = 12 or elem_type = 15 or elem_type = 19 or elem_type = 20 or elem_type = 21 or elem_type = 22 or elem_type = 23 or elem_type = 25 or elem_type = 26 or elem_type = 27 or elem_type = 28 or elem_type = 29 or elem_type = 30 or elem_type = 31 or elem_type = 32 or elem_type = 34 or elem_type = 35 or elem_type = 36 or elem_type = 37 or elem_type = 38 or elem_type = 40 or elem_type = 42 or elem_type = 43 or elem_type = 44 or elem_type = 45
		external
			"IL static signature (enum System.Runtime.InteropServices.UnmanagedType): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineLPArray"
		end

	frozen define_by_val_tstr (elemCount: INTEGER): SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL is
		external
			"IL static signature (System.Int32): System.Reflection.Emit.UnmanagedMarshal use System.Reflection.Emit.UnmanagedMarshal"
		alias
			"DefineByValTStr"
		end

end -- class SYSTEM_REFLECTION_EMIT_UNMANAGEDMARSHAL
