indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.Marshal"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_MARSHAL

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

	frozen copy_array_int64 (source: ARRAY [INTEGER_64]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int64[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen ptr_to_string_bstr (ptr: POINTER): STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringBSTR"
		end

	frozen query_interface (p_unk: POINTER; iid: SYSTEM_GUID; ppv: POINTER): INTEGER is
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

	frozen copy (source: POINTER; destination: ARRAY [INTEGER_16]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int16[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen write_int_ptr (ptr: POINTER; val: POINTER) is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen size_of_object (structure: ANY): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SizeOf"
		end

	frozen copy_array_int16 (source: ARRAY [INTEGER_16]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int16[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen read_int16 (ptr: POINTER): INTEGER_16 is
		external
			"IL static signature (System.IntPtr): System.Int16 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt16"
		end

	frozen string_to_hglobal_uni (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToHGlobalUni"
		end

	frozen num_param_bytes (m: SYSTEM_REFLECTION_METHODINFO): INTEGER is
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

	frozen write_int64_int_ptr_int32_int64 (ptr: POINTER; ofs: INTEGER; val: INTEGER_64) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int64): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt64"
		end

	frozen get_method_info_for_com_slot (t: SYSTEM_TYPE; slot: INTEGER; member_type: SYSTEM_RUNTIME_INTEROPSERVICES_COMMEMBERTYPE): SYSTEM_REFLECTION_MEMBERINFO is
		external
			"IL static signature (System.Type, System.Int32, System.Runtime.InteropServices.ComMemberType&): System.Reflection.MemberInfo use System.Runtime.InteropServices.Marshal"
		alias
			"GetMethodInfoForComSlot"
		end

	frozen get_type_lib_guid (p_tlb: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB): SYSTEM_GUID is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeLib): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibGuid"
		end

	frozen write_int_ptr_int_ptr_int32_int_ptr (ptr: POINTER; ofs: INTEGER; val: POINTER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen copy_int_ptr_array_single (source: POINTER; destination: ARRAY [REAL]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Single[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen string_to_bstr (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToBSTR"
		end

	frozen ptr_to_string_auto (ptr: POINTER): STRING is
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

	frozen write_int32 (ptr: POINTER; val: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen get_idispatch_for_object (o: ANY): POINTER is
		external
			"IL static signature (System.Object): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetIDispatchForObject"
		end

	frozen read_int64_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen get_object_for_iunknown (p_unk: POINTER): ANY is
		external
			"IL static signature (System.IntPtr): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetObjectForIUnknown"
		end

	frozen release_com_object (o: ANY): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReleaseComObject"
		end

	frozen get_active_object (prog_id: STRING): ANY is
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

	frozen write_int64_object (ptr: ANY; ofs: INTEGER; val: INTEGER_64) is
		external
			"IL static signature (System.Object, System.Int32, System.Int64): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt64"
		end

	frozen copy_array_single (source: ARRAY [REAL]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Single[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen read_int32 (ptr: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt32"
		end

	frozen bind_to_moniker (moniker_name: STRING): ANY is
		external
			"IL static signature (System.String): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"BindToMoniker"
		end

	frozen copy_int_ptr_array_char (source: POINTER; destination: ARRAY [CHARACTER]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Char[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen change_wrapper_handle_strength (otp: ANY; f_is_weak: BOOLEAN) is
		external
			"IL static signature (System.Object, System.Boolean): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ChangeWrapperHandleStrength"
		end

	frozen prelink_all (c: SYSTEM_TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"PrelinkAll"
		end

	frozen get_type_lib_lcid (p_tlb: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB): INTEGER is
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

	frozen string_to_co_task_mem_uni (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToCoTaskMemUni"
		end

	frozen copy_int_ptr_array_byte (source: POINTER; destination: ARRAY [INTEGER_8]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Byte[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen read_int64 (ptr: POINTER): INTEGER_64 is
		external
			"IL static signature (System.IntPtr): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen read_int32_object (ptr: ANY; ofs: INTEGER): INTEGER is
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

	frozen get_hrfor_exception (e: SYSTEM_EXCEPTION): INTEGER is
		external
			"IL static signature (System.Exception): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetHRForException"
		end

	frozen write_int16_int_ptr_int32_char (ptr: POINTER; ofs: INTEGER; val: CHARACTER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Char): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen ptr_to_structure_int_ptr_object (ptr: POINTER; structure: ANY) is
		external
			"IL static signature (System.IntPtr, System.Object): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStructure"
		end

	frozen free_hglobal (hglobal: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeHGlobal"
		end

	frozen copy_array_int32 (source: ARRAY [INTEGER]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int32[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen throw_exception_for_hr (error_code: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ThrowExceptionForHR"
		end

	frozen get_typed_object_for_iunknown (p_unk: POINTER; t: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.IntPtr, System.Type): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypedObjectForIUnknown"
		end

	frozen get_itype_info_for_type (t: SYSTEM_TYPE): POINTER is
		external
			"IL static signature (System.Type): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetITypeInfoForType"
		end

	frozen get_managed_thunk_for_unmanaged_method_ptr (pfn_method_to_wrap: POINTER; pb_signature: POINTER; cb_signature: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetManagedThunkForUnmanagedMethodPtr"
		end

	frozen get_type_for_itype_info (pi_type_info: POINTER): SYSTEM_TYPE is
		external
			"IL static signature (System.IntPtr): System.Type use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeForITypeInfo"
		end

	frozen write_int32_object (ptr: ANY; ofs: INTEGER; val: INTEGER) is
		external
			"IL static signature (System.Object, System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen copy_array_byte (source: ARRAY [INTEGER_8]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Byte[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen write_int16_object_int32_char (ptr: ANY; ofs: INTEGER; val: CHARACTER) is
		external
			"IL static signature (System.Object, System.Int32, System.Char): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen set_com_object_data (obj: ANY; key: ANY; data: ANY): BOOLEAN is
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

	frozen create_wrapper_of_type (o: ANY; t: SYSTEM_TYPE): ANY is
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

	frozen is_com_object (o: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.InteropServices.Marshal"
		alias
			"IsComObject"
		end

	frozen write_int16 (ptr: POINTER; val: INTEGER_16) is
		external
			"IL static signature (System.IntPtr, System.Int16): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen size_of (t: SYSTEM_TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SizeOf"
		end

	frozen get_type_info_name (p_ti: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO): STRING is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeInfo): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeInfoName"
		end

	frozen get_thread_from_fiber_cookie (cookie: INTEGER): SYSTEM_THREADING_THREAD is
		external
			"IL static signature (System.Int32): System.Threading.Thread use System.Runtime.InteropServices.Marshal"
		alias
			"GetThreadFromFiberCookie"
		end

	frozen read_int64_object (ptr: ANY; ofs: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.Object, System.Int32): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen copy_array_double (source: ARRAY [DOUBLE]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Double[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_type_lib_name (p_tlb: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB): STRING is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeLib): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibName"
		end

	frozen string_to_hglobal_auto (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToHGlobalAuto"
		end

	frozen get_com_interface_for_object (o: ANY; t: SYSTEM_TYPE): POINTER is
		external
			"IL static signature (System.Object, System.Type): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetComInterfaceForObject"
		end

	frozen ptr_to_string_uni (ptr: POINTER): STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringUni"
		end

	frozen get_hinstance (m: SYSTEM_REFLECTION_MODULE): POINTER is
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

	frozen get_end_com_slot (t: SYSTEM_TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetEndComSlot"
		end

	frozen get_start_com_slot (t: SYSTEM_TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetStartComSlot"
		end

	frozen ptr_to_string_ansi (ptr: POINTER): STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAnsi"
		end

	frozen re_alloc_hglobal (pv: POINTER; cb: POINTER): POINTER is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReAllocHGlobal"
		end

	frozen copy_int_ptr_array_double (source: POINTER; destination: ARRAY [DOUBLE]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Double[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen ptr_to_string_uni_int_ptr_int32 (ptr: POINTER; len: INTEGER): STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringUni"
		end

	frozen string_to_co_task_mem_ansi (s: STRING): POINTER is
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

	frozen get_iunknown_for_object (o: ANY): POINTER is
		external
			"IL static signature (System.Object): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetIUnknownForObject"
		end

	frozen copy_array_char (source: ARRAY [CHARACTER]; start_index: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Char[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_com_slot_for_method_info (m: SYSTEM_REFLECTION_MEMBERINFO): INTEGER is
		external
			"IL static signature (System.Reflection.MemberInfo): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetComSlotForMethodInfo"
		end

	frozen generate_guid_for_type (type: SYSTEM_TYPE): SYSTEM_GUID is
		external
			"IL static signature (System.Type): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GenerateGuidForType"
		end

	frozen copy_int_ptr_array_int64 (source: POINTER; destination: ARRAY [INTEGER_64]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int64[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen read_byte_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen free_co_task_mem (ptr: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeCoTaskMem"
		end

	frozen get_object_for_native_variant (p_src_native_variant: POINTER): ANY is
		external
			"IL static signature (System.IntPtr): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetObjectForNativeVariant"
		end

	frozen read_int_ptr_object (ptr: ANY; ofs: INTEGER): POINTER is
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

	frozen free_bstr (ptr: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeBSTR"
		end

	frozen get_native_variant_for_object (obj: ANY; p_dst_native_variant: POINTER) is
		external
			"IL static signature (System.Object, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"GetNativeVariantForObject"
		end

	frozen ptr_to_string_ansi_int_ptr_int32 (ptr: POINTER; len: INTEGER): STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAnsi"
		end

	frozen write_int16_int_ptr_int32_int16 (ptr: POINTER; ofs: INTEGER; val: INTEGER_16) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int16): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen get_last_win32_error: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetLastWin32Error"
		end

	frozen destroy_structure (ptr: POINTER; structuretype: SYSTEM_TYPE) is
		external
			"IL static signature (System.IntPtr, System.Type): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"DestroyStructure"
		end

	frozen offset_of (t: SYSTEM_TYPE; field_name: STRING): POINTER is
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

	frozen string_to_co_task_mem_auto (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToCoTaskMemAuto"
		end

	frozen ptr_to_structure (ptr: POINTER; structure_type: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.IntPtr, System.Type): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStructure"
		end

	frozen write_int_ptr_object (ptr: ANY; ofs: INTEGER; val: POINTER) is
		external
			"IL static signature (System.Object, System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen structure_to_ptr (structure: ANY; ptr: POINTER; f_delete_old: BOOLEAN) is
		external
			"IL static signature (System.Object, System.IntPtr, System.Boolean): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"StructureToPtr"
		end

	frozen write_int16_object_int32_int16 (ptr: ANY; ofs: INTEGER; val: INTEGER_16) is
		external
			"IL static signature (System.Object, System.Int32, System.Int16): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen read_byte_object (ptr: ANY; ofs: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.Object, System.Int32): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen read_int16_object (ptr: ANY; ofs: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.Object, System.Int32): System.Int16 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt16"
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

	frozen generate_prog_id_for_type (type: SYSTEM_TYPE): STRING is
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

	frozen ptr_to_string_auto_int_ptr_int32 (ptr: POINTER; len: INTEGER): STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAuto"
		end

	frozen is_type_visible_from_com (t: SYSTEM_TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.Runtime.InteropServices.Marshal"
		alias
			"IsTypeVisibleFromCom"
		end

	frozen write_byte_object (ptr: ANY; ofs: INTEGER; val: INTEGER_8) is
		external
			"IL static signature (System.Object, System.Int32, System.Byte): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteByte"
		end

	frozen read_byte (ptr: POINTER): INTEGER_8 is
		external
			"IL static signature (System.IntPtr): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen prelink (m: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL static signature (System.Reflection.MethodInfo): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Prelink"
		end

	frozen get_com_object_data (obj: ANY; key: ANY): ANY is
		external
			"IL static signature (System.Object, System.Object): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetComObjectData"
		end

	frozen read_int32_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt32"
		end

	frozen get_type_lib_guid_for_assembly (asm: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_GUID is
		external
			"IL static signature (System.Reflection.Assembly): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibGuidForAssembly"
		end

	frozen write_int32_int_ptr_int32_int32 (ptr: POINTER; ofs: INTEGER; val: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen string_to_hglobal_ansi (s: STRING): POINTER is
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

	frozen copy_int_ptr_array_int32 (source: POINTER; destination: ARRAY [INTEGER]; start_index: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_MARSHAL
