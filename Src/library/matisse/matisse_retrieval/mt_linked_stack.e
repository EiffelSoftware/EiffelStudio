indexing
	description: "Class which redefine the notion of linked_stack%
				%in order to be able to use it in a Matisse database.%
				%If you have an attribute of type LINKED_STACK and you want%
				%to store/retreive from the database, you must%
				%switch to MT_LINKED_STACK."
	date: "$Date$"
	revision: "$Revision$"

class
	MT_LINKED_STACK [G -> MT_STORABLE]

inherit
	LINKED_STACK [G]
		redefine
			linear_representation
		end
		
	MT_RS_CONTAINABLE
		undefine
			copy, is_equal
		end
	
creation
	make

feature

	mt_put_at_loading (v: G; i: INTEGER) is
		do
			extend (v)
		end

	mt_resize_at_loading (new_size: INTEGER) is
			-- Do nothing.
		do
		end

	linear_representation: ARRAYED_LIST [G] is
			-- Representation as a linear structure.
			-- (order is the same of original order of insertion).
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor;
			from
				!! Result.make (count);
				start
			until
				after
			loop
				Result.put_front (ll_item);
				forth
			end
			go_to (old_cursor)
		end

	wipe_out_at_reverting is
		do
		end	

end -- class MT_LINKED_STACK


