indexing
	description: "Generic undo command"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNDO_CMD

feature -- Status report

	is_bound_to_next: BOOLEAN
			-- does this command belong to a group of undo commands to be executed at the same time 

feature -- Status setting

	bind_to_next is 
			-- bind the excution of this command to the execution of the following command
			-- in the undo-redo stack (i.e. set is_bound_with_next to true)
		do
			is_bound_to_next := True
		end

	unbind_to_next is
			-- unbind the excution of this command to the execution of the following command
			-- in the undo-redo stack (i.e. set is_bound_with_next to False)
		do
			is_bound_to_next := False
		end

feature -- Basic operations

	undo	is
		deferred
		end

	redo is
		deferred
		end

end -- class UNDO_CMD
