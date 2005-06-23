indexing
	description: "[
	interface ICorDebugHeapValue2 : IUnknown
	{
		/*
		  * Creates a handle of the given type for this heap value.
		  */
		HRESULT CreateHandle([in] CorDebugHandleType type, [out] ICorDebugHandleValue ** ppHandle);

	};
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_HEAP_VALUE2

inherit
	ICOR_DEBUG_VALUE
	
	ICOR_DEBUG_HANDLE_TYPE
		undefine
			out
		end

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	create_strong_handle: ICOR_DEBUG_HANDLE_VALUE is
			-- Creates a handle of HANDLE_STRONG for this heap value
		local
			p: POINTER
		do
			last_call_success := cpp_create_handle (item, Handle_strong, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end
		
	create_weak_track_resurrection_handle: ICOR_DEBUG_HANDLE_VALUE is
			-- Creates a handle of HANDLE_WEAK_TRACK_RESURRECTION for this heap value
		local
			p: POINTER
		do
			last_call_success := cpp_create_handle (item, Handle_weak_track_resurrection, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	create_handle (hdl_type: INTEGER): ICOR_DEBUG_HANDLE_VALUE is
			-- Creates a handle of the given type for this heap valu	
		local
			p: POINTER
		do
			last_call_success := cpp_create_handle (item, hdl_type, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

feature {ICOR_DEBUG_VALUE} -- Implementation

	frozen cpp_create_handle (obj: POINTER; a_hdl_type: INTEGER; a_handle_value_ptr: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugHeapValue2 signature(CorDebugHandleType, ICorDebugHandleValue**): EIF_INTEGER 
				use "cli_debugger_utils.h"
			]"
		alias
			"CreateHandle"
		end

end -- class ICOR_DEBUG_HEAP_VALUE2

