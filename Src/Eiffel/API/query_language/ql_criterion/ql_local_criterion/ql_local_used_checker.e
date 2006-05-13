indexing
	description: "Visitor to check if a given local is not used"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_LOCAL_USED_CHECKER

inherit
	AST_ITERATOR
		export
			{NONE}all
		redefine
			process_access_id_as,
			process_address_as
		end

feature -- Status report

	last_local_name: STRING
			-- name of last set local variable

	last_is_used: BOOLEAN
			-- Is `last_local_name' used ?

feature -- Process

	process_ast (a_ast: AST_EIFFEL; a_local_name: STRING) is
			-- Process `a_ast'.			
		require
			a_ast_attached: a_ast /= Void
			a_local_name_attached: a_local_name /= Void
		do
			last_local_name := a_local_name.out
			last_is_used := False
			a_ast.process (Current)
		end

feature{NONE} -- Access

	process_access_id_as (l_as: ACCESS_ID_AS) is
			-- Process `l_as'.
		do
			if not last_is_used then
				check last_local_name /= Void end
				last_is_used := l_as.access_name.is_case_insensitive_equal (last_local_name)
			end
		end

	process_address_as (l_as: ADDRESS_AS) is
			-- Process `l_as'.
		do
			if not last_is_used then
				check last_local_name /= Void end
				last_is_used := last_local_name.is_case_insensitive_equal (l_as.feature_name.internal_name)
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
