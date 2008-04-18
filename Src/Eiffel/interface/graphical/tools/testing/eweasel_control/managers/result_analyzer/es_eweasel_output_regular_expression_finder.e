indexing
	description: "[
					Regular expression utility to find text blocks in eWeasel output.
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

	class_name_in (a_string: STRING): STRING_GENERAL is
			-- Class name in frist line of eWeasel output which surrounded by "[]"
			-- Result void if not found
		require
			not_void: a_string /= Void
		local
			l_tmp: like find_expression
		do
			l_tmp := find_expression ("\[([a-zA-Z][a-zA-Z0-9_]*)\]", a_string)
			if l_tmp /= Void then
				Result := l_tmp.a_result_string
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
indexing
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
