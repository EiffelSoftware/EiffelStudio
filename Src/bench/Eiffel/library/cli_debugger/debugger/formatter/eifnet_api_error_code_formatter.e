indexing
	description: "Manage error code display (debugging purpose)"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_API_ERROR_CODE_FORMATTER


feature -- //**** Common Language Runtime Debugging Services errors

	cordbg_e_static_var_not_available: INTEGER is 0x131A
			-- A static variable isn't available because
			-- it hasn't been initialized yet.

	cordbg_e_variable_is_actually_literal: INTEGER is 0x1334
			-- The 'variable' doesn't exist because it is a
			-- literal optimized away by the compiler - ask
			-- Metadata for it's default value, instead.  


	cordbg_e_field_not_available: INTEGER is 0x1306
			-- A field in a class is not available,
			-- because the runtime optimized it away.

feature -- Access

	error_code_to_string (a_error_code: INTEGER): STRING is
		local
			l_error_id: INTEGER
		do
			l_error_id := error_code_to_id (a_error_code)
			if error_meaning.has (l_error_id) then
				Result := error_meaning.item (l_error_id).twin
			else
				Result := ""
			end
			Result.prepend_string ("[ "+ a_error_code.out + " | " + l_error_id.out  + " ] ")
		end

	error_meaning: HASH_TABLE [STRING, INTEGER] is
		once
			create Result.make (10)
			Result.put ("Succeed", 0x0000)
			Result.put ("The process was not in a stopping event", 0x132F)
			Result.put ("[CORDBG_E_PROCESS_TERMINATED] Process was terminated", 0x1301)
			Result.put ("[CORDBG_E_PROCESS_NOT_SYNCHRONIZED] Process not synchronized", 0x1302)
			Result.put ("[CORDBG_E_CLASS_NOT_LOADED] A class is not loaded", 0x1303)
			Result.put ("[CORDBG_E_IL_VAR_NOT_AVAILABLE] An IL variable is not available at the current native IP", 0x1304)
			Result.put ("[CORDBG_E_BAD_REFERENCE_VALUE] A reference value was found to be bad during dereferencing", 0x1305)
			Result.put ("[CORDBG_E_FUNCTION_NOT_IL] Attempt to get a ICorDebug a function that is not IL", 0x130A)			

			Result.put ("[CORDBG_S_VALUE_POINTS_TO_VOID] The Debugging API doesn't support dereferencing pointers of type void", 0x1317)
			Result.put ("[COR_E_INVALIDCAST  E_NOINTERFACE] Indicates a bad cast condition", 0x4002)
			Result.put ("[COR_E_ARGUMENT|E_INVALIDARG] An argument does not meet the contract of the method", 0x0057)
		end

	error_code_to_id (a_error_code: INTEGER): INTEGER is
			-- Convert `last_call_success' to hex and keep the last word

		do
			Result := a_error_code & 0xFFFF
		end

end -- class EIFNET_API_ERROR_CODE_FORMATTER
