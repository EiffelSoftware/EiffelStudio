indexing
	description: "Objects that represent a command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_COMMAND

feature -- Basic operations

	execute is
			-- Execute `Current'.
		deferred
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		deferred
		end

feature -- Access
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		deferred
		ensure
			result_not_void: Result /= Void
		end

end -- class GB_COMMAND
