class TEXT_STRUCT 

inherit

	ARRAY [CLICK_STONE]
		rename
			make as array_create
		export
			{NONE} all;
			{ANY} empty
		end

feature 

	put__right (p: CLICK_STONE) is
			-- Move cursor one position forward, then
			-- put element `p' at cursor position, resize if necessary.
		do
			position := position + 1;
			if clickable_count = 0 then
				allocate_space (1, 20)
			elseif position > count then
				resize (1, count*2)
			end;
			put (p, position);
			clickable_count := clickable_count + 1
		ensure
			position = old position + 1;
			clickable_count = clickable_count + 1
		end;

	trace is
		do
			from
				io.error.putstring ("Text structure:%N");
				position := 1
			until
				position = clickable_count + 1
			loop
				io.error.putstring (item (position).tagged_out);
				position := position + 1
			end
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
				wipe_out;
				clickable_count := 0
			end
		ensure
			other.count = count;
			-- for all `i: 1..count, Result.item (i) = item (i)';
			-- Subsequent changes to the characters of current will
			-- also affect `other', and conversely.
		end;

feature {NONE}

	clickable_count: INTEGER;
			-- Number of clickable elements in structure
			-- Note that a clickable element is never removed

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
io.putstring ("After search by index, we have:%N");
io.putstring (item (position).tagged_out);
io.putstring ("N");
		end;

	position: INTEGER
	
end -- class TEXT_STRUCT
