indexing
	description: "Key pool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_KEY_POOL

feature -- Access

	registered_key_shortcuts: HASH_TABLE [INTEGER, ES_KEY_SHORTCUT] is
			-- Key shortcuts with their agent index
			-- Value is agent index, use this index to find actual agent in `key_actions'.
			-- Key is the shortcut.
		do
			create Result.make (key_action_binder.count)
			Result.fill (key_action_binder)
		ensure
			result_attached: Result /= Void
		end

	key_action (a_index: INTEGER): PROCEDURE [ANY, TUPLE] is
			-- Key action associated with index `a_index'.
			-- Void if no action is associated with `a_index'.
		do
			if has_key_action (a_index) then
				Result := key_actions.item (a_index)
			end
		end

	key_action_with_shortcut (a_shortcut: ES_KEY_SHORTCUT): PROCEDURE [ANY, TUPLE] is
			-- Key action with shortcut `a_shortcut'.
			-- Void if no key action is binded with `a_shortcut'.
		require
			a_shortcut_attached: a_shortcut /= Void
		local
			l_binder: like key_action_binder
		do
			l_binder := key_action_binder
			if l_binder.has (a_shortcut) then
				Result := key_actions.item (l_binder.item (a_shortcut))
			end
		end

	kay_actions: HASH_TABLE [PROCEDURE [ANY, TUPLE], INTEGER] is
			-- Table of all registered key actions with their keys
			-- Key is action index, value is that action agent.
		do
			create Result.make (key_actions.count)
			Result.fill (key_actions)
		ensure
			result_attached: Result /= Void
		end

	key_shortcut_with_action_index (a_index: INTEGER): ES_KEY_SHORTCUT is
			-- Key shortcut associated with agent whose index is `a_index'
			-- Void if not key shortcut is assoicated with `a_index'
		local
			l_binder: like key_action_binder
			done: BOOLEAN
		do
			l_binder := key_action_binder
			if l_binder.has_item (a_index) then
				from
					l_binder.start
				until
					l_binder.after or done
				loop
					if l_binder.item_for_iteration = a_index then
						Result := l_binder.key_for_iteration
						done := True
					end
					l_binder.forth
				end
				check Result /= Void end
			end
		end

feature -- Status report

	has_key_action (a_index: INTEGER): BOOLEAN is
			-- Dose key action with index `a_index' exist in `key_actions'?
		do
			Result := key_actions.has (a_index)
		end

	has_key_shortcut (a_shortcut: ES_KEY_SHORTCUT): BOOLEAN is
			-- Does `key_shortcut' exist in `key_action_binder'?
		require
			a_shortcut_attached: a_shortcut /= Void
		do
			Result := key_action_binder.has (a_shortcut)
		end

	has_key_shortcut_binded_with_action (a_shortcut: ES_KEY_SHORTCUT; a_index: INTEGER): BOOLEAN is
			-- Has `a_shortcut' been binded with key action indexed by `a_index'?
		do
			if has_key_action (a_index) then

			end
			Result := has_key_action (a_index) and then key_shortcut_with_action_index (a_index) = a_shortcut
		end

feature -- Setting

	add_key_action (a_agent: PROCEDURE [ANY, TUPLE]; a_index: INTEGER) is
			-- Add key action `a_agent' with index `a_index' in to `key_actions'.			
		require
			a_agent_attached: a_agent /= Void
			a_index_not_exist: not has_key_action (a_index)
		do
			key_actions.force (a_agent, a_index)
		ensure
			action_added: key_actions.item (a_index) = a_agent
		end

	remove_key_action (a_index: INTEGER): BOOLEAN is
			-- Remove key action with index `a_index'.
			-- If the action is binded with some shortcut key, this binding is also removed.
		local
			l_binder: like key_action_binder
			done: BOOLEAN
		do
			l_binder := key_action_binder
			if l_binder.has_item (a_index) then
				from
					l_binder.start
				until
					l_binder.after or done
				loop
					if l_binder.item_for_iteration = a_index then
						l_binder.remove (l_binder.key_for_iteration)
						done := True
					end
					l_binder.forth
				end
			end
			key_actions.remove (a_index)
		ensure
			key_action_removed: not key_action_binder.has_item (a_index) and then not key_actions.has (a_index)
		end

	add_key_shortcut (a_index: INTEGER; a_shortcut: ES_KEY_SHORTCUT) is
			-- Add key shortcut `a_shortcut' and its associated action with index `a_index' in `key_action_binder'.
			-- If `a_shortcut' already exists in `key_action_binder', the original action for this shortcut will be overritten by the new one.
		require
			action_exists: has_key_action (a_index)
			a_shortcut_attached: a_shortcut /= Void
		do
			key_action_binder.force (a_index, a_shortcut)
		ensure
			shortcut_key_added: key_action_binder.item (a_shortcut) = a_index
		end

	remove_key_shortcut (a_shortcut: ES_KEY_SHORTCUT) is
			-- Remove `a_shortcut' from `key_action_binder' if presents.
		require
			a_shortcut_attached: a_shortcut /= Void
		do
			key_action_binder.remove (a_shortcut)
		ensure
			key_shortcut_removed: not key_action_binder.has (a_shortcut)
		end

	update_key_shortcut (a_old_shortcut, a_new_shortcut: ES_KEY_SHORTCUT) is
			-- If `a_old_shortcut' exists in `key_action_binder', update it with `a_new_shortcut'.
		require
			a_old_shortcut_attached: a_old_shortcut /= Void
			a_new_shortcut_attached: a_new_shortcut /= Void
			shortcuts_are_different: not a_old_shortcut.is_equal (a_new_shortcut)
			a_new_shortcut_not_already_exist: not has_key_shortcut (a_new_shortcut)
		do
			if has_key_shortcut (a_old_shortcut) then
				key_action_binder.replace_key (a_new_shortcut, a_old_shortcut)
			end
		end

	update_key_action_with_new_shortcut (a_index: INTEGER; a_new_shortcut: ES_KEY_SHORTCUT) is
			-- If key action indexed by `a_index' is already binded with a shortcut key, update this binding
			-- using `a_new_shortcut'.
		require
			a_new_shortcut_attached: a_new_shortcut /= Void
		local
			l_shortcut: ES_KEY_SHORTCUT
		do
			l_shortcut := key_shortcut_with_action_index (a_index)
			if l_shortcut /= Void and then not l_shortcut.is_equal (a_new_shortcut) then
				update_key_shortcut (l_shortcut, a_new_shortcut)
			end
		end

feature{NONE} -- Implementation

	key_actions: HASH_TABLE [PROCEDURE [ANY, TUPLE], INTEGER] is
			-- Table of registered key agents.
			-- Value is the agent, key is an integer index.
		do
			if key_actions_internal = Void then
				create key_actions_internal.make (10)
			end
			Result := key_actions_internal
		ensure
			result_attached: Result /= Void
		end

	key_action_binder: HASH_TABLE [INTEGER, ES_KEY_SHORTCUT] is
			-- Table storing shortcut keys and its related action
			-- Key is the shortcut key combination, value is the action index.
			-- The actual action can be found in `key_actions'.
		do
			if key_action_binder_internal = Void then
				create key_action_binder_internal.make (5)
			end
			Result := key_action_binder_internal
		ensure
			result_attached: Result /= Void
		end

	key_action_binder_internal: like key_action_binder
			-- Implementation of `key_action_binder'

	key_actions_internal: like key_actions
			-- Implementation of `key_actions'

invariant
	key_actions_attached: key_actions /= Void
	key_action_binder_attached: key_action_binder /= Void

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
