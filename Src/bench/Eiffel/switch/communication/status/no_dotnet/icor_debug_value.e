indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_VALUE

feature

	is_valid_object: BOOLEAN is
		do
		end

--inherit
--	ICOR_OBJECT
--		redefine
--			init_icor
--		end
--
--create 
--	make_by_pointer
--	
feature -- Cleaning and dipose

	clean_on_dispose is
		do
		end

--feature {NONE} -- Initialization
--
--	init_icor is
--			-- 	
--		do
--			Precursor
--			type := get_type
--			size := get_size
--			address_as_string := get_address.to_integer.to_hex_string	
--		end
--
--feature {ICOR_EXPORTER} -- Properties
--
--	type: INTEGER
--	
--	size: INTEGER
--	
--	address_as_string: STRING
--	
--feature {ICOR_EXPORTER} -- QueryInterface
--
--	query_interface_icor_debug_generic_value: ICOR_DEBUG_GENERIC_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugGenericValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--	query_interface_icor_debug_reference_value: ICOR_DEBUG_REFERENCE_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugReferenceValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--	query_interface_icor_debug_heap_value: ICOR_DEBUG_HEAP_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugHeapValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--	query_interface_icor_debug_object_value: ICOR_DEBUG_OBJECT_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugObjectValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--feature {ICOR_EXPORTER} -- QueryInterface HEAP
--
--	query_interface_icor_debug_box_value: ICOR_DEBUG_BOX_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugBoxValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--	query_interface_icor_debug_string_value: ICOR_DEBUG_STRING_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugStringValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--	query_interface_icor_debug_array_value: ICOR_DEBUG_ARRAY_VALUE is
--		local
--			p: POINTER
--		do
--			last_call_success := cpp_query_interface_ICorDebugArrayValue (item, $p)
--			if p /= default_pointer then
--				create Result.make_by_pointer (p)
--				Result.add_ref
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--feature {ICOR_EXPORTER} -- Access
--
--	get_type: INTEGER is
--			-- GetType  
--		do
--			last_call_success := cpp_get_type (item, $Result)
--		ensure
--			success: last_call_success = 0
--		end
--
--	get_size: INTEGER is
--			-- GetSize returns the size in bytes 
--		do
--			last_call_success := cpp_get_size (item, $Result)
--		ensure
--			success: last_call_success = 0
--		end
--
--	get_address: INTEGER_64 is
--			-- GetAddress returns the address of the value in the debugee
--			-- process.  This might be useful information for the debugger to
--			-- show.
--	 		-- * If the value is at least partly in registers, 0 is returned.
--		do
--			last_call_success := cpp_get_address (item, $Result)
--		ensure
--			success: last_call_success = 0
--		end
--
end -- class ICOR_DEBUG_VALUE

