indexing
	description: "Representation of an eiffel line of class text.";
	date: "$Date$";
	revision: "$Revision $"

class EIFFEL_LINE

creation
	make
	
feature -- Initialization
	
	make (start_pos, end_pos: INTEGER; s: STRING) is
			-- Create a line with `p' as position and 
			-- `s' as text.
		require
			good_values: start_pos >= 0 and then end_pos >= 0;
			valid_positions: end_pos >= start_pos;
		do
			start_position := start_pos;
			end_position := end_pos;
			text := clone (s);
		end;

feature -- Properites

	Eiffel_comment_identifier: STRING is "--";
			-- Comment identifier

	text: STRING;	
			-- Eiffel line text

	start_position: INTEGER;
			-- Position at the beginning of the line 

	end_position: INTEGER;
			-- Position at the end of the line 

	comment: CELL2 [STRING, INTEGER] is
			-- Comment extracted from Eiffel line
			-- (Void if comment was not found). First item
			-- is the comment string and the second item is the
			-- position of the comment string within the line
		local
			comment_pos: INTEGER;
			comment_string: STRING;
			start_pos: INTEGER;
			t: like text;
			tc: INTEGER
		do
			t := text;
			if t.count >= 2 then
				comment_pos := t.substring_index (Eiffel_comment_identifier, 1);
				if comment_pos > 0 then
					tc := t.count;
					Result := comment_line;
						-- Comment found	
					start_pos := comment_pos + 2;
					if start_pos <= tc then
						comment_string := t.substring (start_pos, tc);
						comment_string.right_adjust;
					else
							-- Empty comment line.
						!! comment_string.make (0)
					end;
					Result.make (comment_string, start_position + comment_pos);
				end
			end;
		ensure
			valid_result: Result /= Void implies 
					(Result.item1 /= Void and then Result.item2 > 0)
		end;

feature -- Access

	is_within (position: INTEGER): BOOLEAN is
			-- Is `position' within line?
		do
			Result := position >= start_position and then
					position <= end_position
		ensure
			Result implies position >= start_position and then
					position <= end_position
		end

feature {NONE} -- Implementation

	comment_line: CELL2 [STRING, INTEGER] is
		once
			!! Result.make (Void, 0)
		end;
				
feature -- Debug

	trace is
		do
			io.error.putstring ("start pos: ");
			io.error.putint (start_position);
			io.error.putstring (" end pos: ");
			io.error.putint (end_position);
			io.error.putstring (" ");
			io.error.putstring (text);
			io.error.new_line;	
		end

end
