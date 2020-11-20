note
	description: "Keeper for non-void entity scopes with a limited range of variable indicies."
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

	is_attached (index: like count): BOOLEAN
			-- Is a variable with the given `index' is not void?
		do
			Result := scope.bit_test (index - 1)
		end

	has_unset: BOOLEAN
			-- <Precursor>
		do
			Result := ({NATURAL_64} 1) ⧀ count - 1 + {NATURAL_64} 0x8000_0000_0000_0000 /= scope
		end

	has_unset_index (min_index, max_index: like count): BOOLEAN
			-- <Precursor>
		local
			mask: like scope
		do
			mask := mask.one ⧀ max_index - 1 - (mask.one ⧀ (min_index - 1) - 1)
			Result := scope ⊗ mask /= mask
		end

feature -- Status report: variables

	max_count: INTEGER = 63
			-- Maximum value of `count`.
			--| One bit is reserved to indicate a non-empty stack element.

feature {NONE} -- Status report

	is_dominating: BOOLEAN
			-- <Precursor>
		local
			s: like scope
		do
			s := inner_scopes.item
			Result := (s ⊗ scope) = s
		end

feature -- Modification: variables

	start_scope (index: like count)
			-- Mark that a local with the given `index' is not void.
		do
			scope := scope ⦶ (({NATURAL_64} 1) ⧀ (index - 1))
		end

	stop_scope (index: like count)
			-- Mark that a local with the given `index' can be void.
		do
			scope := scope ⊗ (({NATURAL_64} 1) ⧀ (index - 1)).bit_not
		end

	set_all
			-- Mark that all variables are not void.
		do
			scope := ({NATURAL_64} 1) ⧀ count - 1 + 0x8000_0000_0000_0000
		end

feature {NONE} -- Modification: nesting

	merge_siblings
			-- Merge sibling scope information from `scope'
			-- into `inner_scopes.item'.
		do
			inner_scopes.replace (inner_scopes.item & scope)
		end

feature {NONE} -- Initialization

	new_scope (n: like count): like scope
		do
			Result := {NATURAL_64} 0x8000_0000_0000_0000
		end

feature {NONE} -- Duplication

	duplicate (s: like scope): like scope
		do
			Result := s
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
