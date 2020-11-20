note
	description: "Keeper for non-void entity scopes with an unlimited range of variable indicies."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class AST_UNBOUNDED_SCOPE_KEEPER

inherit
	AST_STACKED_SCOPE_KEEPER [ARRAY [BOOLEAN]]

create
	make

feature -- Access

	is_attached (index: like count): BOOLEAN
			-- Is a variable with the given `index` is not void?
		do
			Result := scope [index]
		end

	has_unset: BOOLEAN
			-- <Precursor>
		do
			Result := has_unset_index (scope.lower, scope.upper)
		end

	has_unset_index (min_index, max_index: like count): BOOLEAN
			-- <Precursor>
		local
			index: like count
		do
			from
				index := min_index
			until
				index > max_index
			loop
				if not scope [index] then
					Result := True
					index := max_index
				end
				index := index + 1
			end
		end

feature -- Status report: variables

	max_count: INTEGER
			-- Maximum value of `count`.
		do
			Result := {like count}.max_value
		end

feature {NONE} -- Status report

	is_dominating: BOOLEAN
			-- <Precursor>
		local
			s: like scope
			i: like count
		do
			s := inner_scopes.item
			if s /= scope then
				from
					i := count
				until
					i > 0 ⇒ s [i] ∧ ¬ scope [i]
				loop
					i := i - 1
				end
			end
			Result := i ≤ 0
		end

feature -- Modification: variables

	start_scope (index: like count)
			-- Mark that a variable with the given `index` is not void.
		do
			scope [index] := True
		end

	stop_scope (index: like count)
			-- Mark that a local with the given `position` can be void.
		do
			scope [index] := False
		end

	set_all
			-- Mark that all variables are not void.
		do
			scope.fill_with (True)
		end

feature {NONE} -- Modification: nesting

	merge_siblings
			-- Merge sibling scope information from `scope`.
			-- into `inner_scopes.item'.
		local
			s: like scope
			i: like count
		do
			s := inner_scopes.item
			if s /= scope then
				from
					i := count
				until
					i ≤ 0
				loop
						-- Mark only items that are set in both scopes.
					s [i] := s [i] ∧ scope [i]
					i := i - 1
				end
			end
		end

feature {NONE} -- Initialization

	new_scope (n: like count): like scope
		do
			create Result.make_filled (False, 1, n)
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
