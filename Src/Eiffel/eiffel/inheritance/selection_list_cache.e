note
	description: "Summary description for {SELECTION_LIST_CACHE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SELECTION_LIST_CACHE

inherit
	SORTED_TWO_WAY_LIST [SELECTION_LIST]
		rename
			make as sstwl_make
		end

create
	make

create {SELECTION_LIST_CACHE}
	sstwl_make, make_sublist

feature {NONE} -- Initialization

	make (a_initial_count: INTEGER)
		do
			sstwl_make
			reset_with_n_elements (a_initial_count)
		end

feature

	reset_with_n_elements (n: INTEGER)
			-- Reset `Current' to hold at least `n' elements.
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
				new_selection_list.reset
				i := i + 1
			end
				-- Set to the start of the list
			start
			used_item_count := 0
		end

	reset_all
			-- Reset all items in `Current'.
		do
			reset_with_n_elements (used_item_count)
			wipe_out
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

	new_selection_list: SELECTION_LIST
			-- Return a new selection list object.
		do
			if not after then
				Result := active.item
				Result.reset
				next_item
			else
					-- We are off the list so we add a new item
				put_left (create {SELECTION_LIST}.make (5))
				Result := last
			end
			used_item_count := used_item_count + 1
		end

	used_item_count: INTEGER
		-- Number of used items from `Current'

end
