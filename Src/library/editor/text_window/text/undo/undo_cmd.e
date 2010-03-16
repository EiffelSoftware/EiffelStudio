note
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

	bind_to_next
			-- bind the excution of this command to the execution of the following command
			-- in the undo-redo stack (i.e. set is_bound_with_next to true)
		do
			is_bound_to_next := True
		end

	unbind_to_next
			-- unbind the excution of this command to the execution of the following command
			-- in the undo-redo stack (i.e. set is_bound_with_next to False)
		do
			is_bound_to_next := False
		end

feature -- Status report

	undo_possible: BOOLEAN
			-- undo possible?
		do
			Result := True
		end

	redo_possible: BOOLEAN
			-- redo possible?
		do
			Result := True
		end

feature -- Basic operations

	undo
		require
			undo_possible: undo_possible
		deferred
		end

	redo
		require
			redo_possible: redo_possible
		deferred
		end

note
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
