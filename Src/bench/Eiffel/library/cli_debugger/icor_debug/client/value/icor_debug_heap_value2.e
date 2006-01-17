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
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_HEAP_VALUE2

inherit
	ICOR_DEBUG_VALUE
	
	ICOR_DEBUG_HANDLE_TYPE
		undefine
			out, copy
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ICOR_DEBUG_HEAP_VALUE2

