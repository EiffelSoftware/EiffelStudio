indexing
	description: "Keeper for non-void entity scopes with an unlimited range of variable positions."
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

	is_local_attached (position: like local_count): BOOLEAN
			-- Is a local with the given `position' is not void?
		do
			Result := scope [position]
		end

	is_result_attached: BOOLEAN
		do
			Result := scope [0]
		end

feature -- Status report: variables

	max_local_count: INTEGER
			-- Maximum value of `local_count'
		do
			Result := {INTEGER}.max_value
		end

feature -- Modification: variables

	start_local_scope (position: like local_count)
			-- Mark that a local with the given `position' is not void.
		do
			scope [position] := True
		end

	start_result_scope
			-- Mark that "Result" is not void.
		do
			scope [0] := True
		end

	stop_local_scope (position: like local_count)
			-- Mark that a local with the given `position' can be void.
		do
			scope [position] := False
		end

	stop_result_scope
			-- Mark that "Result" can be void.
		do
			scope [0] := False
		end

feature {NONE} -- Modification: nesting

	merge_siblings
			-- Merge sibling scope information from `scope'
			-- into `inner_scopes.item'.
		local
			s: like scope
			i: INTEGER
		do
			s := inner_scopes.item
			if s /= scope then
				from
					i := local_count
				until
					i < 0
				loop
						-- Mark only items that are set in both scopes
					s [i] := s [i] and scope [i]
					i := i - 1
				end
			end
		end

feature {NONE} -- Initialization

	new_scope (n: like local_count): like scope
		do
				-- "Result" status is kept at index 0.
			create Result.make (0, n)
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
