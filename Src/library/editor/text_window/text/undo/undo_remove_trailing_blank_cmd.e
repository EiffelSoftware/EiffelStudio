indexing
	description: "Undo removing trailing blanks command."
	date: "$Date$"
	revision: "$Revision$"

class
	UNDO_REMOVE_TRAILING_BLANK_CMD
	
inherit
	UNDO_CMD

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialization 
		do
			create undo_remove_trailing_blank_list.make
		end
		
feature -- Transformation

	add (urc: UNDO_DELETE_CMD) is
			-- add the undo command to the list
		do
			undo_remove_trailing_blank_list.extend (urc)
		end
		
feature -- Status report

	converse : BOOLEAN
			-- Converse redo and undo behavior?

feature -- Status change

	set_converse (b: BOOLEAN) is
			-- Set `converse' with `b'.
		do
			converse := b	
		end		

feature -- Basic Operations

	redo is
			-- undo this command
		do
			if not converse then
				actual_redo
			else
				actual_undo
			end
		end

	undo is
			-- redo this command
		do
			if not converse then
				actual_undo
			else
				actual_redo
			end
		end
		
feature {NONE} -- Implementation

	actual_undo is
			-- Actual undo
		do
			from
				undo_remove_trailing_blank_list.finish
			until
				undo_remove_trailing_blank_list.before
			loop
				undo_remove_trailing_blank_list.item.undo
				undo_remove_trailing_blank_list.back
			end
		end
		
	actual_redo is
			-- Actual redo
		do
			from
				undo_remove_trailing_blank_list.start
			until
				undo_remove_trailing_blank_list.after
			loop
				undo_remove_trailing_blank_list.item.redo
				undo_remove_trailing_blank_list.forth
			end	
		end		

	undo_remove_trailing_blank_list: LINKED_LIST [UNDO_DELETE_CMD]

invariant
	
	undo_list_not_void: undo_remove_trailing_blank_list /= Void

end
