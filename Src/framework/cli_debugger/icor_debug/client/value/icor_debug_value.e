note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_VALUE

inherit
	ICOR_DEBUG_I

feature {NONE} -- Initialization

	make_value_by_pointer (an_item: POINTER)
			-- Make Current by pointer.
		do
			make_by_pointer (an_item)
			get_strong_reference_value
		end

feature {ICOR_EXPORTER} -- Pseudo twin

	duplicated_object: like Current
		do
			Result := twin
			Result.add_ref
			if Result.strong_reference_value /= Void then
				Result.update_strong_reference_value (strong_reference_value.duplicated_object)
			end
		end

feature {ICOR_EXPORTER} -- Access

	type: INTEGER
			-- Type of Current value
		do
			--| FIXME jfiat [2008/11/12] : maybe try to cache the value ...
			Result := get_type
		end

	strong_reference_value: detachable ICOR_DEBUG_HANDLE_VALUE
			-- Strong reference value

feature {ICOR_EXPORTER} -- Query

	get_strong_reference_value
		local
			l_icd: detachable ICOR_DEBUG_VALUE
		do
				--| in specific case, the value can be under reference
			if attached query_interface_icor_debug_reference_value as l_ref then
				l_icd := l_ref.dereference
				l_ref.clean_on_dispose
			end
				--| If previous operation didn't lead to valid data
				--| let's use Current
			if l_icd = Void then
				l_icd := Current
			end
			if attached l_icd.query_interface_icor_debug_heap_value2 as l_icd_heap2 then
				strong_reference_value := l_icd_heap2.create_strong_handle
				l_icd_heap2.clean_on_dispose
			else
				strong_reference_value := query_interface_icor_debug_handle_value
			end
		end

	update_strong_reference_value (v: like strong_reference_value)
		do
			strong_reference_value := v
		end

feature {ICOR_EXPORTER} -- References Properties

	is_null_reference: BOOLEAN
			-- If Current is a reference value, return True if Current is null

	set_is_null_reference (v: like is_null_reference)
			-- Set value `v' to `is_null_reference' attribute
		do
			is_null_reference := v
		end

feature {ICOR_EXPORTER} -- helpers

	error_code_is_object_neutered (lcs: INTEGER): BOOLEAN
			-- `lcs' is `cordbg_e_object_neutered' error value
		do
			Result := Api_error_code_formatter.error_code_is_CORDBG_E_OBJECT_NEUTERED (lcs)
		end

--NOTA JFIAT: not used for now, let's keep it for later maybe
--feature {ICOR_EXPORTER} -- helpers
--
--	is_valid_object: BOOLEAN is
--			-- Is current a valid object, ie not collected ?
--		local
--			ref_value: like query_interface_icor_debug_reference_value
--			deref_value: ICOR_DEBUG_VALUE
--			heap_value: like query_interface_icor_debug_heap_value
--		do
--			ref_value := query_interface_icor_debug_reference_value
--			if ref_value /= Void then
--				deref_value := ref_value.dereference
--				if deref_value /= Void then
--					heap_value := deref_value.query_interface_icor_debug_heap_value
--					if heap_value /= Void then
--						Result := heap_value.is_valid
--						heap_value.clean_on_dispose
--					end
--					deref_value.clean_on_dispose
--				else
--					Result := False
--				end
--				ref_value.clean_on_dispose
--			end
--		end

feature -- Cleaning / Dispose

	clean_on_dispose
			-- Call this, to clean the object as if it is about to be disposed
		do
			if attached strong_reference_value as v then
				v.clean_on_dispose
				strong_reference_value := Void
			end
--			Precursor
		end

feature {ICOR_EXPORTER} -- QueryInterface

	query_interface_icor_debug_generic_value: detachable ICOR_DEBUG_GENERIC_VALUE
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugGenericValue (item, $p))
			if p /= default_pointer then
				Result := new_generic_value (p)
			end
		end

	query_interface_icor_debug_reference_value: detachable ICOR_DEBUG_REFERENCE_VALUE
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugReferenceValue (item, $p))
			if p /= default_pointer then
				Result := new_reference_value (p)
			end
		end

	query_interface_icor_debug_handle_value: detachable ICOR_DEBUG_HANDLE_VALUE
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugHandleValue (item, $p))
			if p /= default_pointer then
				Result := new_handle_value (p)
			end
		end

	query_interface_icor_debug_heap_value: detachable ICOR_DEBUG_HEAP_VALUE
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugHeapValue (item, $p))
			if p /= default_pointer then
				Result := new_heap_value (p)
			end
		end

	query_interface_icor_debug_heap_value2: detachable ICOR_DEBUG_HEAP_VALUE2
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugHeapValue2 (item, $p))
			if p /= default_pointer then
				Result := new_heap_value2 (p)
			end
		end

	query_interface_icor_debug_object_value: detachable ICOR_DEBUG_OBJECT_VALUE
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugObjectValue (item, $p))
			if p /= default_pointer then
				Result := new_object_value (p)
			end
		end

feature {ICOR_EXPORTER} -- QueryInterface HEAP

	query_interface_icor_debug_box_value: detachable ICOR_DEBUG_BOX_VALUE
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugBoxValue (item, $p))
			if p /= default_pointer then
				Result := new_box_value (p)
			end
		end

	query_interface_icor_debug_string_value: detachable ICOR_DEBUG_STRING_VALUE
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugStringValue (item, $p))
			if p /= default_pointer then
				Result := new_string_value (p)
			end
		end

	query_interface_icor_debug_array_value: detachable ICOR_DEBUG_ARRAY_VALUE
		require
			item_not_null: item_not_null
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugArrayValue (item, $p))
			if p /= default_pointer then
				Result := new_array_value (p)
			end
		end

feature {ICOR_EXPORTER} -- Access

	get_size: NATURAL_32
			-- GetSize returns the size in bytes
		require
			item_not_null: item_not_null
		do
			set_last_call_success (cpp_get_size (item, $Result))
		ensure
			success: last_call_success = 0 or error_code_is_object_neutered (last_call_success)
		end

	get_address: NATURAL_64
			-- GetAddress returns the address of the value in the debugee
			-- process.  This might be useful information for the debugger to
			-- show.
	 		-- * If the value is at least partly in registers, 0 is returned.
		require
			item_not_null: item_not_null
		do
			set_last_call_success (cpp_get_address (item, $Result))
		ensure
			success: last_call_success = 0 or error_code_is_object_neutered (last_call_success)
		end

feature {NONE} -- External Implementation

	cpp_get_type (obj: POINTER; a_p_type: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugValue signature(CorElementType*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetType"
		end

	cpp_get_size (obj: POINTER; a_p_size: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugValue signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetSize"
		end

	cpp_get_address (obj: POINTER; a_p_size: TYPED_POINTER [NATURAL_64]): INTEGER
		external
			"[
				C++ ICorDebugValue signature(CORDB_ADDRESS*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetAddress"
		end

feature {NONE } -- Access

	get_type: like type
			-- GetType
		require
			item_not_null: item_not_null
		do
			set_last_call_success (cpp_get_type (item, $Result))
		ensure
			success: last_call_success = 0 or error_code_is_object_neutered (last_call_success)
		end

feature {NONE} -- Implementation / Constants

	cpp_query_interface_ICorDebugGenericValue (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugGenericValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugReferenceValue (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugReferenceValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugHandleValue (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugHandleValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugHeapValue (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugHeapValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugHeapValue2 (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugHeapValue2, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugObjectValue (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugObjectValue, (void **) $a_p)"
		end

feature {NONE} -- Implementation / QueryInterface HEAP

	cpp_query_interface_ICorDebugBoxValue (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugBoxValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugStringValue (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugStringValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugArrayValue (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		require
			obj /= Default_pointer
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugArrayValue, (void **) $a_p)"
		end

--| NOTA JFIAT: uncomment this to equipped those classes with nice expression to evaluate
--| for debugging purpose only

feature -- only for test purpose (evaluation in debugger)

	query: TUPLE [
					STRING, detachable ICOR_DEBUG_VALUE, -- object
					STRING, detachable ICOR_DEBUG_VALUE, -- ref
					STRING, detachable ICOR_DEBUG_VALUE, -- hdl
					STRING, detachable ICOR_DEBUG_VALUE, -- str
					STRING, detachable ICOR_DEBUG_VALUE, -- gene
					STRING, detachable ICOR_DEBUG_VALUE, -- array
					STRING, detachable ICOR_DEBUG_VALUE  -- heap2
					]
			-- Debug purpose only, will be removed soon
		local
			i_obj: like query_interface_icor_debug_object_value
			i_ref: like query_interface_icor_debug_reference_value
			i_hdl: like query_interface_icor_debug_handle_value
			i_str: like query_interface_icor_debug_string_value
			i_gen: like query_interface_icor_debug_generic_value
			i_arr: like query_interface_icor_debug_array_value
			i_hea: like query_interface_icor_debug_heap_value
			i_hea2: like query_interface_icor_debug_heap_value2
		do
			i_obj := query_interface_icor_debug_object_value
			i_ref := query_interface_icor_debug_reference_value
			i_hdl := query_interface_icor_debug_handle_value
			i_str := query_interface_icor_debug_string_value
			i_gen := query_interface_icor_debug_generic_value
			i_arr := query_interface_icor_debug_array_value
			i_hea := query_interface_icor_debug_heap_value
			i_hea2 := query_interface_icor_debug_heap_value2

			Result := [
						"Object", i_obj,
						"Reference", i_ref,
						"Handle", i_hdl,
						"String", i_str,
						"Generic", i_gen,
						"Array", i_arr ,
						"Heap", i_hea ,
						"Heap2", i_hea2
						]
--			if i_obj /= Void then
--				i_obj.clean_on_dispose
--			end
--			if i_ref /= Void then
--				i_ref.clean_on_dispose
--			end
--			if i_hdl /= Void then
--				i_hdl.clean_on_dispose
--			end
--			if i_str /= Void then
--				i_str.clean_on_dispose
--			end
--			if i_gen /= Void then
--				i_gen.clean_on_dispose
--			end
--			if i_arr /= Void then
--				i_arr.clean_on_dispose
--			end
--			if i_hea /= Void then
--				i_hea.clean_on_dispose
--			end
--			if i_hea2 /= Void then
--				i_hea2.clean_on_dispose
--			end
		end
--		
--	to_string: STRING is
--			-- Debug purpose only, will be removed soon
--		local
--			vi: EIFNET_DEBUG_VALUE_INFO
--		do
--			create vi.make (Current)
--			create Result.make_from_string (vi.value_to_string) --   "test"
--			if vi.value_module_file_name /= Void then
--				Result.append ("%N module=" + vi.value_module_file_name)
--			end
--			if vi.value_class_type /= Void then
--				Result.append ("%N class_type=" + vi.value_class_type.full_il_implementation_type_name)
--			end			
--		end	

end
