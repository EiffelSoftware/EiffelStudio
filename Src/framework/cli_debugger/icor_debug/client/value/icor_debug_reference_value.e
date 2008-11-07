indexing
	description: "[
		ICorDebugReferenceValue
			GetValue([out] void *pTo);
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_REFERENCE_VALUE

inherit
	ICOR_DEBUG_VALUE_WITH_VALUE

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	is_null: BOOLEAN is
			-- IsNull tests whether the reference is null
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_null (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0			
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_value (a_result_64: POINTER) is
			-- GetValue copies the value into the specified buffer
		do
			last_call_success := cpp_get_value (item, a_result_64)
		end
	
	set_value (a_cordb_address: INTEGER_64) is
			-- SetValue copies a new value from the specified buffer. The buffer should
			-- be the appropriate size for the simple type.
		do
			last_call_success := cpp_set_value (item, a_cordb_address)
		end		

	dereference: ICOR_DEBUG_VALUE is
			-- Dereference returns a ICorDebugValue representing the value
			-- referenced. If the resulting value is a garbage collected
			-- object, then the resulting value is a "weak reference" which
			-- will become invalid if the object is garbage collected.
		local
			p: POINTER
		do
			last_call_success := cpp_dereference (item, $p)
			if p /= default_pointer then
				create Result.make_value_by_pointer (p)
			end
		end
		
	dereference_strong: ICOR_DEBUG_VALUE is
			-- DereferenceStrong returns a ICorDebugValue representing the value
			-- referenced. If the resulting value is a garbage collected object,
			-- then the resulting value is a "strong reference" which will cause
			-- the object referenced to not be collect as long as it exists.
		local
			p: POINTER
		do
			last_call_success := cpp_dereference_strong (item, $p)
			if p /= default_pointer then
				create Result.make_value_by_pointer (p)
			end
		end		

feature {NONE} -- Implementation

	cpp_is_null (obj: POINTER; a_result: TYPED_POINTER[INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugReferenceValue signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"IsNull"
		end

	cpp_get_value (obj: POINTER; a_i64: POINTER): INTEGER is
			--| Nb: typedef ULONG64 CORDB_ADDRESS;
		external
			"[
				C++ ICorDebugReferenceValue signature(CORDB_ADDRESS*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetValue"
		end
		
	cpp_set_value (obj: POINTER; a_cordb_address: INTEGER_64): INTEGER is
			--| Nb: typedef ULONG64 CORDB_ADDRESS;
		external
			"[
				C++ ICorDebugReferenceValue signature(CORDB_ADDRESS): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetValue"
		end
		
	cpp_dereference (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugReferenceValue signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Dereference"
		end
		
	cpp_dereference_strong (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugReferenceValue signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"DereferenceStrong"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ICOR_DEBUG_REFERENCE_VALUE

