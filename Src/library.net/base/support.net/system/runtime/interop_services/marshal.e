indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.Marshal"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MARSHAL

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen system_default_char_size: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SystemDefaultCharSize"
		end

	frozen system_max_dbcschar_size: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SystemMaxDBCSCharSize"
		end

feature -- Basic Operations

	frozen ptr_to_string_bstr (ptr: POINTER): SYSTEM_STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringBSTR"
		end

	frozen query_interface (p_unk: POINTER; iid: GUID; ppv: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr, System.Guid&, System.IntPtr&): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"QueryInterface"
		end

	frozen release_thread_cache is
		external
			"IL static signature (): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ReleaseThreadCache"
		end

	frozen write_byte_int_ptr_int32_byte (ptr: POINTER; ofs: INTEGER; val: INTEGER_8) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Byte): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteByte"
		end

	frozen get_method_info_for_com_slot (t: TYPE; slot: INTEGER; member_type: COM_MEMBER_TYPE): MEMBER_INFO is
		external
			"IL static signature (System.Type, System.Int32, System.Runtime.InteropServices.ComMemberType&): System.Reflection.MemberInfo use System.Runtime.InteropServices.Marshal"
		alias
			"GetMethodInfoForComSlot"
		end

	frozen read_byte_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen write_int_ptr (ptr: POINTER; val: POINTER) is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen size_of_object (structure: SYSTEM_OBJECT): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SizeOf"
		end

	frozen generate_guid_for_type (type: TYPE): GUID is
		external
			"IL static signature (System.Type): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GenerateGuidForType"
		end

	frozen num_param_bytes (m: METHOD_INFO): INTEGER is
		external
			"IL static signature (System.Reflection.MethodInfo): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"NumParamBytes"
		end

	frozen write_int64 (ptr: POINTER; val: INTEGER_64) is
		external
			"IL static signature (System.IntPtr, System.Int64): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt64"
		end

	frozen get_exception_pointers: POINTER is
		external
			"IL static signature (): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetExceptionPointers"
		end

	frozen read_int16_object (ptr: SYSTEM_OBJECT; ofs: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.Object, System.Int32): System.Int16 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt16"
		end

	frozen write_int64_int_ptr_int32_int64 (ptr: POINTER; ofs: INTEGER; val: INTEGER_64) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int64): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt64"
		end

	frozen copy__array_int32 (source: NATIVE_ARRAY [INTEGER]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int32[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen copy__array_double (source: NATIVE_ARRAY [DOUBLE]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Double[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen string_to_bstr (s: SYSTEM_STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToBSTR"
		end

	frozen ptr_to_string_auto (ptr: POINTER): SYSTEM_STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAuto"
		end

	frozen read_int_ptr_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReadIntPtr"
		end

	frozen copy_ (source: POINTER; destination: NATIVE_ARRAY [INTEGER_16]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int16[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen write_int32 (ptr: POINTER; val: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen get_idispatch_for_object (o: SYSTEM_OBJECT): POINTER is
		external
			"IL static signature (System.Object): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetIDispatchForObject"
		end

	frozen ptr_to_structure_int_ptr_object (ptr: POINTER; structure: SYSTEM_OBJECT) is
		external
			"IL static signature (System.IntPtr, System.Object): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStructure"
		end

	frozen get_object_for_iunknown (p_unk: POINTER): SYSTEM_OBJECT is
		external
			"IL static signature (System.IntPtr): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetObjectForIUnknown"
		end

	frozen release_com_object (o: SYSTEM_OBJECT): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReleaseComObject"
		end

	frozen get_active_object (prog_id: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.String): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetActiveObject"
		end

	frozen get_unmanaged_thunk_for_managed_method_ptr (pfn_method_to_wrap: POINTER; pb_signature: POINTER; cb_signature: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetUnmanagedThunkForManagedMethodPtr"
		end

	frozen write_int64_object (ptr: SYSTEM_OBJECT; ofs: INTEGER; val: INTEGER_64) is
		external
			"IL static signature (System.Object, System.Int32, System.Int64): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt64"
		end

	frozen write_byte_object (ptr: SYSTEM_OBJECT; ofs: INTEGER; val: INTEGER_8) is
		external
			"IL static signature (System.Object, System.Int32, System.Byte): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteByte"
		end

	frozen read_int32 (ptr: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt32"
		end

	frozen bind_to_moniker (moniker_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.String): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"BindToMoniker"
		end

	frozen get_objects_for_native_variants (a_src_native_variant: POINTER; c_vars: INTEGER): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Object[] use System.Runtime.InteropServices.Marshal"
		alias
			"GetObjectsForNativeVariants"
		end

	frozen change_wrapper_handle_strength (otp: SYSTEM_OBJECT; f_is_weak: BOOLEAN) is
		external
			"IL static signature (System.Object, System.Boolean): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ChangeWrapperHandleStrength"
		end

	frozen prelink_all (c: TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"PrelinkAll"
		end

	frozen read_int32_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt32"
		end

	frozen get_type_lib_lcid (p_tlb: UCOMITYPE_LIB): INTEGER is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeLib): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibLcid"
		end

	frozen read_int_ptr (ptr: POINTER): POINTER is
		external
			"IL static signature (System.IntPtr): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReadIntPtr"
		end

	frozen string_to_co_task_mem_uni (s: SYSTEM_STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToCoTaskMemUni"
		end

	frozen read_int64 (ptr: POINTER): INTEGER_64 is
		external
			"IL static signature (System.IntPtr): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen read_int32_object (ptr: SYSTEM_OBJECT; ofs: INTEGER): INTEGER is
		external
			"IL static signature (System.Object, System.Int32): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt32"
		end

	frozen add_ref (p_unk: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"AddRef"
		end

	frozen get_hrfor_exception (e: EXCEPTION): INTEGER is
		external
			"IL static signature (System.Exception): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetHRForException"
		end

	frozen copy__int_ptr_array_int64 (source: POINTER; destination: NATIVE_ARRAY [INTEGER_64]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int64[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen write_int16_int_ptr_int32_char (ptr: POINTER; ofs: INTEGER; val: CHARACTER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Char): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen copy__array_single (source: NATIVE_ARRAY [REAL]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Single[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen free_hglobal (hglobal: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeHGlobal"
		end

	frozen write_int_ptr_int_ptr_int32_int_ptr (ptr: POINTER; ofs: INTEGER; val: POINTER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen throw_exception_for_hr (error_code: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ThrowExceptionForHR"
		end

	frozen get_typed_object_for_iunknown (p_unk: POINTER; t: TYPE): SYSTEM_OBJECT is
		external
			"IL static signature (System.IntPtr, System.Type): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypedObjectForIUnknown"
		end

	frozen copy__int_ptr_array_single (source: POINTER; destination: NATIVE_ARRAY [REAL]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Single[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_managed_thunk_for_unmanaged_method_ptr (pfn_method_to_wrap: POINTER; pb_signature: POINTER; cb_signature: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetManagedThunkForUnmanagedMethodPtr"
		end

	frozen copy__int_ptr_array_byte (source: POINTER; destination: NATIVE_ARRAY [INTEGER_8]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Byte[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen write_int32_object (ptr: SYSTEM_OBJECT; ofs: INTEGER; val: INTEGER) is
		external
			"IL static signature (System.Object, System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen string_to_hglobal_uni (s: SYSTEM_STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToHGlobalUni"
		end

	frozen copy__array_int16 (source: NATIVE_ARRAY [INTEGER_16]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int16[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen set_com_object_data (obj: SYSTEM_OBJECT; key: SYSTEM_OBJECT; data: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object, System.Object, System.Object): System.Boolean use System.Runtime.InteropServices.Marshal"
		alias
			"SetComObjectData"
		end

	frozen unsafe_addr_of_pinned_array_element (arr: SYSTEM_ARRAY; index: INTEGER): POINTER is
		external
			"IL static signature (System.Array, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"UnsafeAddrOfPinnedArrayElement"
		end

	frozen create_wrapper_of_type (o: SYSTEM_OBJECT; t: TYPE): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object, System.Type): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"CreateWrapperOfType"
		end

	frozen throw_exception_for_hr_int32_int_ptr (error_code: INTEGER; error_info: POINTER) is
		external
			"IL static signature (System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ThrowExceptionForHR"
		end

	frozen is_com_object (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.InteropServices.Marshal"
		alias
			"IsComObject"
		end

	frozen copy__int_ptr_array_char (source: POINTER; destination: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Char[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen size_of (t: TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SizeOf"
		end

	frozen copy__int_ptr_array_int32 (source: POINTER; destination: NATIVE_ARRAY [INTEGER]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_type_info_name (p_ti: UCOMITYPE_INFO): SYSTEM_STRING is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeInfo): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeInfoName"
		end

	frozen write_int16_int_ptr_int32_int16 (ptr: POINTER; ofs: INTEGER; val: INTEGER_16) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int16): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen get_thread_from_fiber_cookie (cookie: INTEGER): THREAD is
		external
			"IL static signature (System.Int32): System.Threading.Thread use System.Runtime.InteropServices.Marshal"
		alias
			"GetThreadFromFiberCookie"
		end

	frozen read_int64_object (ptr: SYSTEM_OBJECT; ofs: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.Object, System.Int32): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen get_type_lib_guid_for_assembly (asm: ASSEMBLY): GUID is
		external
			"IL static signature (System.Reflection.Assembly): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibGuidForAssembly"
		end

	frozen get_type_lib_name (p_tlb: UCOMITYPE_LIB): SYSTEM_STRING is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeLib): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibName"
		end

	frozen string_to_hglobal_auto (s: SYSTEM_STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToHGlobalAuto"
		end

	frozen get_com_interface_for_object (o: SYSTEM_OBJECT; t: TYPE): POINTER is
		external
			"IL static signature (System.Object, System.Type): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetComInterfaceForObject"
		end

	frozen ptr_to_string_uni (ptr: POINTER): SYSTEM_STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringUni"
		end

	frozen get_type_lib_guid (p_tlb: UCOMITYPE_LIB): GUID is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeLib): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibGuid"
		end

	frozen get_hinstance (m: MODULE): POINTER is
		external
			"IL static signature (System.Reflection.Module): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetHINSTANCE"
		end

	frozen release (p_unk: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"Release"
		end

	frozen copy__int_ptr_array_double (source: POINTER; destination: NATIVE_ARRAY [DOUBLE]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Double[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_start_com_slot (t: TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetStartComSlot"
		end

	frozen ptr_to_string_ansi (ptr: POINTER): SYSTEM_STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAnsi"
		end

	frozen get_iunknown_for_object (o: SYSTEM_OBJECT): POINTER is
		external
			"IL static signature (System.Object): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetIUnknownForObject"
		end

	frozen re_alloc_hglobal (pv: POINTER; cb: POINTER): POINTER is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReAllocHGlobal"
		end

	frozen get_end_com_slot (t: TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetEndComSlot"
		end

	frozen copy__array_byte (source: NATIVE_ARRAY [INTEGER_8]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Byte[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen copy__array_int64 (source: NATIVE_ARRAY [INTEGER_64]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int64[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen ptr_to_string_uni_int_ptr_int32 (ptr: POINTER; len: INTEGER): SYSTEM_STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringUni"
		end

	frozen string_to_co_task_mem_ansi (s: SYSTEM_STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToCoTaskMemAnsi"
		end

	frozen alloc_co_task_mem (cb: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"AllocCoTaskMem"
		end

	frozen write_int16_object_int32_char (ptr: SYSTEM_OBJECT; ofs: INTEGER; val: CHARACTER) is
		external
			"IL static signature (System.Object, System.Int32, System.Char): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen get_itype_info_for_type (t: TYPE): POINTER is
		external
			"IL static signature (System.Type): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetITypeInfoForType"
		end

	frozen get_com_slot_for_method_info (m: MEMBER_INFO): INTEGER is
		external
			"IL static signature (System.Reflection.MemberInfo): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetComSlotForMethodInfo"
		end

	frozen write_int16 (ptr: POINTER; val: INTEGER_16) is
		external
			"IL static signature (System.IntPtr, System.Int16): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen destroy_structure (ptr: POINTER; structuretype: TYPE) is
		external
			"IL static signature (System.IntPtr, System.Type): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"DestroyStructure"
		end

	frozen free_co_task_mem (ptr: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeCoTaskMem"
		end

	frozen get_object_for_native_variant (p_src_native_variant: POINTER): SYSTEM_OBJECT is
		external
			"IL static signature (System.IntPtr): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetObjectForNativeVariant"
		end

	frozen read_int_ptr_object (ptr: SYSTEM_OBJECT; ofs: INTEGER): POINTER is
		external
			"IL static signature (System.Object, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReadIntPtr"
		end

	frozen write_int16_int_ptr_char (ptr: POINTER; val: CHARACTER) is
		external
			"IL static signature (System.IntPtr, System.Char): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen get_type_for_itype_info (pi_type_info: POINTER): TYPE is
		external
			"IL static signature (System.IntPtr): System.Type use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeForITypeInfo"
		end

	frozen free_bstr (ptr: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeBSTR"
		end

	frozen get_native_variant_for_object (obj: SYSTEM_OBJECT; p_dst_native_variant: POINTER) is
		external
			"IL static signature (System.Object, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"GetNativeVariantForObject"
		end

	frozen ptr_to_string_ansi_int_ptr_int32 (ptr: POINTER; len: INTEGER): SYSTEM_STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAnsi"
		end

	frozen ptr_to_string_auto_int_ptr_int32 (ptr: POINTER; len: INTEGER): SYSTEM_STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAuto"
		end

	frozen get_last_win32_error: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetLastWin32Error"
		end

	frozen copy__array_char (source: NATIVE_ARRAY [CHARACTER]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Char[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen offset_of (t: TYPE; field_name: SYSTEM_STRING): POINTER is
		external
			"IL static signature (System.Type, System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"OffsetOf"
		end

	frozen get_hrfor_last_win32_error: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetHRForLastWin32Error"
		end

	frozen alloc_hglobal_int_ptr (cb: POINTER): POINTER is
		external
			"IL static signature (System.IntPtr): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"AllocHGlobal"
		end

	frozen write_byte (ptr: POINTER; val: INTEGER_8) is
		external
			"IL static signature (System.IntPtr, System.Byte): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteByte"
		end

	frozen string_to_co_task_mem_auto (s: SYSTEM_STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToCoTaskMemAuto"
		end

	frozen ptr_to_structure (ptr: POINTER; structure_type: TYPE): SYSTEM_OBJECT is
		external
			"IL static signature (System.IntPtr, System.Type): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStructure"
		end

	frozen write_int_ptr_object (ptr: SYSTEM_OBJECT; ofs: INTEGER; val: POINTER) is
		external
			"IL static signature (System.Object, System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen structure_to_ptr (structure: SYSTEM_OBJECT; ptr: POINTER; f_delete_old: BOOLEAN) is
		external
			"IL static signature (System.Object, System.IntPtr, System.Boolean): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"StructureToPtr"
		end

	frozen write_int16_object_int32_int16 (ptr: SYSTEM_OBJECT; ofs: INTEGER; val: INTEGER_16) is
		external
			"IL static signature (System.Object, System.Int32, System.Int16): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen read_byte_object (ptr: SYSTEM_OBJECT; ofs: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.Object, System.Int32): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen read_int64_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen alloc_hglobal (cb: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"AllocHGlobal"
		end

	frozen read_int16_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Int16 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt16"
		end

	frozen generate_prog_id_for_type (type: TYPE): SYSTEM_STRING is
		external
			"IL static signature (System.Type): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"GenerateProgIdForType"
		end

	frozen get_exception_code: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetExceptionCode"
		end

	frozen is_type_visible_from_com (t: TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.Runtime.InteropServices.Marshal"
		alias
			"IsTypeVisibleFromCom"
		end

	frozen read_byte (ptr: POINTER): INTEGER_8 is
		external
			"IL static signature (System.IntPtr): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen prelink (m: METHOD_INFO) is
		external
			"IL static signature (System.Reflection.MethodInfo): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Prelink"
		end

	frozen get_com_object_data (obj: SYSTEM_OBJECT; key: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object, System.Object): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetComObjectData"
		end

	frozen read_int16 (ptr: POINTER): INTEGER_16 is
		external
			"IL static signature (System.IntPtr): System.Int16 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt16"
		end

	frozen write_int32_int_ptr_int32_int32 (ptr: POINTER; ofs: INTEGER; val: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen string_to_hglobal_ansi (s: SYSTEM_STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToHGlobalAnsi"
		end

	frozen re_alloc_co_task_mem (pv: POINTER; cb: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReAllocCoTaskMem"
		end

end -- class MARSHAL
