note
	description: "Structure for caching and sorting INHERIT_INFO objects"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INHERIT_INFO_CACHE

inherit
	SORTED_TWO_WAY_LIST [INHERIT_INFO]
		rename
			make as sstwl_make
		redefine
			sort
		end

create
	make

create {INHERIT_INFO_CACHE}
	sstwl_make, make_sublist

feature {NONE} -- Initialization

	make (a_initial_count: INTEGER)
		require
			a_initial_count_valid: a_initial_count >= 0
		do
			sstwl_make
			reset_with_n_elements (a_initial_count)
		end

feature

	reset_with_n_elements (n: INTEGER)
			-- Reset `Current' to hold at least `n' elements.
		require
			n_valid: n >= 0
		local
			i: INTEGER
			l_used_item_count: INTEGER
		do
				-- Reset existing structure.
			from
				l_used_item_count := used_item_count
				start
				i := 1
			until
				i > l_used_item_count
			loop
				active.item.reset
				next_item
				i := i + 1
			end
			from
				i := count
			until
				i >= n
			loop
				new_inherited_info (Void, Void, Void).reset
				i := i + 1
			end
				-- Set to the start of the list
			start
			used_item_count := 0
		end

	sort
			-- Sort `Current' so that items are ordered by 'body_index'
			-- so that feature aliasing may be performed.
		local
			l_count: INTEGER
		do
			if used_item_count > 0 then
					-- Speed up, we only need to sort 'used_item_count' items.
					-- Replace count with used_item_count, sort, then reset count.
				l_count := count
				count := used_item_count
				Precursor
				count := l_count
			end
		end

	reset_all
			-- Reset all items in `Current'.
		do
			reset_with_n_elements (used_item_count)
			wipe_out
		end

	new_inherited_info (a_feature: FEATURE_I; p: PARENT_C; a_parent_type: LIKE_CURRENT): INHERIT_INFO
			-- Return a new inherit info object.
		do
			if not after then
				Result := active.item
					-- Make sure item is reset.
				Result.set_with_feature_and_parent (a_feature, p, a_parent_type)
					-- Move to next element in list.
				next_item
			else
					-- We are off the list so we add a new item
				put_left (create {INHERIT_INFO}.set_with_feature_and_parent (a_feature, p, a_parent_type))
				Result := last
			end
			used_item_count := used_item_count + 1
		end

	next_item
			-- Faster version of forth as we know we are not off the list.
		do
			if active.right = Void then
				active := last_element
				after := True
			else
				active := active.right
			end
		end

	used_item_count: INTEGER
		-- Number of used items from `Current'

end
