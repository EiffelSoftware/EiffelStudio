indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EI_DATA_INPUT

inherit
	EI_APP_CONSTANTS

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		deferred
		end

feature -- Access

	eiffel_class: EI_CLASS
			-- Eiffel class

feature -- Basic operation

	input_from_file (input_file: FILE) is
			-- Input data from 'input_file'.
		require
			non_void_file: input_file /= Void
			file_exists: input_file.exists
			valid_file: input_file.is_closed or input_file.is_open_read
		deferred
		end

end -- class EI_DATA_INPUT
