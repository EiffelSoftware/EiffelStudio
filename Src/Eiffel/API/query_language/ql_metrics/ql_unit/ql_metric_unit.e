indexing
	description: "Object that represents a unit used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_METRIC_UNIT

inherit
	QL_CONSTANT
		redefine
			name
		end

create
	make

feature{NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize `name' with `a_name'.
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			create name.make_from_string (a_name)
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
		end

feature -- Access

	name: STRING
			-- Name of current constant

	scope: QL_SCOPE
			-- Scope associated with current unit

feature -- Status report

	is_scope_unit: BOOLEAN is
			-- Is current scope related to a scope directly?
			-- This is necessary in metrics calculation.
			-- If a unit is related to a scope, you can specify a criterion to it, such as in the following query:
			--
			-- 		select class where (count feature from current_class where is_immediate) > 100
			--
			-- This query will give you all the classes whose number of immediate feature is larger than 100.
			-- Here, "count feature from current_class where is_immediate" is a metric definition.
			-- and "feature" here is a unit, and further, it's a unit with a scope, which is feature scope.
			-- So we can attach a criterion "is_immediate" to it.
			-- A different exmple is compilation unit. It tells you the number of compilation in current target.
			-- It's a unit with no scope, so we can't attach any criterion to it.
		do
			Result := scope /= Void
		ensure
			good_result: Result implies (scope /= Void)
		end

feature -- Setting

	set_scope (a_scope: like scope) is
			-- Set `scope' with `a_scope'.
		require
			a_scope_attached: a_scope /= Void
		do
			scope := a_scope
		ensure
			scope_set: scope = a_scope
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
