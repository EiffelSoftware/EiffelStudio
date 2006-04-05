indexing
	description: "Object that represents an EQL result cell for an Eiffel system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_SYSTEM_CELL

feature{NONE} -- Initialization

	make_with_system_i (a_system_i: like system_i) is
			-- Initialize `system_i' with `a_system_i'.
		do
			system_i := a_system_i
		ensure
			system_i_set: system_i = a_system_i
		end

feature -- Status reporting

	is_system_i_set: BOOLEAN is
			-- Is `system_i' set?
		do
			Result := system_i /= Void
		ensure
			good_result: Result implies system_i /= Void
		end

feature -- Access

	system_i: SYSTEM_I
			-- System in current context

feature -- Setting

	set_system_i (st: SYSTEM_I) is
			-- Assign `st' to `system_i'.
		do
			system_i := st
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
