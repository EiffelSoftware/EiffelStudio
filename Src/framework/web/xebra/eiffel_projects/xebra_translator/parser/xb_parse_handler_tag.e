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
	ERROR_SHARED_ERROR_MANAGER


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

	handle_string (a_output_elements: LINKED_LIST [OUTPUT_ELEMENT];
	 a_string: STRING)
			-- Extracts the specified tags and handles it with process_inner.
			-- The strings around the tags are passed to the next XB_PARSE_TAG.
		local
			l_string: STRING
				-- Temp buffer for the input string
			l_start_tag_pos: INTEGER
				-- Stores where the start tag begins
			l_next_start_pos: INTEGER
				-- Used to ensure there are not two following start tags	
			l_end_tag_pos: INTEGER
				-- Stores where the end tag begins
			l_ok: BOOLEAN
				-- Is the string accepted	
		do
			l_string := a_string
			l_ok := true

			from until not (l_string.has_substring (start_tag) and l_string.has_substring (end_tag) and l_ok) loop
					-- Search for start and end pos
				l_start_tag_pos := l_string.substring_index (start_tag, 1)
				l_next_start_pos := l_string.substring_index (start_tag, l_start_tag_pos+1)
				l_end_tag_pos := l_string.substring_index (end_tag, 1)

				if (l_end_tag_pos <= l_start_tag_pos) or ((l_next_start_pos <= l_end_tag_pos) and (l_next_start_pos > 0))then
					error_manager.set_last_error (create {ERROR_LONELY_TAG}.make ([l_string]), false)
					l_ok := false
				else
						-- Hand all of the left part before the start tag over to the next parse_tag				
					if attached {XB_PARSE_HANDLER} next as n then
						n.handle_string (a_output_elements, l_string.substring (1, l_start_tag_pos-1))
					end

						-- Remove the left side
					l_string.remove_head (l_start_tag_pos + start_tag.count-1)

						-- Search for end tag
					l_end_tag_pos := l_string.substring_index (end_tag, 1)

						-- Do something meaningfull with the inner string
					process_inner (l_string.substring (1, l_end_tag_pos-1), a_output_elements)

						-- Remove inner string
					l_string.remove_head (l_end_tag_pos + end_tag.count-1)
				end
			end

			if l_ok then
				if (l_string.has_substring (start_tag) xor l_string.has_substring (end_tag) and not attached next) then
					error_manager.set_last_error (create {ERROR_LONELY_TAG}.make ([l_string]), false)
				end

				-- Hand right side of most right tag over to next parse_tag
				if (attached {XB_PARSE_HANDLER} next as n) then
					n.handle_string (a_output_elements, l_string)
				end
			end

		end

	process_inner (a_inner_string: STRING; a_output_elements: LINKED_LIST [OUTPUT_ELEMENT])
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
