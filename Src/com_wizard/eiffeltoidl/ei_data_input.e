indexing
	description: "Objects that ..."
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

	input_from_file (a_file_name: STRING) is
			-- Input data from 'a_file_name'.
		require
			non_void_file: a_file_name /= Void
		deferred
		end

end -- class EI_DATA_INPUT
