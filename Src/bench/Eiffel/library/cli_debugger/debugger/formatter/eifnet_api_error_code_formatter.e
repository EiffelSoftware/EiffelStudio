indexing
	description: "Manage error code display (debugging purpose)"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_API_ERROR_CODE_FORMATTER

feature -- Access

	error_code_to_string (a_error_code: INTEGER): STRING is
		local
			l_error_id: STRING
		do
			l_error_id := error_code_to_id (a_error_code)
			if error_meaning.has (l_error_id) then
				Result := error_meaning.item (l_error_id).twin
			else
				Result := ""
			end
			Result.prepend_string ("[ "+ a_error_code.out + " | " + l_error_id  + " ] ")
		end

	error_meaning: HASH_TABLE [STRING, STRING] is
		once
			create Result.make (10)
			Result.put ("Succeed", "0000")
			Result.put ("The process was not in a stopping event", "132F")
			Result.put ("[CORDBG_E_PROCESS_TERMINATED] Process was terminated", "1301")
			Result.put ("[CORDBG_E_PROCESS_NOT_SYNCHRONIZED] Process not synchronized", "1302")
			Result.put ("[CORDBG_E_CLASS_NOT_LOADED] A class is not loaded", "1303")
			Result.put ("[CORDBG_E_IL_VAR_NOT_AVAILABLE] An IL variable is not available at the current native IP", "1304")
			Result.put ("[CORDBG_E_BAD_REFERENCE_VALUE] A reference value was found to be bad during dereferencing", "1305")
			Result.put ("[CORDBG_E_FUNCTION_NOT_IL] Attempt to get a ICorDebug a function that is not IL", "130A")			

			Result.put ("[CORDBG_S_VALUE_POINTS_TO_VOID] The Debugging API doesn't support dereferencing pointers of type void", "1317")
			Result.put ("[COR_E_INVALIDCAST  E_NOINTERFACE] Indicates a bad cast condition", "4002")
			Result.put ("[COR_E_ARGUMENT|E_INVALIDARG] An argument does not meet the contract of the method", "0057")

			
		end

	error_code_to_id (a_error_code: INTEGER): STRING is
			-- Convert `last_call_success' to hex and keep the last word

		do
			Result := a_error_code.to_hex_string
			Result.keep_tail (4)
			Result.to_upper
		end

end -- class EIFNET_API_ERROR_CODE_FORMATTER
