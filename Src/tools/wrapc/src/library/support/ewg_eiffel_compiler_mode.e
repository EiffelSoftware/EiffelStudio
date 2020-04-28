note

	description:

		"Eiffel compiler mode"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_EIFFEL_COMPILER_MODE

inherit

	EWG_SHARED_EIFFEL_COMPILER_NAMES

create

	make

feature {NONE} -- Initialization

	make
			-- Initialize ise compiler
		do
			eiffel_compiler_mode := eiffel_compiler_names.ise_code
		ensure
			ise_mode_set: eiffel_compiler_mode = eiffel_compiler_names.ise_code
		end

feature -- Access

	eiffel_compiler_mode: INTEGER
			-- Eiffel compiler mode; See EWG_EIFFEL_COMPILER_NAMES

	eiffel_compiler_name: STRING
			-- Eiffel compiler name; See EWG_EIFFEL_COMPILER_NAMES
		do
			Result := eiffel_compiler_names.eiffel_compiler_name_from_code (eiffel_compiler_mode)
		ensure
			name_not_void: Result /= Void
			name_valid_eiffel_name: eiffel_compiler_names.is_valid_eiffel_compiler_name (Result)
		end

feature -- Setting

	is_ise_mode: BOOLEAN
			-- Is current mode ISE Eiffel mode?
		do
			Result := eiffel_compiler_mode = eiffel_compiler_names.ise_code
		ensure
			definition: Result = (eiffel_compiler_mode = eiffel_compiler_names.ise_code)
		end


feature -- Status setting

	set_eiffel_compiler_mode (a_mode: INTEGER)
			-- Set `eiffel_compiler_mode' to `a_mode'.
			-- See EWG_EIFFEL_COMPILER_NAMES.
		require
			valid_a_mode: eiffel_compiler_names.is_valid_eiffel_compiler_code (a_mode)
		do
			eiffel_compiler_mode := a_mode
		ensure
			eiffel_compiler_mode_set: eiffel_compiler_mode = a_mode
		end

	set_ise_mode
			-- Set `eiffel_compiler_mode' to ISE Eiffel mode.
		do
			set_eiffel_compiler_mode (eiffel_compiler_names.ise_code)
		ensure
			mode_set: eiffel_compiler_mode = eiffel_compiler_names.ise_code
		end


invariant

	valid_eiffel_compiler_mode: eiffel_compiler_names.is_valid_eiffel_compiler_code (eiffel_compiler_mode)

end
