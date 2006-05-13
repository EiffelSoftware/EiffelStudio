indexing
	description: "Line criterion to decide whether or not a line contains some kind of comments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_LINE_IS_COMMENT_CRI

inherit
	QL_LINE_CRITERION

feature -- Evaluate

	is_satisfied_by (a_item: QL_LINE): BOOLEAN is
			-- Evaluate `a_item'.
		local
			l_text: STRING
			l_pos: INTEGER
			l_cnt: INTEGER
			l_char: CHARACTER
			done: BOOLEAN
		do
			l_text := a_item.text
			l_cnt := l_text.count

			if l_cnt > 2 then
				from
					Result := False
					l_pos := 1
				until
					l_pos > l_cnt or Result or done
				loop
					l_char := l_text.item (l_pos)
					if l_char.is_space then
						l_pos := l_pos + 1
					elseif l_char = '-' and then l_pos < l_cnt and then l_text.item (l_pos + 1) = '-' then
						Result := True
						done := True
					else
						done := True
					end
				end
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


end
