indexing
	description: "Class which redefine the notion of linked_list%
				%in order to be able to use it in a Matisse database.%
				%If you have an attribute of type LINKED_LIST and you want%
				%to store/retreive from the database, you must%
				%switch to MT_LINKED_LIST."
	date: "$Date$"
	revision: "$Revision$"
	
class
	MT_LINKED_LIST [G -> MT_STORABLE]

inherit
	LINKED_LIST [G]
		redefine
			put_front, extend, put_left, put_right, 
			replace, merge_left, merge_right, remove,
			remove_left, remove_right, wipe_out
		select
			extend, wipe_out
		end

	LINKED_LIST [G]
		rename 
			extend as list_extend,
			wipe_out as list_wipe_out
		export 
			{NONE} list_extend, list_wipe_out
		redefine
			put_front, put_left, put_right, replace, merge_left,
			merge_right, remove, remove_left, remove_right
		end
			
	MT_RS_CONTAINABLE
		undefine
			copy, is_equal
		end

	MT_LINEAR_COLLECTION [G]
		undefine
			copy, is_equal
		end

creation
	make
	
feature -- Element change

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		local
			p: like first_element
		do
			{LINKED_LIST} Precursor (v)
			if v /= Void and then is_persistent then
				check_persistence (v)
				mt_remove_ignore_nosuchsucc (v)
				mt_add_first (v)
			end
		end

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		local
			p: like first_element
		do
			{LINKED_LIST} Precursor (v)
			if v /= Void and then is_persistent then
				check_persistence (v)
				mt_remove_ignore_nosuchsucc (v)
				mt_append (v)
			end
		end

	put_left (v: like item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
		local
			p, old_active: like first_element
		do
			if is_empty then
				put_front (v)
			elseif after then
				back
				put_right (v)
				move (2)
			else
				p := new_cell (active.item)
				p.put_right (active.right)
				active.put (v)
				active.put_right (p)
				active := p
				count := count + 1
				
				-- Processing for MATISSE
				if v /= Void and then is_persistent then
					old_active := active
					move (-2)
					check_persistence (v)
					mt_remove_ignore_nosuchsucc (v)
					if before then
						mt_add_first (v)
					else
						mt_add_after (v, active.item)
					end
					active := old_active
				end
			end
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		local
			p: like first_element
		do
			{LINKED_LIST} Precursor (v)
			if v /= Void and then is_persistent then
				check_persistence (v)
				mt_remove_ignore_nosuchsucc (v)			
				if before then
					mt_add_first (v)
				else
					mt_add_after (v, active.item)
				end
			end
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		do
			if active.item /= Void and then is_persistent then
				mt_remove (active.item)
			end
			{LINKED_LIST} Precursor (v)
			if v /= Void and then is_persistent then
				check_persistence (v)
				mt_remove_ignore_nosuchsucc (v)
				if active = first_element then
					mt_add_first (v)
				else
					mt_add_after (v, previous.item)
				end
			end
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		do
			{LINKED_LIST} Precursor (other)
			if is_persistent then
				from 
					other.start
				until 
					other.after
				loop
					check_persistence (other.item)
					other.forth
				end
			end
			mt_set_all
		end
	
	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		do
			{LINKED_LIST} Precursor (other)
			if is_persistent then
				from 
					other.start
				until 
					other.after
				loop
					check_persistence (other.item)
					other.forth
				end
			end
			mt_set_all
		end

feature -- Removal

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor.
			-- (or `after' if no right neighbor).
		local
			current_item: G
		do
			current_item := active.item
			{LINKED_LIST} Precursor
			if current_item /= Void then
				mt_remove (current_item)
			end
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			if index > 1 then
				Precursor
			end
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		local
			to_be_removed: G
		do
			if before then
				to_be_removed := first_element.item
			else
				to_be_removed := active.right.item
			end
			{LINKED_LIST} Precursor
			if to_be_removed /= Void then
				mt_remove (to_be_removed)
			end
		end
	
	wipe_out is
			-- Remove all items.
		do
			{LINKED_LIST} Precursor
			mt_remove_all
		end

feature {NONE} -- Implementation


	mt_put_at_loading (v: G; i: INTEGER) is
		do
			list_extend (v)
		end

	mt_resize_at_loading (new_size: INTEGER) is
			-- Do nothing
		do
		end
		
	wipe_out_at_reverting is
		do
			list_wipe_out
		end
		
end -- class MT_LINKED_LIST


