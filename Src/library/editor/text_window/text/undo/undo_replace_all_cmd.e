indexing
	description: "Undo command for replace all"
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

	undo_replace_list: LINKED_LIST[UNDO_REPLACE_CMD]

end -- class UNDO_REPLACE_ALL_CMD
