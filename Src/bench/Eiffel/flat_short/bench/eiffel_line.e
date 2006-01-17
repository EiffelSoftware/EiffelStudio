indexing
	description: "Representation of an eiffel line of class text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class EIFFEL_LINE

create
	make
	
feature -- Initialization
	
	make (start_pos, end_pos: INTEGER; s: STRING) is
			-- Create a line with `p' as position and 
			-- `s' as text.
		require
			good_values: start_pos >= 0 and then end_pos >= 0;
			valid_positions: end_pos >= start_pos;
			s_not_void: s /= Void
		do
			start_position := start_pos;
			end_position := end_pos;
			text := s.twin
		ensure
			text_set: text.is_equal (s)
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
						create comment_string.make (0)
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
			create Result.make (Void, 0)
		end;
				
feature -- Debug

	trace is
		do
			io.error.put_string ("start pos: ");
			io.error.put_integer (start_position);
			io.error.put_string (" end pos: ");
			io.error.put_integer (end_position);
			io.error.put_string (" ");
			io.error.put_string (text);
			io.error.put_new_line;	
		end

invariant
	text_not_void: text /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
