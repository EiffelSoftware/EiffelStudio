indexing
	description: "Generic undo command"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	undo is
		deferred
		end

	redo is
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class UNDO_CMD
