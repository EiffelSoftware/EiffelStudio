note
	description: "[
			See XB_PARSE_HANDLER. Extracts a string inside a tag
			and passes the rest of the string to the next XB_PARSE_HANDLER.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XB_PARSE_HANDLER_TAG

inherit
	XB_PARSE_HANDLER

feature -- Access

	start_tag: STRING
			-- The starting tag
		deferred
		ensure
			start_tag_not_empty: Result.count > 0
		end


	end_tag: STRING
			-- The ending tag
		deferred
			ensure
			start_tag_not_empty: Result.count > 0
		end

	name: STRING
			-- The name of the current parse tag
		deferred
		end


feature -- Processing

	handle_string (output_elements: LINKED_LIST [OUTPUT_ELEMENT];
	 a_string: STRING; a_start_pos: INTEGER)
			-- Extracts the specified tags and handles it with process_inner.
			-- The strings around the tags are handed over to the next XB_PARSE_TAG.
			-- The start_pos is needed to correctly fill the position integer in the
			-- elements hash map.
		local
			string: STRING
			start_tag_pos: INTEGER
			end_tag_pos: INTEGER
			cut_away: INTEGER
			outer: STRING
			inner: STRING
		do
			cut_away := 0
			string := a_string
			outer := ""
			inner := ""

		--	print ("Entering parse_tag_" + name + " --%N-- will process '" + string + "' which starts at " + a_start_pos.out + " from the orig string.%N")
			from

			until
				not (string.has_substring (start_tag) and string.has_substring (end_tag))
			loop
					-- Search for start tag
				start_tag_pos := string.substring_index (start_tag, 1)

		--		print ("-found start_tag at " + (start_tag_pos+cut_away).out + "%N")

					-- Hand all of the left part before the start tag over to the next parse_tag				
				if attached {XB_PARSE_HANDLER} next as n then
					n.handle_string (output_elements,string.substring (1, start_tag_pos-1), cut_away)
				end

					-- Remove the left side
				string.remove_head (start_tag_pos + start_tag.count-1)

					-- Search for end tag
				end_tag_pos := string.substring_index (end_tag, 1)

					-- Do something meaningfull with the inner string
				process_inner (string.substring (1, end_tag_pos-1), output_elements, start_tag_pos+a_start_pos+cut_away)
				cut_away := cut_away + start_tag_pos + start_tag.count-1


		--		print ("-found end_tag at " + (cut_away + end_tag_pos).out + "%N")

					-- Remove inner string
				string.remove_head (end_tag_pos + end_tag.count-1)
				cut_away := cut_away +end_tag_pos + end_tag.count-1
			end

				-- Hand right side of most right tag over to next parse_tag
			if attached {XB_PARSE_HANDLER} next as n then
				n.handle_string (output_elements, string, end_tag_pos+a_start_pos+cut_away)
			end
		--	print ("Parse_tag_" + name + " is done. --%N")
		end

	process_inner (an_inner_string: STRING; output_elements: LINKED_LIST [OUTPUT_ELEMENT];
			a_position: INTEGER )
			-- Knows what to do with the string inside a tag.
		deferred
		end

invariant
	tags_not_equal: not start_tag.is_equal(end_tag)


note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
