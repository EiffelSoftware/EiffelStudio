class EIFFEL_LINE

inherit

	COMPARABLE

creation

	make
	
feature
	
	make (p: INTEGER; s: STRING) is
			-- create a line with p as position and s as text
		do
			position := p;
			text := s;
		end;

	position: INTEGER;
		-- position of the line in the file (in character)

	infix "<" (other: like Current): BOOLEAN is
		do	
			Result := position < other.position;
		end;
			
	text: STRING;
		-- text of the line;

	count: INTEGER is
		do
			Result := text.count;
		end;

	empty: BOOLEAN is
			-- is the line empty
		do
			Result := text.empty;
		end;
	
	left_adjust is
			-- Remove leading blanks or tabs update position accordingly
		local
			i: INTEGER;
		do
			from
				i := 1
			until
				(i > text.count) or else ((text @ i) /= ' ') 
				and then ((text @ i) /= '%T')	
			loop
				i := i + 1
			end;
			i := i - 1;
			text.tail (text.count - i);
			position := position + i;
		end;

	right_adjust is
			-- Remove trailing blanks or tabs.
		local
			i : INTEGER;
		do
			from 
				i := text.count
			until
				(i < 1) or else ((text @ i) /= ' ') 
				and then ((text @ i) /= '%T')
			loop
	 			i := i - 1
			end;
			if i > 0 then
				text.head (i);
			else
				text.wipe_out;
			end;
		end;
	
	comment: like Current is
			-- Comment at the end of the string			
		local
			seeker: MATCH;
		do
			if comment_string = void  and not comment_found then
				!!seeker.make (text, "--", false);
				seeker.find_next;
				if seeker.position  + 2 <= text.count then
					!!comment_string.make (position + seeker.position + 2,
						text.substring (seeker.position + 2, text.count));
					comment_found := true;
				end;
			end;
			Result := comment_string;
		end;
				
	discard_comment	is
			-- discard the comment, if any
		do
			text.head (count - comment_string.count - 2);
			right_adjust;
			comment_string := void;
		end;

feature -- trace

	trace is
		do
			io.error.putstring ("position: ");
			io.error.putint (position);
			io.error.putstring (" ");
			io.error.putstring (text);
			io.error.new_line;	
		end

feature {NONE}

		comment_string: like Current;
		
		comment_found: BOOLEAN;

end
