indexing
	description	: "Whole text displayed in the editor window."
	author		: "Christophe Bonnard [ bonnard@bigfoot.com ] / Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	VIEWER_CONTENT

inherit
	B_345_TREE [VIEWER_LINE]
		rename
			first_data as first_line,
			last_data as last_line
		end

create
	make, make_from_file

feature -- Initialization

	make_from_file (fn: STRING) is
		do
			make
			--| FIXME: Not yet implemented.
		end	

feature -- Access

	first_displayed_line: like current_line

	last_displayed_line: like current_line

	nb_of_lines_displayed: INTEGER

feature -- Search status

	found_string_line: INTEGER
			-- Line number of the last found string.
			-- Valid only if `successful_search' is set.

	found_string_character_position: INTEGER
			-- Position of the first character within the line of the last string.
			-- Valid only if `successful_search' is set.
	
	successful_search: BOOLEAN
			-- Was the last call to `search_string' successful?

feature -- test features

	current_line: VIEWER_LINE

	after: BOOLEAN is
		do
			Result := (current_line = Void)
		end

	forth is
		require
			not after
		do
			current_line := current_line.next
		end

	go_i_th (i: INTEGER) is
		require
			valid_i: i >= 1 and then i <= count
		do
			current_line := item (i)
		end

	start is
		require
			count >= 1
		do
			current_line := first_line
		end

feature -- Basic operations

	search_string(searched_string: STRING) is
			-- Search the text for the string `searched_string'.
			-- If the search was successful, `successful_search' is
			-- set to True and `found_string_line' & 
			-- `found_string_character_position' are set.
		local
			line_string	: STRING
			found_index : INTEGER
			line_number : INTEGER
		do
				-- Reset the success tag.
			successful_search := False

				-- Search the string...
			from
				start
				line_number := 0
			until
				found_index /= 0 or else after
			loop
				line_string := current_line.image
				if line_string.count >= searched_string.count then
					found_index := line_string.substring_index(searched_string, 1)
				end
				line_number := line_number + 1

					-- Prepare next iteration.
				forth
			end

				-- If the search was successful, set the results attributes.
			if found_index /= 0 then
				successful_search := True
				found_string_line := line_number
				found_string_character_position := found_index
			end
		end

	string_selected (start_selection: VIEWER_CURSOR; end_selection: VIEWER_CURSOR): STRING is
		require
				right_order: start_selection < end_selection
		local
			line: like current_line
			t, t2 : EDITOR_TOKEN
		do
				-- Retrieving line after `start_selection'.
			t := start_selection.token
			t2 := end_selection.token
			if t = t2 then
				if start_selection.pos_in_token = end_selection.pos_in_token then
					Result := ""
				else
					Result := t.image.substring (start_selection.pos_in_token, end_selection.pos_in_token -1)
				end
			else
				line := start_selection.line
				from
					if t = line.eol_token then
						Result := "%N"
						line := line.next
						if line = Void then
							check
								never_reached: False
							end
						else
							t := line.first_token
						end
					else
						Result := t.image.substring (start_selection.pos_in_token, t.image.count)
						t := t.next
					end
				until
					t = t2
				loop
					if t = line.eol_token then
						Result.extend ('%N')
						line := line.next
						if line = Void then
							check
								never_reached: False
							end
						else
							t := line.first_token
						end
					else
						Result.append (t.image)
						t := t.next
					end
				end
				check
					good_line: line = end_selection.line
				end
				Result.append (t2.image.substring (1, end_selection.pos_in_token -1))
			end
		end

feature -- Element Change

	prepend_line (a_line: like first_displayed_line) is
		do
			prepend_data (a_line)
		end

	append_line, extend (a_line: like first_displayed_line) is
		do
			append_data (a_line)
		end

end -- class VIEWER_CONTENT
