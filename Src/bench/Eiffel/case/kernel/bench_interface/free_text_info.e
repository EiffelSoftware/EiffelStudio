indexing

	description: "Free form text with limited input checks.";
	date: "$Date$";
	revision: "$Revision $"

deferred class FREE_TEXT_INFO

inherit

	CONSTANTS
		redefine
			copy, is_equal
		end;
	LINKED_LIST [STRING]
		rename
			duplicate as duplicate_n
		redefine
			copy, is_equal
		end;

feature -- Properties

	--stone_cursor: SCREEN_CURSOR is
	--	do
	--	--	Result := Cursors.comment_cursor
	--	end;

	stone (data: DATA): ELEMENT_STONE is
		deferred
		end;

feature -- Setting

	--setup_namer (namer: NAMER_WINDOW) is
	--	do
	--		namer.set_up (False, True);
	---		namer.set_text (text_value)
	--	end;

	--update_from_namer (namer: NAMER_WINDOW) is
	--	do
	--		format (namer.entered_text);
	--	end;

feature -- Access

	illegal_characters (tag, text: STRING): BOOLEAN is
			-- Does `tag' or `text' contain illegal characters (answer is `false')
			-- In fact this version should never be called
		do
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			if other.count = count then 
				Result := True;
				from
					start;
					other.start
				until
					after or else not Result
				loop
					Result := other.item.is_equal (item);
					other.forth
					forth;
				end;
			end
		end;

feature -- Duplication

	duplicate: like Current is
		do
			start;
			Result := duplicate_n (count);
		end

	copy (other: like Current) is
		do
			wipe_out
			from
				other.start;
			until
				other.after
			loop
				put_right (clone (other.item));
				forth;
				other.forth;
			end;
		end;

feature -- Transformation

	format (text: STRING) is
			-- Format description from `text'.
		require
			valid_text: text /= Void
		local
			tmp: STRING;
			i: INTEGER;
			c: CHARACTER;
			desc: DESCRIPTION_DATA
		do
			wipe_out;
			from
				!! tmp.make (0);
				i := 1;
			until
				i > text.count
			loop
				c := text.item (i);
				if c = '%N' then
					if not tmp.empty then
						extend (clone (tmp))
					end;
					tmp.wipe_out
				else
					tmp.extend (c);
				end;
				i := i + 1
			end;
			if not tmp.empty then
				extend (clone (tmp))
			end
		end;

feature -- Output

	clickable_string: STRING is 
		do 
		end;

	focus: STRING is
		do
			Result := "comment"
		end;

	text_value: STRING is
		do
			!! Result.make (0);
			from
				start
			until
				after
			loop
				Result.append (item);
				forth;
				if not after then
					Result.extend ('%N');
				end;
			end
		end;
	
	generate (text_area: TEXT_AREA; data: DATA ) is
		do
			if not empty then
				from
					start;
					text_area.start_comment;	
				until
					after
				loop
					text_area.append_comment_string (item);
					text_area.new_line;
					forth
				end;
				text_area.end_comment (stone (data));
			end;
		end;

feature -- Storage

	storage_info: S_FREE_TEXT_DATA is
			-- Format under which Current is stored
		do
			!! Result.make_filled (count); -- pascalf, FIXED_LIST problem
			from
				start;
				Result.start
			invariant
				same_index: index = Result.index
--%%%			variant
--%%%				remaining_elements: count - index
--%%% when this routine has just been freezed, this variant
--%%% may/will fail. If melted, it will be ok, which seems
--%%% to indicate a bug (not in Case).
			until
				after
			loop
debug ("FREE_TEXT_INFO")
				print ("%Nbegin loop: count = "); print (count);
				print (";  index = "); print (index); io.new_line
end
				Result.replace (item);
				Result.forth;
				forth
debug ("FREE_TEXT_INFO")
				print ("%Nend loop: count = "); print (count);
				print (";  index = "); print (index); io.new_line
end
			end
			check
				at_end: Result.after
			end
		end;

	make_from_storer (storer: S_FREE_TEXT_DATA) is
			-- Retrieve information from `storer'.
		require
			valid_storer: storer /= Void
		do
			make;
			from
				storer.start;
			until
				storer.after
			loop
				put_right (storer.item);
				storer.forth;
				forth
			end
		end

end -- class FREE_TEXT_INFO
