indexing
	description: "Keeper for non-void entity scopes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class AST_SCOPE_KEEPER

create
	make

feature {NONE} -- Creation

	make (n: like local_count)
			-- Create storage to keep at least `n' locals.
		do
				-- "Result" status is kept at index 0.
			create scope.make (0, n)
			create {ARRAYED_STACK [like scope]} outer_scopes.make (1)
			create {ARRAYED_STACK [like scope]} inner_scopes.make (1)
			local_count := n
		end

feature -- Access

	is_local_attached (position: like local_count): BOOLEAN
			-- Is a local with the given `position' is not void?
		require
			position_large_enough: position > 0
			position_small_emough: position <= local_count
		do
			Result := scope [position]
		end

	is_result_attached: BOOLEAN
		do
			Result := scope [0]
		end

feature -- Status report: variables

	local_count: INTEGER
			-- Maximum number of locals that can be registered

feature -- Modification: variables

	start_local_scope (position: like local_count)
			-- Mark that a local with the given `position' is not void.
		require
			position_large_enough: position > 0
			position_small_emough: position <= local_count
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
		require
			position_large_enough: position > 0
			position_small_emough: position <= local_count
		do
			scope [position] := False
		end

	stop_result_scope
			-- Mark that "Result" can be void.
		do
			scope [0] := False
		end

feature -- Status report: nesting

	nesting_level: INTEGER
			-- Current nesting level of a compound
		do
			Result := outer_scopes.count
		end

feature -- Modification: nesting

	enter_realm
			-- Enter a new complex instruction
			-- with inner compound parts.
		do
				-- Record current scope information.
			outer_scopes.extend (scope)
				-- Start new scope from the state of an outer one.
			scope := scope.twin
				-- Reserve stack for sibling information.
			inner_scopes.extend (Void)
		ensure
			is_nesting_level_incremented: nesting_level = old nesting_level + 1
		end

	update_realm
			-- Update realm scope information
			-- from the current state.
		do
			outer_scopes.replace (scope.twin)
		end

	save_sibling
			-- Save scope information of a sibling
			-- in a complex instrution.
			-- For example, Then_part of Elseif condition.
		require
			is_nested: nesting_level > 0
		do
			if has_siblings then
					-- Merge sibling scope information.
				merge_siblings
			else
					-- Record new sibling scope information.
				inner_scopes.replace (scope.twin)
			end
				-- Start new scope from the state of an outer one.
			scope := outer_scopes.item.twin
		ensure
			is_nesting_level_preserved: nesting_level = old nesting_level
		end

	leave_realm
			-- Leave a complex instruction and
			-- promote scope information to the outer compound.
		require
			is_nested: nesting_level > 0
		do
			if has_siblings then
					-- Promote nested scope information to the outer level.
				scope := inner_scopes.item
			end
				-- Remove inner scope information.
			inner_scopes.remove
				-- Remove outer scope information and use the latest one.
			outer_scopes.remove
		ensure
			is_nesting_level_decremented: nesting_level = old nesting_level - 1
		end

	leave_optional_realm
			-- Leave a complex instruction and
			-- discard its scope information.
			-- For example, Debug instruction.
		require
			is_nested: nesting_level > 0
		do
				-- Remove inner scope information.
			inner_scopes.remove
				-- Restore original scope information.
			scope := outer_scopes.item
				-- Remove outer scope information.
			outer_scopes.remove
		ensure
			is_nesting_level_decremented: nesting_level = old nesting_level - 1
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

feature {NONE} -- Status report

	has_siblings: BOOLEAN
			-- Are there any siblings in the current instruction?
		do
			Result := inner_scopes.item /= Void
		end

feature {NONE} -- Storage

	scope: ARRAY [BOOLEAN]
			-- Current void-safe status of a local
			-- with True indicating non-void value and
			-- False indicating possibly void value

	outer_scopes: STACK [like scope]
			-- Outer scopes

	inner_scopes: STACK [like scope]
			-- Inner scopes

invariant

	scope_attached: scope /= Void
	outer_scopes_attached: outer_scopes /= Void
	inner_scopes_attached: inner_scopes /= Void
	same_level: outer_scopes.count = inner_scopes.count

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
