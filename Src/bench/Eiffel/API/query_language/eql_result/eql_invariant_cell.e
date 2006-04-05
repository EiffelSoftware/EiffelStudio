indexing
	description: "Object that represents an invariant ast node used in EQL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_INVARIANT_CELL

inherit
	SHARED_EIFFEL_PROJECT

feature{NONE} -- Initialization

	make_with_invariant (a_invariant: like invariant_part) is
			-- Initialize `invariant_part' with `a_invariant'.
		require
			a_invariant_not_void: a_invariant /= Void
		do
			set_invariant_part (a_invariant)
		end

feature -- Status reporting

	is_invariant_part_set: BOOLEAN is
			-- Is `invariant_part' set?
		do
			Result := invariant_part /= Void
		end

feature -- Access

	invariant_part: INVARIANT_AS
			-- Invariant ast

	associated_class: CLASS_C is
			-- Class associated with `invariant_part'
		require
			invariant_part_not_void: invariant_part /= Void
		do
			Result := eiffel_system.class_of_id (invariant_part.class_id)
		ensure
			result_not_void: result /= Void
		end

feature -- Setting

	set_invariant_part (a_ast: like invariant_part) is
			-- Set `invariant_part' with `a_ast'.
		do
			invariant_part := a_ast
		ensure
			invariant_part_set: invariant_part = a_ast
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
