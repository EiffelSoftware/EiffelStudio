note
	description: "[
		Splits an input stream into two parts: a xml only text and a list of tags
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XB_PREPROCESSOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			output_call_parse: XB_PARSE_HANDLER_TAG_OUTPUT_CALL
			call_parse: XB_PARSE_HANDLER_TAG_CALL
			html_parse: XB_PARSE_HANDLER_HTML

		do
			create output_call_parse.make
			create call_parse.make
			create html_parse.make

			first_parse_handler := output_call_parse
			output_call_parse.set_next (call_parse)
			call_parse.set_next (html_parse)
		end


feature -- Access

	first_parse_handler: XB_PARSE_HANDLER


feature -- Features yet to be named

	sort_elements (output_elements_unsorted: DS_HASH_TABLE [OUTPUT_ELEMENT, INTEGER]): LINKED_LIST[OUTPUT_ELEMENT]
			-- sorts elements from a hashmap according to an integer and puts them into a list
		local
			sorter: DS_ARRAY_QUICK_SORTER [INTEGER]
			keys: ARRAY [INTEGER]
			i: INTEGER
		do
			create {LINKED_LIST[OUTPUT_ELEMENT]}Result.make
			create sorter.make (create {KL_COMPARABLE_COMPARATOR [INTEGER]}.make)

			keys := output_elements_unsorted.keys.to_array

			sorter.sort (keys)

			from
				i := 1
			until
				i > keys.count
			loop
				Result.put_right ( output_elements_unsorted.item (keys.item (i)))
				i := i + 1
			end
		end


	debug_dontsort (output_elements_unsorted: DS_HASH_TABLE [OUTPUT_ELEMENT, INTEGER]): LIST[OUTPUT_ELEMENT]
			--test
		local
			ll: LINKED_LIST[OUTPUT_ELEMENT]
		do

			create ll.make

			from
				output_elements_unsorted.start
			until
				output_elements_unsorted.after
			loop
				ll.put_right (output_elements_unsorted.item_for_iteration)
				output_elements_unsorted.forth
			end
			Result := ll
		end

	parse_string (a_string: STRING): LIST[OUTPUT_ELEMENT]
			-- parses string with the list of parse tags.
		require
		local
		--	temp_string: STRING
			output_elements_unsorted: DS_HASH_TABLE [OUTPUT_ELEMENT, INTEGER]
		do
			create output_elements_unsorted.make_map_default

			first_parse_handler.handle_string (output_elements_unsorted, a_string, 0)

		--	Result := sort_elements (output_elements_unsorted)
			Result := debug_dontsort (output_elements_unsorted)


			--delegate string parsing to registered parse_tags
--			from
--				parse_tags.start
--				temp_string := a_string
--			until
--				parse_tags.after
--			loop
--				temp_string := parse_tags.item.parse_string (output_elements_unsorted, temp_string)
--				parse_tags.forth
--			end




		--	Result := sort_elements (output_elements_unsorted)

		end
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
