note
	description: "Criterion to test if indexing clause of a class has an indexing with a given tag"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CLASS_INDEXING_CLAUSE_HAS_TAG_CRI

inherit
	QL_CLASS_INDEXING_CRI
		rename
			name as tag
		end

feature{NONE} -- Implementation

	indexing_clause_has_tag (a_indexing_clause: INDEXING_CLAUSE_AS): BOOLEAN
			-- Does `a_indexing_clause' contain a tag named `tag'?
		require
			a_indexing_clause_attached: a_indexing_clause /= Void
		local
			l_tag: ID_AS
		do
			if not a_indexing_clause.is_empty then
				from
					a_indexing_clause.start
				until
					a_indexing_clause.after or Result
				loop
					l_tag := a_indexing_clause.item.tag
					if l_tag /= Void then
						Result := is_name_same_as (l_tag.name)
					end
					a_indexing_clause.forth
				end
			end
		end

	roundtrip_pure_eiffel_parser: EIFFEL_PARSER
			-- Pure Eiffel parser
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_LIGHT_FACTORY})
		end

	roundtrip_il_eiffel_parser: EIFFEL_PARSER
			-- IL Eiffel parser.
		once
			create Result.make_with_factory (create {AST_ROUNDTRIP_LIGHT_FACTORY})
			Result.set_il_parser
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
