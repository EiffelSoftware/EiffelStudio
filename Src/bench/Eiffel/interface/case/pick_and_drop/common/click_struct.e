indexing

	description: "Structured array of click_stone.";
	date: "$Date$";
	revision: "$Revision $"

class CLICK_STRUCT 

inherit

	ARRAY [CLICK_STONE]
		export
			{NONE} all;
			{ANY} empty, item
		end

creation

	make

feature -- Properties

	clickable_count: INTEGER;
			-- Number of clickable elements in structure
			-- Note that a clickable element is never removed

	position: INTEGER;
			-- Current cursor position

feature -- Access

	current_item: CLICK_STONE is
			-- Click stone item at position
		do
			Result := item (position)
		end;

	click_stone_at (i: INTEGER): CLICK_STONE is
			-- Search for click_stone for position `i' is located
			-- between the start and end position of click stones.
		local
			c_stone: CLICK_STONE
		do
			from
				position := 1
			until
				position > clickable_count or else Result /= Void
			loop
				c_stone := item (position);
				if i >= c_stone.start_position and then
					i <= c_stone.end_position 
				then
					Result := c_stone
				end;
				position := position + 1
			end
		end;

	search_by_index (i: INTEGER) is
			-- Search for element which `start_position' is the greatest
			-- integer lower than or equal to `i'.
			-- Start if none.
		do
			if i <= item (1).end_position then
				position := 1
			elseif i >= item (clickable_count).start_position then
				position := clickable_count
			else
				from
					position := 1
				until
					i < item (position + 1).start_position
				loop
					position := position + 1
				end
			end;
		end;

feature -- Element change

	put_right (p: CLICK_STONE) is
			-- Move cursor one position forward, then
			-- put element `p' at cursor position, resize if necessary.
		require
			valid_p: p /= Void
		do
			position := position + 1;
			if position > count then
				resize (1, count*2)
			end;
			put (p, position);
			clickable_count := clickable_count + 1
		ensure
			clickable_count_incremented: (old clickable_count) + 1 = clickable_count;
			item_is_p: item (position) = p
		end;

	share (other: ARRAY [CLICK_STONE]) is
			-- Make current text structure share the content of `other';
			-- wipe-out and set clickable_count to 0 if void.
		require
			argument_not_void: other /= Void;
			-- argument_full:  foreach i, not other.item (i).Void
		do
			if other /= Void then
				area := other.area;
				lower := other.lower;
				upper := other.upper;
				clickable_count := upper - lower + 1
			else
				clear_all;
				clickable_count := 0
			end
		ensure
			other.count = count;
			-- for all `i: 1..count, Result.item (i) = item (i)';
			-- Subsequent changes to the characters of current will
			-- also affect `other', and conversely.
		end;

feature -- Removal

	clear is
			-- Clear structures and reset
			-- clickable_count and clickable_count.
		do
			clear_all;
			clickable_count := 0;
			position := 0;
		ensure
			clickable_count_resetted: clickable_count = 0;
			position_resetted: position = 0
		end;

end 
