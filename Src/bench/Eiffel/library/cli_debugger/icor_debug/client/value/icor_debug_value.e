indexing
	description: "[
			Object representing Value from dotnet debugger.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_VALUE

inherit
	ICOR_OBJECT
		redefine
			init_icor
		end

create 
	make_by_pointer
	
feature {NONE} -- Initialization

	init_icor is
			-- 	
		do
			Precursor
			type := get_type
			size := get_size
			address_as_string := get_address.to_integer.to_hex_string	
		end
			
feature {ICOR_EXPORTER} -- Properties

	type: INTEGER
	
	size: INTEGER
	
	address_as_string: STRING
	
feature -- helpers

	is_valid_object: BOOLEAN is
			-- Is current a valid object, ie not collected ?
		local
			ref_value: like query_interface_icor_debug_reference_value
			deref_value: ICOR_DEBUG_VALUE
			heap_value: like query_interface_icor_debug_heap_value
		do
			ref_value := query_interface_icor_debug_reference_value
			if ref_value /= Void then
				deref_value := ref_value.dereference
				if deref_value /= Void then
					heap_value := deref_value.query_interface_icor_debug_heap_value
					if heap_value /= Void then
						Result := heap_value.is_valid
						heap_value.clean_on_dispose
					end
					deref_value.clean_on_dispose
				else
					Result := False
				end
				ref_value.clean_on_dispose
			end
		end
	
feature {ICOR_EXPORTER} -- QueryInterface

	query_interface_icor_debug_generic_value: ICOR_DEBUG_GENERIC_VALUE is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugGenericValue (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	query_interface_icor_debug_reference_value: ICOR_DEBUG_REFERENCE_VALUE is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugReferenceValue (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	query_interface_icor_debug_heap_value: ICOR_DEBUG_HEAP_VALUE is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugHeapValue (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	query_interface_icor_debug_object_value: ICOR_DEBUG_OBJECT_VALUE is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugObjectValue (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

feature {ICOR_EXPORTER} -- QueryInterface HEAP

	query_interface_icor_debug_box_value: ICOR_DEBUG_BOX_VALUE is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugBoxValue (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	query_interface_icor_debug_string_value: ICOR_DEBUG_STRING_VALUE is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugStringValue (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

	query_interface_icor_debug_array_value: ICOR_DEBUG_ARRAY_VALUE is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugArrayValue (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		end

feature {ICOR_EXPORTER} -- Access

	get_type: INTEGER is
			-- GetType  
		do
			last_call_success := cpp_get_type (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_size: INTEGER is
			-- GetSize returns the size in bytes 
		do
			last_call_success := cpp_get_size (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_address: INTEGER_64 is
			-- GetAddress returns the address of the value in the debugee
			-- process.  This might be useful information for the debugger to
			-- show.
	 		-- * If the value is at least partly in registers, 0 is returned.
		do
			last_call_success := cpp_get_address (item, $Result)
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_type (obj: POINTER; a_p_type: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugValue signature(CorElementType*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetType"
		end

	cpp_get_size (obj: POINTER; a_p_size: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugValue signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetSize"
		end

	cpp_get_address (obj: POINTER; a_p_size: TYPED_POINTER [INTEGER_64]): INTEGER is
		external
			"[
				C++ ICorDebugValue signature(CORDB_ADDRESS*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetAddress"
		end

feature {NONE} -- Implementation / Constants

	cpp_query_interface_ICorDebugGenericValue (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugGenericValue, (void **) $a_p)"
		end
		
	cpp_query_interface_ICorDebugReferenceValue (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugReferenceValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugHeapValue (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugHeapValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugObjectValue (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugObjectValue, (void **) $a_p)"
		end

feature {NONE} -- Implementation / QueryInterface HEAP

	cpp_query_interface_ICorDebugBoxValue (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugBoxValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugStringValue (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugStringValue, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugArrayValue (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugValue *) $obj)->QueryInterface (IID_ICorDebugArrayValue, (void **) $a_p)"
		end
		

--| NOTA JFIAT: uncomment this to equipped those classes with nice expression to evaluate
--| for debugging purpose only

--feature -- only for test purpose (evaluation in debugger)
--
--	query: TUPLE [STRING, ICOR_DEBUG_VALUE, STRING, ICOR_DEBUG_VALUE, STRING, ICOR_DEBUG_VALUE, STRING, ICOR_DEBUG_VALUE, STRING, ICOR_DEBUG_VALUE] is
--			-- Debug purpose only, will be removed soon
--		local
--			i_obj: like query_interface_icor_debug_object_value
--			i_ref: like query_interface_icor_debug_reference_value
--			i_str: like query_interface_icor_debug_string_value
--			i_gen: like query_interface_icor_debug_generic_value
--			i_arr: like query_interface_icor_debug_array_value
--			i_hea: like query_interface_icor_debug_heap_value
--		do
--			i_obj := query_interface_icor_debug_object_value
--			i_ref := query_interface_icor_debug_reference_value
--			i_str := query_interface_icor_debug_string_value			
--			i_gen := query_interface_icor_debug_generic_value			
--			i_arr := query_interface_icor_debug_array_value	
--			i_hea := query_interface_icor_debug_heap_value			
--
--			Result := [
--						"Object", i_obj, 
--						"Reference", i_ref, 
--						"String", i_str, 
--						"Generic", i_gen, 
--						"Array", i_arr ,
--						"Heap", i_hea						
--						]
--			i_obj.dispose
--			i_ref.dispose
--			i_str.dispose
--			i_gen.dispose
--			i_arr.dispose
--			i_hea.dispose
--		end
--		
--	to_string: STRING is
--			-- Debug purpose only, will be removed soon
--		local
--			vi: EIFNET_DEBUG_VALUE_INFO
--		do
--			create vi.make (Current)
--			Result := vi.value_to_string --   "test"
--			if vi.value_module_file_name /= Void then
--				Result.append ("%N module=" + vi.value_module_file_name)
--			end
--			if vi.value_class_type /= Void then
--				Result.append ("%N class_type=" + vi.value_class_type.full_il_implementation_type_name)
--			end			
--		end

end -- class ICOR_DEBUG_VALUE

