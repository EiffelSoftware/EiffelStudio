indexing
	description: "A stone representing an observed command instance."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	OBSERVED_INSTANCE_STONE

inherit
	OBSERVER_STONE
		redefine
			remove_yourself
		end

creation
	make

feature -- Removable

	associated_observer: CMD_INSTANCE
			-- Observer corresponding to the current observed instance
	
	add_associated_observer (cmd: CMD_INSTANCE) is
		do
			associated_observer := cmd	
		end
	
	remove_yourself is
			-- Remove the associated command instance from the
			-- observed instances list of the command instance associated
			-- with `associated_editor'.
		local
			command: CUT_OBSERVER_CMD
		do
			!! command.make (data, associated_observer)
			command.execute (Void)
		end


end -- class OBSERVED_INSTANCE_STONE
