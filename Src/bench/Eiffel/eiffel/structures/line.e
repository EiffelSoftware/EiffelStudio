class LINE [T -> ANY] 

inherit

	ARRAY [T]
		rename
			make as basic_make,
			wipe_out as array_wipe_out,
			item as array_item
		export
			{NONE} all
		end

creation

	make

	
feature

	cursor: INTEGER;
			-- Cursor in the line

	make is
		do
			basic_make (1, Chunk);
		end;

feature {NONE}

	Chunk: INTEGER is 50;

	
feature 

	insert (a: T) is
			-- Insert `a' in the line.
		do
			cursor := cursor + 1;
			if cursor > count then
				resize (1, count + Chunk);
			end;
			put (a, cursor);
		ensure
			item = a;
		end;

	change_item (t: T) is
			-- Remove one item
		require
			cursor > 0;
			not offright;
		do
			put (t, cursor);
		end;

	start is
			-- Start the iteration
		do
			cursor := 1;
		end;

	offright: BOOLEAN is
			-- Is the cursor offright ?
		do
			Result := cursor > count;
		end;

	forth is
			-- Iteration
		require
			not offright
		do
			cursor := cursor + 1;
		end;

	item: T is
			-- Item at cursor position
		require
			not offright
		do
			Result := array_item (cursor);
		end;

	wipe_out is
			-- Clear the structure
		do
			cursor := 0;
			clear_all;
		end;
			
end
