indexing
	description: "Graphical components that can be in a valid or invalid state"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VALIDITY_CHECKER

feature -- Initialization

	initialize_checker is
			-- Initialize instance.
		do
			create {ARRAYED_LIST [STRING]} errors.make (5)
			errors.compare_objects
		end
		
	set_validator (a_validator: like validator) is
			-- Set `validator' with `a_validator'.
		do
			validator := a_validator
		ensure
			validator_set: validator = a_validator
		end
		
feature -- Access

	is_valid: BOOLEAN is
			-- Is component in a valid state?
		do
			Result := errors.is_empty
		end
	
	errors: LIST [STRING]
			-- Errors caused by validity checking

	validator: ROUTINE [ANY, TUPLE[]]
			-- Callback routine called when validity state changes

feature -- Basic Operations

	set_error (a_is_valid: BOOLEAN; a_error_message: STRING) is
			-- Remove `a_error_message' from errors if present and `a_is_valid'.
			-- Add it otherwise.
		require
			non_void_error_message: a_error_message /= Void
		local
			l_valid: BOOLEAN
		do
			l_valid := is_valid
			if a_is_valid then
				if errors.has (a_error_message) then
					errors.prune_all (a_error_message)
				end
			else
				if not errors.has (a_error_message) then
					errors.extend (a_error_message)
				end
			end
			if is_valid /= l_valid and validator /= Void then
				validator.call ([])
			end
		end

feature {NONE} -- Helpers

	is_valid_folder (a_folder: STRING): BOOLEAN is
			-- Is `a_folder' a valid folder?
		require
			non_void_path: a_folder /= Void
		do
			Result := not a_folder.is_empty and then (create {DIRECTORY}.make (a_folder)).exists
		end

	is_valid_file (a_file: STRING): BOOLEAN is
			-- Is `a_folder' a valid folder?
		require
			non_void_path: a_file /= Void
		do
			Result := not a_file.is_empty and then (create {RAW_FILE}.make (a_file)).exists
		end

invariant
	non_void_errors: errors /= Void
	no_error_iff_is_valid: is_valid = errors.is_empty

end -- class WIZARD_VALIDITY_CHECKER
