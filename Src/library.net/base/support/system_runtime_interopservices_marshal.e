indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	frozen system_max_dbcs_char_size: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SystemMaxDBCSCharSize"
		end

feature -- Basic Operations

	frozen get_thread_From_fiber_cookie (cookie: INTEGER): SYSTEM_THREADING_THREAD is
		external
			"IL static signature (System.Int32): System.Threading.Thread use System.Runtime.InteropServices.Marshal"
		alias
			"GetThreadFromFiberCookie"
		end

	frozen free_co_task_mem (ptr: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeCoTaskMem"
		end

	frozen throw_exception_for_hr (errorCode: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ThrowExceptionForHR"
		end

	frozen read_int32_object (ptr: ANY; ofs: INTEGER): INTEGER is
		external
			"IL static signature (System.Object, System.Int32): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt32"
		end

	frozen get_native_variant_for_object (obj: ANY; pDstNativeVariant: POINTER) is
		external
			"IL static signature (System.Object, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"GetNativeVariantForObject"
		end

	frozen write_byte (ptr: POINTER; val: INTEGER_8) is
		external
			"IL static signature (System.IntPtr, System.Byte): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteByte"
		end

	frozen ptr_to_string_auto (ptr: POINTER): STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAuto"
		end

	frozen free_h_global (hglobal: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeHGlobal"
		end

	frozen size_of (t: SYSTEM_TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SizeOf"
		end

	frozen ptr_to_string_auto_int_ptr_int32 (ptr: POINTER; len: INTEGER): STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAuto"
		end

	frozen write_int16_int_ptr_char (ptr: POINTER; val: CHARACTER) is
		external
			"IL static signature (System.IntPtr, System.Char): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen string_to_h_global_auto (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToHGlobalAuto"
		end

	frozen throw_exception_for_hr_int32_int_ptr (errorCode: INTEGER; errorInfo: POINTER) is
		external
			"IL static signature (System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ThrowExceptionForHR"
		end

	frozen get_hr_for_last_win32_Error: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetHRForLastWin32Error"
		end

	frozen get_i_dispatch_for_object (o: ANY): POINTER is
		external
			"IL static signature (System.Object): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetIDispatchForObject"
		end

	frozen read_int_ptr_object (ptr: ANY; ofs: INTEGER): POINTER is
		external
			"IL static signature (System.Object, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReadIntPtr"
		end

	frozen destroy_structure (ptr: POINTER; structuretype: SYSTEM_TYPE) is
		external
			"IL static signature (System.IntPtr, System.Type): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"DestroyStructure"
		end

	frozen copy_array_char (source: ARRAY [CHARACTER]; startIndex: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Char[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen string_to_co_task_mem_ansi (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToCoTaskMemAnsi"
		end

	frozen write_int16_int_ptr_int32_int16 (ptr: POINTER; ofs: INTEGER; val: INTEGER_16) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int16): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen ptr_to_structure_int_ptr_object (ptr: POINTER; structure: ANY) is
		external
			"IL static signature (System.IntPtr, System.Object): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStructure"
		end

	frozen structure_to_ptr (structure: ANY; ptr: POINTER; fDeleteOld: BOOLEAN) is
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

	frozen copy_array_int16 (source: ARRAY [INTEGER_16]; startIndex: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int16[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen re_alloc_h_global (pv: POINTER; cb: POINTER): POINTER is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReAllocHGlobal"
		end

	frozen write_int_ptr (ptr: POINTER; val: POINTER) is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen copy_int_ptr_array_int64 (source: POINTER; destination: ARRAY [INTEGER_64]; startIndex: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int64[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_unmanaged_thunk_for_managed_method_ptr (pfnMethodToWrap: POINTER; pbSignature: POINTER; cbSignature: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetUnmanagedThunkForManagedMethodPtr"
		end

	frozen copy_int_ptr_array_Single (source: POINTER; destination: ARRAY [REAL]; startIndex: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Single[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen copy_int_ptr_array_Double (source: POINTER; destination: ARRAY [DOUBLE]; startIndex: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Double[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_start_com_slot (t: SYSTEM_TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetStartComSlot"
		end

	frozen get_type_info_name (pTI: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO): STRING is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeInfo): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeInfoName"
		end

	frozen read_int16_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Int16 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt16"
		end

	frozen get_method_info_for_com_slot (t: SYSTEM_TYPE; slot: INTEGER; member_type: INTEGER): SYSTEM_REFLECTION_MEMBERINFO is
			-- Valid values for `member_type' are:
			-- Method = 0
			-- PropGet = 1
			-- PropSet = 2
		require
			valid_com_member_type: member_type = 0 or member_type = 1 or member_type = 2
		external
			"IL static signature (System.Type, System.Int32, System.Runtime.InteropServices.ComMemberType&): System.Reflection.MemberInfo use System.Runtime.InteropServices.Marshal"
		alias
			"GetMethodInfoForComSlot"
		end

	frozen get_hr_for_exception (e: SYSTEM_EXCEPTION): INTEGER is
		external
			"IL static signature (System.Exception): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetHRForException"
		end

	frozen read_byte_object (ptr: ANY; ofs: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.Object, System.Int32): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen ptr_to_string_ansi (ptr: POINTER): STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAnsi"
		end

	frozen read_int64_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen write_byte_int_ptr_int32_byte (ptr: POINTER; ofs: INTEGER; val: INTEGER_8) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Byte): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteByte"
		end

	frozen write_int16_int_ptr_int32_char (ptr: POINTER; ofs: INTEGER; val: CHARACTER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Char): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen copy_array_byte (source: ARRAY [INTEGER_8]; startIndex: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Byte[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen read_byte (ptr: POINTER): INTEGER_8 is
		external
			"IL static signature (System.IntPtr): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen copy_array_int64 (source: ARRAY [INTEGER_64]; startIndex: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int64[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen offset_of (t: SYSTEM_TYPE; fieldName: STRING): POINTER is
		external
			"IL static signature (System.Type, System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"OffsetOf"
		end

	frozen alloc_co_task_mem (cb: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"AllocCoTaskMem"
		end

	frozen write_int32_object (ptr: ANY; ofs: INTEGER; val: INTEGER) is
		external
			"IL static signature (System.Object, System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen prelink (m: SYSTEM_REFLECTION_METHODINFO) is
		external
			"IL static signature (System.Reflection.MethodInfo): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Prelink"
		end

	frozen write_int64_int_ptr_int32_int64 (ptr: POINTER; ofs: INTEGER; val: INTEGER_64) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int64): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt64"
		end

	frozen get_exception_code: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetExceptionCode"
		end

	frozen ptr_to_string_uni (ptr: POINTER): STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringUni"
		end

	frozen query_interface (pUnk: POINTER; iid: SYSTEM_GUID; ppv: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr, System.Guid&, System.IntPtr&): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"QueryInterface"
		end

	frozen write_int16 (ptr: POINTER; val: INTEGER_16) is
		external
			"IL static signature (System.IntPtr, System.Int16): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen release_thread_cache is
		external
			"IL static signature (): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"ReleaseThreadCache"
		end

	frozen generate_guid_for_type (type: SYSTEM_TYPE): SYSTEM_GUID is
		external
			"IL static signature (System.Type): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GenerateGuidForType"
		end

	frozen copy_array_int32 (source: ARRAY [INTEGER]; startIndex: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Int32[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen write_int16_object_int32_char (ptr: ANY; ofs: INTEGER; val: CHARACTER) is
		external
			"IL static signature (System.Object, System.Int32, System.Char): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt16"
		end

	frozen read_int16 (ptr: POINTER): INTEGER_16 is
		external
			"IL static signature (System.IntPtr): System.Int16 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt16"
		end

	frozen get_end_com_slot (t: SYSTEM_TYPE): INTEGER is
		external
			"IL static signature (System.Type): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetEndComSlot"
		end

	frozen alloc_h_global (cb: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"AllocHGlobal"
		end

	frozen get_com_interface_for_object (o: ANY; T: SYSTEM_TYPE): POINTER is
		external
			"IL static signature (System.Object, System.Type): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetComInterfaceForObject"
		end

	frozen string_to_bstr (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToBSTR"
		end

	frozen release (pUnk: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"Release"
		end

	frozen read_int32 (ptr: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt32"
		end

	frozen get_exception_pointers: POINTER is
		external
			"IL static signature (): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetExceptionPointers"
		end

	frozen prelink_all (c: SYSTEM_TYPE) is
		external
			"IL static signature (System.Type): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"PrelinkAll"
		end

	frozen re_alloc_co_task_mem (pv: POINTER; cb: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReAllocCoTaskMem"
		end

	frozen read_int32_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt32"
		end

	frozen copy_array_Double (source: ARRAY [DOUBLE]; startIndex: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Double[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_last_win32_error: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetLastWin32Error"
		end

	frozen create_wrapper_of_type (o: ANY; t: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.Object, System.Type): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"CreateWrapperOfType"
		end

	frozen get_i_unknown_for_object (o: ANY): POINTER is
		external
			"IL static signature (System.Object): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetIUnknownForObject"
		end

	frozen write_int_ptr_int_ptr_int32_int_ptr (ptr: POINTER; ofs: INTEGER; val: POINTER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen read_int64_object (ptr: ANY; ofs: INTEGER): INTEGER_64 is
		external
			"IL static signature (System.Object, System.Int32): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen copy_array_single (source: ARRAY [REAL]; startIndex: INTEGER; destination: POINTER; length: INTEGER) is
		external
			"IL static signature (System.Single[], System.Int32, System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen read_int64 (ptr: POINTER): INTEGER_64 is
		external
			"IL static signature (System.IntPtr): System.Int64 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt64"
		end

	frozen write_int32_intptr_int32_int32 (ptr: POINTER; ofs: INTEGER; val: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen bind_to_moniker (monikerName: STRING): ANY is
		external
			"IL static signature (System.String): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"BindToMoniker"
		end

	frozen is_com_object (o: ANY): BOOLEAN is
		external
			"IL static signature (System.Object): System.Boolean use System.Runtime.InteropServices.Marshal"
		alias
			"IsComObject"
		end

	frozen get_typed_object_for_i_unknown (pUnk: POINTER; t: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.IntPtr, System.Type): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypedObjectForIUnknown"
		end

	frozen read_intptr_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReadIntPtr"
		end

	frozen get_object_for_native_variant (pSrcNativeVariant: POINTER): ANY is
		external
			"IL static signature (System.IntPtr): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetObjectForNativeVariant"
		end

	frozen ptr_to_string_uni_int_ptr_int32 (ptr: POINTER; len: INTEGER): STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringUni"
		end

	frozen write_int64_object (ptr: ANY; ofs: INTEGER; val: INTEGER_64) is
		external
			"IL static signature (System.Object, System.Int32, System.Int64): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt64"
		end

	frozen size_of_object (structure: ANY): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"SizeOf"
		end

	frozen read_int_ptr (ptr: POINTER): POINTER is
		external
			"IL static signature (System.IntPtr): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"ReadIntPtr"
		end

	frozen write_int32 (ptr: POINTER; val: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt32"
		end

	frozen ptr_to_string_bstr (ptr: POINTER): STRING is
		external
			"IL static signature (System.IntPtr): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringBSTR"
		end

	frozen get_active_object (progID: STRING): ANY is
		external
			"IL static signature (System.String): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetActiveObject"
		end

	frozen unsafe_addr_of_pinned_array_element (arr: SYSTEM_ARRAY; index: INTEGER): POINTER is
		external
			"IL static signature (System.Array, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"UnsafeAddrOfPinnedArrayElement"
		end

	frozen write_byte_object (ptr: ANY; ofs: INTEGER; val: INTEGER_8) is
		external
			"IL static signature (System.Object, System.Int32, System.Byte): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteByte"
		end

	frozen get_com_slot_for_method_info (m: SYSTEM_REFLECTION_MEMBERINFO): INTEGER is
		external
			"IL static signature (System.Reflection.MemberInfo): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"GetComSlotForMethodInfo"
		end

	frozen write_int64 (ptr: POINTER; val: INTEGER_64) is
		external
			"IL static signature (System.IntPtr, System.Int64): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteInt64"
		end

	frozen ptr_to_string_ansi_int_ptr_int32 (ptr: POINTER; len: INTEGER): STRING is
		external
			"IL static signature (System.IntPtr, System.Int32): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStringAnsi"
		end

	frozen get_h_instance (m: SYSTEM_REFLECTION_MODULE): POINTER is
		external
			"IL static signature (System.Reflection.Module): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetHINSTANCE"
		end

	frozen get_type_for_i_type_info (piTypeInfo: POINTER): SYSTEM_TYPE is
		external
			"IL static signature (System.IntPtr): System.Type use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeForITypeInfo"
		end

	frozen copy (source: POINTER; destination: ARRAY [INTEGER_16]; startIndex: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int16[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_object_for_i_unknown (pUnk: POINTER): ANY is
		external
			"IL static signature (System.IntPtr): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"GetObjectForIUnknown"
		end

	frozen num_param_bytes (m: SYSTEM_REFLECTION_METHODINFO): INTEGER is
		external
			"IL static signature (System.Reflection.MethodInfo): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"NumParamBytes"
		end

	frozen read_int16_object (ptr: ANY; ofs: INTEGER): INTEGER_16 is
		external
			"IL static signature (System.Object, System.Int32): System.Int16 use System.Runtime.InteropServices.Marshal"
		alias
			"ReadInt16"
		end

	frozen release_com_object (o: ANY): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"ReleaseComObject"
		end

	frozen generate_prog_id_for_type (type: SYSTEM_TYPE): STRING is
		external
			"IL static signature (System.Type): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"GenerateProgIdForType"
		end

	frozen read_byte_int_ptr_int32 (ptr: POINTER; ofs: INTEGER): INTEGER_8 is
		external
			"IL static signature (System.IntPtr, System.Int32): System.Byte use System.Runtime.InteropServices.Marshal"
		alias
			"ReadByte"
		end

	frozen get_type_lib_guid (pTLB: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB): SYSTEM_GUID is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeLib): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibGuid"
		end

	frozen alloc_h_global_int_ptr (cb: POINTER): POINTER is
		external
			"IL static signature (System.IntPtr): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"AllocHGlobal"
		end

	frozen string_to_h_global_ansi (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToHGlobalAnsi"
		end

	frozen get_managed_thunk_for_unmanaged_method_ptr (pfnMethodToWrap: POINTER; pbSignature: POINTER; cbSignature: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.IntPtr, System.Int32): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetManagedThunkForUnmanagedMethodPtr"
		end

	frozen copy_int_ptr_array_int32 (source: POINTER; destination: ARRAY [INTEGER]; startIndex: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_type_lib_guid_for_assembly (asm: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_GUID is
		external
			"IL static signature (System.Reflection.Assembly): System.Guid use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibGuidForAssembly"
		end

	frozen copy_int_ptr_array_byte (source: POINTER; destination: ARRAY [INTEGER_8]; startIndex: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Byte[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen string_to_co_task_mem_auto (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToCoTaskMemAuto"
		end

	frozen get_i_type_info_for_type (t: SYSTEM_TYPE): POINTER is
		external
			"IL static signature (System.Type): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"GetITypeInfoForType"
		end

	frozen string_to_co_task_mem_uni (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToCoTaskMemUni"
		end

	frozen write_int_ptr_object (ptr: ANY; ofs: INTEGER; val: POINTER) is
		external
			"IL static signature (System.Object, System.Int32, System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"WriteIntPtr"
		end

	frozen Free_bstr (ptr: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"FreeBSTR"
		end

	frozen copy_int_ptr_array_char (source: POINTER; destination: ARRAY [CHARACTER]; startIndex: INTEGER; length: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Char[], System.Int32, System.Int32): System.Void use System.Runtime.InteropServices.Marshal"
		alias
			"Copy"
		end

	frozen get_type_lib_name (pTLB: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB): STRING is
		external
			"IL static signature (System.Runtime.InteropServices.UCOMITypeLib): System.String use System.Runtime.InteropServices.Marshal"
		alias
			"GetTypeLibName"
		end

	frozen Is_type_visible_from_com (t: SYSTEM_TYPE): BOOLEAN is
		external
			"IL static signature (System.Type): System.Boolean use System.Runtime.InteropServices.Marshal"
		alias
			"IsTypeVisibleFromCom"
		end

	frozen add_ref (pUnk: POINTER): INTEGER is
		external
			"IL static signature (System.IntPtr): System.Int32 use System.Runtime.InteropServices.Marshal"
		alias
			"AddRef"
		end

	frozen string_to_h_global_uni (s: STRING): POINTER is
		external
			"IL static signature (System.String): System.IntPtr use System.Runtime.InteropServices.Marshal"
		alias
			"StringToHGlobalUni"
		end

	frozen ptr_to_structure (ptr: POINTER; structureType: SYSTEM_TYPE): ANY is
		external
			"IL static signature (System.IntPtr, System.Type): System.Object use System.Runtime.InteropServices.Marshal"
		alias
			"PtrToStructure"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_MARSHAL
