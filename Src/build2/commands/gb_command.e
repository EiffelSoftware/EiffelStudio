indexing
	description: "Objects that represent a command."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_COMMAND
	
inherit
	GB_SHARED_COMMAND_HANDLER

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
		end

end -- class GB_COMMAND
