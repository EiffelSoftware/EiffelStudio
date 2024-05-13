note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_REFERENCE_VALUE

inherit
	ICOR_DEBUG_VALUE_WITH_VALUE

feature {ICOR_EXPORTER} -- Access

	is_null: BOOLEAN
			-- IsNull tests whether the reference is null
		local
			r: INTEGER
		do
			set_last_call_success (cpp_is_null (item, $r))
			Result := r /= 0 --| TRUE = 1 , FALSE = 0			
		ensure
			success: last_call_succeed or error_code_is_object_neutered (last_call_success)
		end

	get_value (a_p_cordb_address: POINTER)
			-- GetValue copies the value into the specified buffer
		do
			set_last_call_success (cpp_get_value (item, a_p_cordb_address))
		end

	set_value (a_cordb_address: NATURAL_64)
			-- SetValue copies a new value from the specified buffer. The buffer should
			-- be the appropriate size for the simple type.
		do
			set_last_call_success (cpp_set_value (item, a_cordb_address))
		end

	dereference: ICOR_DEBUG_VALUE
			-- Dereference returns a ICorDebugValue representing the value
			-- referenced. If the resulting value is a garbage collected
			-- object, then the resulting value is a "weak reference" which
			-- will become invalid if the object is garbage collected.
		local
			p: POINTER
		do
			set_last_call_success (cpp_dereference (item, $p))
			if p /= default_pointer then
				Result := new_value (p)
			end
		end

	dereference_strong: ICOR_DEBUG_VALUE
			-- DereferenceStrong returns a ICorDebugValue representing the value
			-- referenced. If the resulting value is a garbage collected object,
			-- then the resulting value is a "strong reference" which will cause
			-- the object referenced to not be collect as long as it exists.
		local
			p: POINTER
		do
			set_last_call_success (cpp_dereference_strong (item, $p))
			if p /= default_pointer then
				Result := new_value (p)
			end
		end

feature {NONE} -- Implementation

	cpp_is_null (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugReferenceValue signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"IsNull"
		end

	cpp_get_value (obj: POINTER; a_p_cordb_address: POINTER): INTEGER
			--| Nb: typedef ULONG64 CORDB_ADDRESS;
		external
			"[
				C++ ICorDebugReferenceValue signature(CORDB_ADDRESS*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetValue"
		end

	cpp_set_value (obj: POINTER; a_cordb_address: NATURAL_64): INTEGER
			--| Nb: typedef ULONG64 CORDB_ADDRESS;
		external
			"[
				C++ ICorDebugReferenceValue signature(CORDB_ADDRESS): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"SetValue"
		end

	cpp_dereference (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugReferenceValue signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Dereference"
		end

	cpp_dereference_strong (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugReferenceValue signature(ICorDebugValue**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"DereferenceStrong"
		end

end
