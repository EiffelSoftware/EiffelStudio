indexing
	description: "Undo command for replace all"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REPLACE_ALL_CMD

inherit
	UNDO_CMD

create
	make

feature -- Initialization

	make is
			-- Initialize
		do
			create undo_replace_list.make
		ensure
			postcondition_clause: -- Your postcondition here
		end

feature -- Transformation

	add (urc: UNDO_REPLACE_CMD) is
			-- add the undo command to the list
		do
			undo_replace_list.extend (urc)
		end	

feature -- Basic operations

	redo is
			-- undo this command
		do
			from
				undo_replace_list.start
			until
				undo_replace_list.after
			loop
				undo_replace_list.item.redo
				undo_replace_list.forth
			end
		end

	undo is
			-- redo this command
		do
			from
				undo_replace_list.finish
			until
				undo_replace_list.before
			loop
				undo_replace_list.item.undo
				undo_replace_list.back
			end
		end

feature {NONE} -- Implementation

	undo_replace_list: LINKED_LIST[UNDO_REPLACE_CMD];

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




end -- class UNDO_REPLACE_ALL_CMD
