indexing
	description: "Parses a code snippet"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SNIPPET_ANALYZER

inherit
	CODE_SHARED_CONTEXT
		export
			{NONE} all
		end

feature -- Basic Operations

	parse (a_snippet: STRING) is
			-- Parse `a_snippet' and set queries accordingly.
		require
			attached_snippet: a_snippet /= Void
		local
			l_text, l_tag, l_desc: STRING
			l_in_tag, l_in_quote: BOOLEAN
			i: INTEGER
			l_clause: CODE_INDEXING_CLAUSE
			c: CHARACTER
		do
			indexing_clauses := Void
			is_indexing_clause := False
			is_inheritance_clause := False
			l_text := a_snippet.twin
			if l_text.as_lower.substring (1, 7).is_equal ("inherit") and not l_text.item (8).is_alpha_numeric and not (l_text.item (8) = '_') then
				is_inheritance_clause := True
			elseif l_text.as_lower.substring (1, 8).is_equal ("indexing") and not l_text.item (9).is_alpha_numeric and not (l_text.item (9) = '_') then
				create {ARRAYED_LIST [CODE_INDEXING_CLAUSE]} indexing_clauses.make (10)
				is_indexing_clause := True
				l_text.keep_tail (l_text.count - 9)
				from
					i := 1
					l_in_tag := True
					create l_tag.make (50)
				until
					i > l_text.count
				loop
					c := l_text.item (i)
					if l_in_tag  then
						if c.is_alpha_numeric or c='_' then
							l_tag.append_character (c)
						elseif c = ':' then
							l_in_tag := False
							create l_desc.make (100)
						end
					else
						if l_in_quote then
							if c = '"' and l_text.item (i - 1) /= '%%' then
								if l_tag.as_lower.is_equal ("precompile_definition_file") then
									Compilation_context.set_precompile_file (l_desc)
								end
								l_in_quote := false
								l_in_tag := true
								create l_clause.make
								l_clause.set_tag (l_tag)
								l_clause.set_text (l_desc)
								indexing_clauses.extend (l_clause)
								create l_tag.make (50)
							else
								l_desc.append_character (c)
							end
						else
							l_in_quote := c = '"' and l_text.item (i - 1) /= '%%'
						end
					end
					i := i + 1
				end
			end
		end
		
feature -- Access

	is_indexing_clause: BOOLEAN
			-- Was last snippet parsed with `parse' an indexing clause?
	
	is_inheritance_clause: BOOLEAN
			-- Was last snippet parsed with `parse' an inheritance clause?

	indexing_clauses: LIST [CODE_INDEXING_CLAUSE]
			-- Indexing clause last parsed with `parse'
			-- `Void' if last snippet parsed with `parse' wasn't an indexing clause
	
invariant
	valid_indexing_clause: (indexing_clauses /= Void) = is_indexing_clause

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

end -- class CODE_SNIPPET_ANALYZER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------