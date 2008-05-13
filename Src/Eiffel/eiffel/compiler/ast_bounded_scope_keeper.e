indexing
	description: "Keeper for non-void entity scopes with a limited range of variable positions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class AST_BOUNDED_SCOPE_KEEPER

inherit
	AST_STACKED_SCOPE_KEEPER [NATURAL_64]
		redefine
			duplicate
		end

create
	make

feature -- Access

	is_local_attached (position: like local_count): BOOLEAN
			-- Is a local with the given `position' is not void?
		do
			Result := scope.bit_test (position)
		end

	is_result_attached: BOOLEAN
		do
			Result := scope.bit_test (0)
		end

feature -- Status report: variables

	max_local_count: INTEGER = 62
			-- Maximum value of `local_count'
			--| One bit is reserved for result,
			--| one bit is reserved to indicate a non-empty stack element

feature -- Modification: variables

	start_local_scope (position: like local_count)
			-- Mark that a local with the given `position' is not void.
		do
			scope := scope | (({NATURAL_64} 1) |<< position)
		end

	start_result_scope
			-- Mark that "Result" is not void.
		do
			scope := scope | {NATURAL_64} 1
		end

	stop_local_scope (position: like local_count)
			-- Mark that a local with the given `position' can be void.
		do
			scope := scope & (({NATURAL_64} 1) |<< position).bit_not
		end

	stop_result_scope
			-- Mark that "Result" can be void.
		do
			scope := scope & {NATURAL_64} 0xFFFFFFFFFFFFFFFE
		end

feature {NONE} -- Modification: nesting

	merge_siblings
			-- Merge sibling scope information from `scope'
			-- into `inner_scopes.item'.
		do
			inner_scopes.replace (inner_scopes.item & scope)
		end

feature {NONE} -- Initialization

	new_scope (n: like local_count): like scope
		do
			Result := {NATURAL_64} 0x8000000000000000
		end

feature {NONE} -- Duplication

	duplicate (s: like scope): like scope
		do
			Result := s
		end

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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
