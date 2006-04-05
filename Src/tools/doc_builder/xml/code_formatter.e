indexing
	description: "Simple formatter of Eiffel code text.  Converts Eiffel code text into%
		%corresponding XML tagged eiffel code text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_FORMATTER

inherit
	CODE_FORMATTER_CONSTANTS

feature -- Access

	text: STRING
			-- The formatted text
			
	last_formatted_line: STRING
			-- Last line which underwent formatting
			
feature -- Commands
	
	format (a_text: STRING) is
			-- Format `a_text'.  Result put into `text'
		require
			text_not_void: a_text /= Void
			text_not_empty: not a_text.is_empty
		local
			l_index,
			l_cnt: INTEGER
			l_line: STRING
			l_char: CHARACTER
		do
			prepare_for_formatting (a_text)
			create text.make_empty
			create l_line.make_empty
			from				
				l_index := 1
				l_cnt := a_text.count
			until
				l_index > l_cnt
			loop
				l_char := a_text.item (l_index)
				l_line.append_character (l_char)
				if l_char.out.is_equal (newline_string) or l_index = l_cnt then
					format_line (l_line)					
					text.append (last_formatted_line)
					l_line.wipe_out
				end
				l_index := l_index + 1
			end
		ensure
			has_text: text /= Void
		end

	format_line (a_line: STRING) is
			-- Format `a_line', put result into `last_formatted_line'
		local
			l_last_char: CHARACTER
			l_done,
			l_was_new: BOOLEAN
			l_index,
			l_cnt: INTEGER
			l_head: STRING
		do
				-- Remove the head spaces and tabs
			from 
				l_index := 1
				l_cnt := a_line.count
				create l_head.make_empty
			until
				l_index > l_cnt or l_done
			loop
				l_last_char := a_line.item (l_index)
				if l_last_char.out.is_equal (tab_string) or l_last_char.out.is_equal (space_string) then
					l_head.append_character (l_last_char)
				else
					l_done := True
				end
				l_index := l_index + 1
			end
			
			if not l_head.is_empty then
				a_line.remove_head (l_head.count)
			end
			
				-- Remove the newline tail
			if not a_line.is_empty then				
				if a_line.item (a_line.count) = '%N' then
					a_line.remove_tail (1)
					l_was_new := True
				end	
			end
			
				-- Format
			if not a_line.is_empty then
				if is_comment (a_line.twin) then
					a_line.prepend ("<comment>")
					a_line.append ("</comment>")
				else
					format_all_feature_names (a_line)
					format_all_symbols (a_line)	
					format_all_keywords (a_line)
					format_class_names (a_line)
				end
			end									
			last_formatted_line := a_line.twin
			
				-- Restore head
			if not l_head.is_empty then
				last_formatted_line.prepend (l_head)
			end
			
				-- Restore tail
			if l_was_new then
				last_formatted_line.append (newline_string)
			end
		end		

feature {NONE} -- Implementation
		
	prepare_for_formatting (a_text: STRING) is
			-- Prepare `a_text' for formatting
		do
			from
				format_tags.start
			until
				format_tags.after
			loop
				if a_text.has_substring (format_tags.item_for_iteration) then
					a_text.replace_substring_all (format_tags.item_for_iteration, empty_string)
					if a_text.has_substring (format_tags.key_for_iteration) then
						a_text.replace_substring_all (format_tags.key_for_iteration, empty_string)	
					end
				end
				format_tags.forth
			end
		end		
		
	format_all_feature_names (a_line: STRING) is
			-- Format all recognized feature names
		local
			l_index,
			l_start_index,
			l_end_index,
			l_cnt: INTEGER
			l_done,
			l_found: BOOLEAN
		do
			from
				l_index := 1
			until
				l_done
			loop
				l_index := a_line.index_of (dot_char, l_index)
				if l_index > 1 then
						-- Determine previous word
					from
						l_start_index := l_index - 1
						l_found := False
					until
						l_found or l_start_index = 0
					loop
						if not is_valid_feature_char (a_line.item (l_start_index)) then
								-- A non-alphanumeric character implies end of feature name
							l_found := True
						else
							l_start_index := l_start_index - 1
						end
					end
					a_line.insert_string ("<feature_name>",  l_start_index + 1)
					a_line.insert_string ("</feature_name>",  l_index + ("<feature_name>").count)
					
						-- Take into account inserted string dimension
					l_index := l_index + ("<feature_name></feature_name>").count + 1
					l_found := False
					
						-- Determine if this dot call is only one level deep (a.b).  If so, format the call, if
						-- not it will be formatted by the next format iteration.
					if not (l_index > a_line.count) then
						from
							l_start_index := l_index
							l_end_index := l_start_index
							l_cnt := a_line.count
						until
							l_found or l_end_index > l_cnt
						loop
							if not is_valid_feature_char (a_line.item (l_end_index)) then
								if a_line.item (l_end_index) = (dot_char) then
									a_line.insert_string ("<feature_name>",  l_start_index)
									a_line.insert_string ("</feature_name>",  l_end_index + ("<feature_name>").count)
									l_start_index := l_end_index + ("<feature_name></feature_name>").count + 1
									l_end_index := l_start_index
									l_cnt := a_line.count
								else
									l_found := True
								end															
							else
								l_end_index := l_end_index + 1
							end
						end
						a_line.insert_string ("<feature_name>",  l_start_index)
						a_line.insert_string ("</feature_name>",  l_end_index + ("<feature_name>").count)
						l_index := l_end_index
					end
					
				else
					l_done := True
				end
			end
		end
		
	format_all_symbols (a_line: STRING)	is
			-- Format all recognized code symbols
		do
			from
				a_line.append (space_string)
				symbols.start
			until
				symbols.after
			loop
				if a_line.has_substring (symbols.item) then
					a_line.replace_substring_all (symbols.item, "<symbol>" + symbols.item + "</symbol>")
				end				
				symbols.forth
			end
			a_line.remove_tail (1)
		end
		
	format_all_keywords (a_line: STRING) is
			-- Format all recognized code keywords
		do
			from
				keywords.start
				a_line.append (space_string)
			until
				keywords.after
			loop			
				if a_line.has_substring (keywords.item + space_string) then
					a_line.replace_substring_all (keywords.item + space_string, "<keyword>" + keywords.item + "</keyword>" + space_string)
				end
				if a_line.has_substring (keywords.item + newline_string) then
					a_line.replace_substring_all (keywords.item + newline_string, "<keyword>" + keywords.item + "</keyword>" + newline_string)				
				end	
				if a_line.has_substring (keywords.item + tab_string) then
					a_line.replace_substring_all (keywords.item + tab_string, "<keyword>" + keywords.item + "</keyword>" + tab_string)				
				end	
				keywords.forth
			end
			a_line.remove_tail (1)
		end
		
	format_class_names (a_line: STRING) is
			-- Format all recognized class names
		local
			l_index,
			l_cnt: INTEGER
			l_char: CHARACTER
			l_substring: STRING
		do
			from
				l_index := 1
				create l_substring.make_empty				
				a_line.append (tab_string)
				l_cnt := a_line.count
			until
				l_index > l_cnt
			loop		
				l_char := a_line.item (l_index)					
				if not is_valid_feature_char (l_char) then
					if is_uppercase (l_substring) and not l_substring.is_equal ("NONE") then
						a_line.replace_substring ("<class_name>" + l_substring + "</class_name>", l_index - l_substring.count, l_index - 1)
						l_index := l_index + ("<class_name></class_name>").count - 1
						l_cnt := a_line.count
					end
					l_substring.wipe_out
				else
					l_substring.append_character (l_char)
				end
				l_index := l_index + 1
			end
			a_line.remove_tail (1)
		end

feature {NONE} -- Query

	is_valid_feature_char (a_char: CHARACTER): BOOLEAN is
			-- Is `a_char' acceptable in a feature name (or class name)?
		do
			Result := a_char.is_alpha or a_char.is_digit or a_char = '_'
		end

	is_comment (a_line: STRING): BOOLEAN is
			-- Is `a_line' a comment?
		do
			a_line.prune_all_leading (newline_string.item (1))
			a_line.prune_all_leading (space_string.item (1))
			a_line.prune_all_leading (tab_string.item (1))
			if a_line.count > 1 then				
				Result := a_line.item (1) = '-' and a_line.item (2) = '-'	
			end
		end	
		
	is_uppercase (a_string: STRING): BOOLEAN is
			-- Are all alpha characters in `a_string' uppercase?
		local
			l_index: INTEGER
			l_char: CHARACTER
		do
			from
				l_index := 1
			until
				l_index > a_string.count
			loop
				l_char := a_string.item (l_index)    			
				if l_char.is_alpha then 
					Result := l_char.is_upper
				end
				l_index := l_index + 1
			end
		end	

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class CODE_FORMATTER
