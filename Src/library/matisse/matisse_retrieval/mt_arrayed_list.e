indexing
	description: "Class which redefine the notion of arrayed_list%
				%in order to be able to use it in a Matisse database%
				%If you have an attribute of type ARRAYED_LIST and you want%
				%to store/retreive from the database, you must%
				%switch to MT_ARRAYED_LIST."
	date: "$Date$"
	revision: "$Revision$"

class
	MT_ARRAYED_LIST [G -> MT_STORABLE]

inherit

	ARRAYED_LIST [G]
		redefine
			force, replace,  remove, prune_all, merge_left,
			extend, wipe_out, swap, insert
		select
			extend, merge_left, wipe_out
		end

	ARRAYED_LIST [G]
		rename
			extend as list_extend,
			merge_left as list_merge_left,
			wipe_out as list_wipe_out
		export
			{NONE} list_extend, list_merge_left, list_wipe_out
		redefine
			force, replace,  remove, prune_all,
			swap, insert
		end
		
	MT_RS_CONTAINABLE
		undefine
			setup, is_equal, copy
		end

	MT_LINEAR_COLLECTION [G]
		undefine
			setup, is_equal, copy
		end

creation
	make, make_filled

feature -- Element change

	force (v: like first) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			{ARRAYED_LIST} Precursor (v)
			if v /= Void and then is_persistent then
				check_persistence (v)
				mt_remove_ignore_nosuchsucc (v)
					-- 'v' may be already added to the successors list
					-- because of the inverse relationship effect.
				mt_append (v)
			end
		end

	extend (v: like first) is
			-- Add `v' to end.
			-- Do not move cursor.
		do
			{ARRAYED_LIST} Precursor (v)
			if v /= Void and then is_persistent then
				check_persistence (v)
				mt_remove_ignore_nosuchsucc (v)
					-- 'v' may be already added to the successors list
					-- because of the inverse relationship effect
				mt_append (v)
			end
		end
	
	replace (v: like first) is
			-- Replace current item by `v'.
		local
			old_item: like first
		do
			old_item := item
			{ARRAYED_LIST} Precursor (v)
			mt_remove (old_item)
			if v /= Void and then is_persistent then
				check_persistence (v)
				mt_remove_ignore_nosuchsucc (v)
				if index = 1 then
					mt_add_first (v)
				else
					mt_add_after (v, area.item (index - 2))
				end
			end
		end
	
	merge_left (other: ARRAYED_LIST [G]) is
		do
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
			list_merge_left (other)
			mt_remove_all
			mt_add_all
		end

feature -- Transformation

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
		local
			old_item: like item
		do
			old_item := item
			mt_remove (area.item (i - 1))
			replace (area.item (i - 1))
			area.put (old_item, i - 1)
			if is_persistent then
				if i = 1 then
					mt_add_first (old_item)
				else
					mt_add_after (old_item, area.item (i - 2))
				end
			end
		end

feature -- Removal

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor.
			-- (or `after' if no right neighbor).
		local
			to_be_removed: like first
		do
			to_be_removed := item
			{ARRAYED_LIST} Precursor
			mt_remove (to_be_removed)
		end

	prune_all (v: like item) is
			-- Remove all occurrences of `v'.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- Leave cursor `after'.
		do
			{ARRAYED_LIST} Precursor (v)
			mt_set_all
		end
	
	wipe_out is
			-- Remove all items.
		do
			{ARRAYED_LIST} Precursor
			mt_remove_all
		end
	
feature {NONE} -- Internal

	insert (v: like item; pos: INTEGER) is
			-- Add `v' at `pos', moving subsequent items
			-- to the right.
		do
			{ARRAYED_LIST} Precursor (v, pos)
			if v /= Void and then is_persistent then
				check_persistence (v)
				mt_remove_ignore_nosuchsucc (v)
				if pos = 1 then
					mt_add_first (v)
				else
					mt_add_after (v, area.item (pos - 2))
				end
			end
		end

feature {NONE} -- Implementation

	mt_put_at_loading (v: like first; i: INTEGER) is
		do
			list_extend (v)
		end

	mt_resize_at_loading (new_size: INTEGER) is
		do
			resize (1, new_size)
		end
	
	wipe_out_at_reverting is
		do
			list_wipe_out
		end
	
end -- class MT_ARRAYED_LIST
