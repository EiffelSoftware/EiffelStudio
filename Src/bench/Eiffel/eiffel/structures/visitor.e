indexing

	description:

		"Visitor"
	legal: "See notice at end of class."
	status: "See notice at end of class."

	library: "Visitor library"
	author: "Karine Arnout"
	copyright: "Copyright (c) 2002-2004, ETH Zurich, Switzerland"
	license: "Eiffel Forum License v2 (see License.txt)"
	date: "$Date$"
	revision: "$Revision$"

class VISITOR [reference G]

create

	make

feature {NONE} -- Initialization

	make is
			-- Initialize `actions'.
		do
			create actions.make (Initial_capacity)
			create sorter.make (Initial_capacity)
			create type_ids.make (Initial_capacity)
			create expanded_items.make
			create actions_cache.make (1, Initial_capacity)
			catch_all_agent := agent catch_all
		end

feature -- Visitor

	visit (an_element: G) is
			-- Visit `an_element'. (Select the appropriate action
			-- depending on `an_element'.)
		require
			an_element_not_void: an_element /= Void
		local
			type_id: INTEGER
			l_args: like arguments
			l_actions_cache: like actions_cache
			l_actions: like actions
			i: INTEGER 
		do
			l_args := arguments
			l_args.put (an_element, 1)

			l_actions_cache := actions_cache
			l_actions := actions

			type_id := {ISE_RUNTIME}.dynamic_type ($an_element)

			if l_actions_cache.valid_index (type_id) and then l_actions_cache.item (type_id) /= Void then
				l_actions_cache.item (type_id).call (l_args)
			else
				from
					i := l_actions.count
				until
					i < 1 or else l_actions.item (i).valid_operands (l_args)
				loop
					i := i - 1
				end

				if i >= 1 and i <= l_actions.count then
					l_actions.item (i).call (l_args)
					l_actions_cache.force (l_actions.item (i), type_id)
				else
					catch_all (an_element)
					l_actions_cache.force (catch_all_agent, type_id)
				end
			end
		end

feature -- Access

	actions: DS_ARRAYED_LIST [PROCEDURE [ANY, TUPLE [G]]]
			-- Actions to be performed depending on the element

feature -- Element change

	extend (an_action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Extend `actions' with `an_action'.
		require
			an_action_not_void: an_action /= Void
		do
			prepare_topological_sort (an_action)
			topological_sort
			fill_cache
		ensure
			has_an_action: actions.has (an_action)
		end

	append (some_actions: ARRAY [PROCEDURE [ANY, TUPLE [G]]]) is
			-- Append actions in `some_actions' to the end of the `actions' list.
		require
			some_actions_not_void: some_actions /= Void
			no_void_action: not some_actions.has (Void)
		local
			i: INTEGER
		do
			from i := some_actions.lower until i > some_actions.upper loop
				prepare_topological_sort (some_actions.item (i))
				i := i + 1
			end
			topological_sort
			fill_cache
		end

feature {NONE} -- Implementation (Access)

	sorter: DS_HASH_TOPOLOGICAL_SORTER [PROCEDURE [ANY, TUPLE [G]]]
			-- Topological sorter;
			-- The relation used for topological sort is the conformance
			-- of the dynamic type of the agent operands

	type_ids: DS_HASH_TABLE [INTEGER, PROCEDURE [ANY, TUPLE [G]]]
			-- Hash table of type ids indexed by actions

	expanded_items: DS_LINKED_LIST [PROCEDURE [ANY, TUPLE [G]]]
			-- Actions applied to expanded types

	actions_cache: ARRAY [PROCEDURE [ANY, TUPLE [G]]]
			-- Cache with actions indexed by type id

feature {NONE} -- Implementation (Constants)

	Initial_capacity: INTEGER is 10
			-- Initial capacity of `actions', `sorter', and `type_ids'

feature {NONE} -- Implementation (Topological sort)

	prepare_topological_sort (an_action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Add `an_action' to the topological `sorter'.
		require
			an_action_not_void: an_action /= Void
		local
			internal: INTERNAL
			operands: TUPLE [G]
			type_id: INTEGER
		do
			if an_action.open_count = 1 then
					-- Add `an_action' to the `sorter'.
				sorter.force (an_action)

					-- Calculate the type id of the open operand of `an_action'.
				operands := an_action.operands

					-- Exclude the expanded items.
					-- (Because no type conforms to an expanded type, 
					-- expanded items will be considered as the most
					-- specific items and inserted at the end of the
					-- topologically sorted list.)
				if operands.is_boolean_item (1)
					or else operands.is_character_item (1)
					or else operands.is_wide_character_item (1)
					or else operands.is_double_item (1)
					or else operands.is_integer_8_item (1)
					or else operands.is_integer_16_item (1)
					or else operands.is_integer_item (1)
					or else operands.is_integer_64_item (1)
					or else operands.is_pointer_item (1)
					or else operands.is_real_item (1)
				then
					expanded_items.put_last (an_action)
				elseif operands.is_reference_item (1) then
					create internal
					type_id := internal.generic_dynamic_type (operands, 1)

						-- Calculate the relations between `an_action'
						-- and the actions already in `type_ids' 
						-- and add these new relations to the `sorter'.
					from type_ids.start until type_ids.after loop
						if internal.type_conforms_to (type_id, type_ids.item_for_iteration) then
							sorter.put_relation (type_ids.key_for_iteration, an_action)
						elseif internal.type_conforms_to (type_ids.item_for_iteration, type_id) then
							sorter.put_relation (an_action, type_ids.key_for_iteration)
						end
						type_ids.forth
					end

						-- Add `an_action' associated with `type_id' to `type_ids'.
					type_ids.force (type_id, an_action)
				end
			else
				debug
					io.put_string ("The given action has more than one open operand.%N")
				end
			end
		end

	topological_sort is
			-- Perform the topological sort.
		do
			sorter.sort
			if not sorter.has_cycle then
				actions := sorter.sorted_items
					-- Add action applied to an expanded type if any.
				from expanded_items.start until expanded_items.after loop
					actions.force_last (expanded_items.item_for_iteration)
					expanded_items.forth
				end
			else
				debug
					io.put_string ("The topological sort ended with cycles. There must be a hole in the Eiffel type system.%N")
				end
			end
		end

feature {NONE} -- Implementation (Cache)

	fill_cache is
			-- Fill `actions_cache' with actions in `type_ids' indexed by type id.
		local
			lower: INTEGER
			upper: INTEGER
		do
			actions_cache.clear_all

			lower := actions_cache.lower
			upper := actions_cache.upper
			from type_ids.start until type_ids.after loop
				if type_ids.item_for_iteration < lower then
					lower := type_ids.item_for_iteration
				end
				if type_ids.item_for_iteration > upper then
					upper := type_ids.item_for_iteration
				end
				type_ids.forth
			end
			actions_cache.conservative_resize (lower, upper)

			from type_ids.start until type_ids.after loop
				actions_cache.put (type_ids.key_for_iteration, type_ids.item_for_iteration)
				type_ids.forth
			end
		end

	catch_all (an_element: G) is
			-- Routine called when no action is found for `an_element'
		do
		end

	catch_all_agent: PROCEDURE [ANY, TUPLE [G]]
			-- Agent on `catch_all'

	arguments: TUPLE [G] is
			-- Memory buffer to perform call to agents.
		once
			create Result
		ensure
			arguments_not_void: Result /= Void
		end

invariant

	actions_not_void: actions /= Void
	no_void_action: not actions.has (Void)
	sorter_not_void: sorter /= Void
	type_ids_not_void: type_ids /= Void
	no_void_type_id: not type_ids.has (Void)
	expanded_items_not_void: expanded_items /= Void
	no_void_expanded_item_not_void: not expanded_items.has (Void)
	actions_cache_not_void: actions_cache /= Void
	catch_all_agent_not_void: catch_all_agent /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
