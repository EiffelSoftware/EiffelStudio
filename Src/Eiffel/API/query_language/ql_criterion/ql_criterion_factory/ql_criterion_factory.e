indexing
	description: "Factory to produce criteria"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CRITERION_FACTORY

inherit
	QL_SHARED_NAMES

feature{NONE} -- Initialization

	initialize is
			-- Initialize.
		deferred
		ensure
			criterion_table_attached: criterion_table /= Void
		end

feature -- Criterion creation

	criterion (a_name: STRING; a_argu: TUPLE): QL_CRITERION is
			-- Criterion with `a_name' as `a_argu' as its initialization arguments
			-- Void if no criterion with `a_name' is applicable with respect to current scope
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		deferred
		end

feature{NONE} -- Implementation

	creation_function: FUNCTION [ANY, TUPLE, QL_CRITERION]
			-- Creation function type anchor

	criterion_table: HASH_TABLE [like creation_function, STRING]
			-- Hashtable to store criterion creation agents

invariant
	criterion_table_attached: criterion_table /= Void

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
