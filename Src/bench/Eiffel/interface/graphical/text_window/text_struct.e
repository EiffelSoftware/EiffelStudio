class TEXT_STRUCT 

inherit
	ARRAY [CLICK_STONE]
		rename
			make as array_create
		export
			{NONE} all
			{ANY} empty, area, item, put
		end

feature 

	add_click_stone (p: CLICK_STONE) is
			-- Move cursor one position forward, then
			-- put element `p' at cursor position, resize if necessary.
		do
			position := position + 1
			if clickable_count = 0 then
				resize (1, 20)
			elseif position > count then
				resize (1, count*2)
			end
			put (p, position)
			clickable_count := clickable_count + 1
		ensure
			position_set: position = old position + 1
			clickable_count_set: clickable_count = old clickable_count + 1
			sorted_insertion: p.start_position > item(position - 1).end_position
		end

	trace is
		do
			from
				io.error.putstring ("Text structure:%N")
				position := 1
			until
				position = clickable_count + 1
			loop
				io.error.putstring (item (position).tagged_out)
				position := position + 1
			end
		end

	share (other: ARRAY [CLICK_STONE]) is
			-- Make current text structure share the content of `other'
			-- wipe-out and set clickable_count to 0 if void.
		require
			argument_not_void: other /= Void
			-- argument_full:  foreach i, not other.item (i).Void
		do
			if other /= Void then
				area := other.area
				lower := other.lower
				upper := other.upper
				clickable_count := upper - lower + 1
			else
				wipe_out
				clickable_count := 0
			end
		ensure
			other.count = count
			-- for all `i: 1..count, Result.item (i) = item (i)'
			-- Subsequent changes to the characters of current will
			-- also affect `other', and conversely.
		end

	clickable_count: INTEGER
			-- Number of clickable elements in structure
			-- Note that a clickable element is never removed

	clear_clickable is
			-- Make the text_struct empty.
		do
			upper := -1
			lower := 0
			area := Void
			clickable_count := 0
		end

feature {NONE}

	search_by_index (i: INTEGER) is
			-- Search for element which `start_position' is the greatest
			-- integer lower than or equal to `i'.
			-- Start if none.
			-- The array is always sorted
		do
			position := binary_search (i, lower, clickable_count)
		end

	binary_search (key, lower_bound, upper_bound: INTEGER): INTEGER is
			-- Do a recursive search using the Binary search algorithm.
		local
			middle: INTEGER
		do
			if lower_bound = upper_bound then
				if key < item(lower_bound).start_position then
					Result := lower.max (lower_bound - 1)
				else
					Result := lower_bound
				end
			else 
				middle := (lower_bound + upper_bound) // 2
				if item(middle).end_position < key then
					Result := binary_search (key, middle + 1, upper_bound)
				else
					Result := binary_search (key, lower_bound, middle)
				end
			end
		end

	position: INTEGER
	
end -- class TEXT_STRUCT
