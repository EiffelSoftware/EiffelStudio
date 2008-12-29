note
	description: "[
					Regular expression utility to find text blocks in eweasel output.
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_OUTPUT_REGULAR_EXPRESSION_FINDER

feature -- Query

	one_result_block (a_string: STRING): TUPLE [STRING_GENERAL, INTEGER]
			-- Text block between two "Test " tag. Void if not found.
		require
			not_void: a_string /= Void
		do
			Result := find_expression ("\n?Test\s(.*?)\nTest\s", a_string)
		end

	class_name_in (a_string: STRING): STRING_GENERAL
			-- Class name in frist line of eweasel output
			-- Result void if not found
		require
			not_void: a_string /= Void
		local
			l_first_blank_index: INTEGER
		do
			if a_string.count > 1 then
				l_first_blank_index := a_string.substring_index (" ", 1)
				check not_the_first: l_first_blank_index /= 1 end
				Result := a_string.substring (1, l_first_blank_index - 1)
				Result := Result.as_string_32.as_upper
				check class_name_right: (create {EIFFEL_SYNTAX_CHECKER}).is_valid_class_name (Result.as_string_8) end
			end
		end

feature {NONE} -- Implementation

	find_expression (a_pattern: STRING_GENERAL; a_source: STRING_GENERAL): TUPLE [a_result_string: STRING_GENERAL; a_result_index: INTEGER]
			-- Use Gobo regular expression to find `a_pattern' in `a_source'
			-- FIXIT: Copy from {COMM_SUPPORT_ACCESS}, merge?
			-- Note, this feature only match the first item.
			-- It means, in the remaing `a_source' maybe there are other matched items.
		require
			a_pattern_attached: a_pattern /= Void
			not_a_pattern_is_empty: not a_pattern.is_empty
			a_source_attached: a_source /= Void
		local
			l_matcher: RX_PCRE_MATCHER
		do
			create l_matcher.make
			l_matcher.set_dotall (True)
			l_matcher.compile (a_pattern.as_string_8)
			l_matcher.match (a_source.as_string_8)

			if l_matcher.has_matched then
				Result := [l_matcher.captured_substring (1), l_matcher.captured_end_position (1)]
			end
		end
note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
