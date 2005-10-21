indexing
	description: "Undo removing trailed blanks command."
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REMOVE_TRAILED_BLANK_CMD
	
inherit
	UNDO_CMD

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialization 
		do
			create undo_remove_trailed_blank_list.make
		end
		
feature -- Transformation

	add (urc: UNDO_DELETE_CMD) is
			-- add the undo command to the list
		do
			undo_remove_trailed_blank_list.extend (urc)
		end

feature -- Basic Operations

	redo is
			-- undo this command
		do
			from
				undo_remove_trailed_blank_list.start
			until
				undo_remove_trailed_blank_list.after
			loop
				undo_remove_trailed_blank_list.item.redo
				undo_remove_trailed_blank_list.forth
			end
		end

	undo is
			-- redo this command
		do
			from
				undo_remove_trailed_blank_list.finish
			until
				undo_remove_trailed_blank_list.before
			loop
				undo_remove_trailed_blank_list.item.undo
				undo_remove_trailed_blank_list.back
			end
		end
		
feature {NONE} -- Implementation

	undo_remove_trailed_blank_list: LINKED_LIST [UNDO_DELETE_CMD]

invariant
	
	undo_list_not_void: undo_remove_trailed_blank_list /= Void

end
