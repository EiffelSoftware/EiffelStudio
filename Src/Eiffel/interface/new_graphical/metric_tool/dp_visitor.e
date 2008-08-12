indexing
	description: "Visitor Pattern"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DP_VISITOR [G]

inherit
	DP_HELPER
		redefine
			default_create
		end

feature{NONE} -- Initialization

	default_create is
			-- Initialize Current.
		do
			create action_type_table.make (initial_capacity)
			create sorter.make (initial_capacity)
			create actions.make (initial_capacity)
			create expanded_items.make
			create cache.make (initial_capacity)
			catch_all_agent := agent catch_all
		end

feature -- Status report

	has_action (a_action: PROCEDURE [ANY, TUPLE [G]]): BOOLEAN is
			-- Does Current visitor has `a_action'?
		require
			a_action_attached: a_action /= Void
		do
			Result := action_type_table.has_item (a_action) or else expanded_items.has (a_action)
		end

feature -- Visit

	visit (a_item: G) is
			-- Visitor `a_item'.
		require
			a_item_attached: a_item /= Void
		local
			l_args: TUPLE [G]
			l_dynamic_type: INTEGER
			l_actions: like actions
			l_action: PROCEDURE [ANY, TUPLE [G]]
			l_cursor: DS_ARRAYED_LIST_CURSOR [PROCEDURE [ANY, TUPLE [G]]]
			l_internal: INTERNAL
			done: BOOLEAN
		do
			l_args := [a_item]
			create l_internal
			l_dynamic_type := l_internal.dynamic_type (a_item)
			if cache.has (l_dynamic_type) then
				cache.item (l_dynamic_type).call (l_args)
			else
				l_actions := actions
				l_cursor := actions.new_cursor
				from
					l_cursor.finish
				until
					l_cursor.before or done
				loop
					l_action := l_cursor.item
					if l_action.valid_operands (l_args) then
						cache.put (l_action, l_dynamic_type)
						l_action.call (l_args)
						done := True
						l_cursor.go_before
					end
					l_cursor.back
				end
				check gobo_cursor_cleaned_up: l_cursor.off end
				if not done then
					cache.put (catch_all_agent, l_dynamic_type)
					catch_all_agent.call (l_args)
				end
			end
		end

feature -- Action registeration

	extend (a_action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Extend `a_action' for processing type {G} into Current visitor.
			-- If another action which processes type {G} already exists, it will be overwritten by the new one.
		require
			a_action_attached: a_action /= Void
			a_action_valid: a_action.open_count = 1
			not_has_action: not has_action (a_action)
		do
			prepare_topological_sort (a_action)
			topological_sort
			fill_cache
		ensure
			action_extended: has_action (a_action)
		end

	append (a_actions: ARRAY [PROCEDURE [ANY, TUPLE [G]]]) is
			-- Append actions in `a_actions' to the end of the `actions' list.
			-- If another action which processes type {G} already exists, it will be overwritten by the new one.
		require
			a_actions_attached: a_actions /= Void
			no_void_action: not a_actions.has (Void)
			actions_not_exist: not a_actions.there_exists (agent has_action)
		do
			a_actions.do_all (agent prepare_topological_sort)
			topological_sort
			fill_cache
		ensure
			actions_appended: a_actions.for_all (agent has_action)
		end

feature{NONE} -- Implementation

	action_type_table: HASH_TABLE [PROCEDURE [ANY, TUPLE [G]], INTEGER]
			-- Type id table indexed by agent.
			-- Type id is the dynamic type id of the generic parameter in that agent.

	sorter: DS_TOPOLOGICAL_SORTER [PROCEDURE [ANY, TUPLE [G]]]
			-- Sorter used to sort registered agents according to their dynamic type

	actions: DS_ARRAYED_LIST [PROCEDURE [ANY, TUPLE [G]]]
			-- List of agents which are used when visiting

	expanded_items: DS_LINKED_LIST [PROCEDURE [ANY, TUPLE [G]]]
			-- Actions applied to expanded types

	cache: like action_type_table
			-- Cache used to enhance performance of agent look up

	initial_capacity: INTEGER is 10
			-- Initial capacity of `action_type_table', `sorter'

	catch_all_agent: PROCEDURE [ANY, TUPLE [G]]
			-- Agent on `catch_all'

feature{NONE} -- Implementation

	prepare_topological_sort (a_action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Prepare topological sort for `a_action'.
		require
			a_action_attached: a_action /= Void
			a_action_valid: a_action.open_count = 1
		local
			l_type_id: INTEGER
			l_item_type_id: INTEGER
			l_arg_type_code: INTEGER
			l_type_code_str: STRING
			l_internal: INTERNAL
			l_type_ids: like action_type_table
		do
			l_type_code_str := eif_gen_typecode_str ($a_action)
			l_arg_type_code := l_type_code_str.item (2).code

			if l_arg_type_code /= {TUPLE}.reference_code then
				expanded_items.force_last (a_action)
			elseif l_arg_type_code = {TUPLE}.reference_code then
					-- Retrieve type information.				
				create l_internal
				l_type_id := l_internal.generic_dynamic_type_of_type (l_internal.generic_dynamic_type (a_action, 2), 1)
				sorter.force (a_action)
				l_type_ids := action_type_table

					-- Setup topological relation between agents.
				from
					l_type_ids.start
				until
					l_type_ids.after
				loop
					l_item_type_id := l_type_ids.key_for_iteration
					if l_internal.type_conforms_to (l_type_id, l_item_type_id) then
						sorter.put_relation (l_type_ids.item_for_iteration, a_action)
					elseif l_internal.type_conforms_to (l_item_type_id, l_type_id) then
						sorter.put_relation (a_action, l_type_ids.item_for_iteration)
					end
					l_type_ids.forth
				end
				l_type_ids.force (a_action, l_type_id)
			end
		end

	topological_sort is
			-- Perform the topological sort.
		do
			sorter.sort
			check not sorter.has_cycle end
			actions := sorter.sorted_items

				-- Add action applied to an expanded type if any.
			from expanded_items.start until expanded_items.after loop
				actions.force_last (expanded_items.item_for_iteration)
				expanded_items.forth
			end
		end

	fill_cache is
			-- Fill `cache'.
		do
			cache.wipe_out
			cache := action_type_table.twin
		ensure
			cache_filled: cache.count = action_type_table.count
		end

	catch_all (a_item: G) is
			-- Routine called when no action is found for `a_item'
		require
			a_item_attached: a_item /= Void
		do
		end

invariant
	type_ids_attached: action_type_table /= Void
	sorter_attached: sorter /= Void
	actions_attached: actions /= Void
	expanded_items_attached: expanded_items /= Void
	cache_attached: cache /= Void
	catch_all_agent_attached: catch_all_agent /= Void

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
