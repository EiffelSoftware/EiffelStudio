note
	description: "Criterion to test if top or bottom indexing clause of a class contain certain text"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_INDEXING_CONTAIN_CRI

inherit
	QL_CLASS_INDEXING_CLAUSE_CONTAIN_CRI

create
	make,
	make_with_setting

feature -- Evaluate

	is_satisfied_by (a_item: QL_CLASS): BOOLEAN
			-- Evaluate `a_item'.
		local
			l_class_as: CLASS_AS
		do
			l_class_as := class_ast (a_item)
			if l_class_as /= Void and then match_list /= Void then
				if l_class_as.top_indexes /= Void then
					Result := indexing_clause_contain_text (l_class_as.top_indexes, match_list)
					if not Result and then l_class_as.bottom_indexes /= Void then
						Result := indexing_clause_contain_text (l_class_as.bottom_indexes, match_list)
					end
				end
			end
		end

note
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
