indexing
	description: "[
		A variant of {SAFE_DISPOSABLE} who's functional abilities are to added attached objects of a instance of the descending class
		to a pool of disposable items. When the descended instance is diposed of the registered disposable objects are also disposed.
		
		Descendant classes can also delay register objects by using an agent function to retrieve the object at dispose-time.
		Note: Using a function to retrieve the object MUST not create any objects. Protection is integrated against the function
		      returning Void so this need not be a concern.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	SAFE_AUTO_DISPOSABLE

inherit
	SAFE_DISPOSABLE

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN) is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Effect it in descendants to perform specific dispose
			-- actions. Those actions should only take care of freeing
			-- external resources; they should not perform remote calls
			-- on other objects since these may also be dead and reclaimed.
			--
			-- `a_disposing': True if Current is being explictly disposed of, False to indicate finalization.
		local
			l_pool: ?like internal_disposable_pool
			l_actions: ?like internal_disposable_actions
		do
			if a_disposing then
				l_pool := internal_disposable_pool
				if l_pool /= Void then
						-- Twin to prevent index changes.
					from l_pool.start until l_pool.after loop
						if {l_disposable: SAFE_DISPOSABLE} reveal_disposable_item (l_pool.item_for_iteration) then
								-- Perform dispose
							l_disposable.dispose
						end
						l_pool.forth
					end
					l_pool.wipe_out
				end

				l_actions := internal_disposable_actions
				if l_actions /= Void then
					l_actions.call (Void)
					l_actions.wipe_out
				end
			end
		ensure then
			internal_disposable_pool_is_empty: internal_disposable_pool /= Void implies internal_disposable_pool.is_empty
			internal_disposable_actions_is_empty: internal_disposable_actions /= Void implies internal_disposable_actions.is_empty
		end

feature {NONE} -- Access

	frozen disposable_pool: DS_ARRAYED_LIST [ANY]
			-- List of items to be automatically disposed when Current is disposed.
			-- Note: Call `auto_dispose' or `delayed_auto_dispose' rather than use directly!
		require
			not_is_zombie: not is_zombie
		do
			Result := internal_disposable_pool
			if Result = Void then
				create Result.make (1)
				internal_disposable_pool := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = Result
		end

	frozen disposable_actions: ACTION_SEQUENCE [TUPLE]
			-- List of agents to be called on dispose.
			-- Note: Call `perform_auto_dispose' rather than use directly!
		require
			not_is_zombie: not is_zombie
		do
			Result := internal_disposable_actions
			if Result = Void then
				create Result
				internal_disposable_actions := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = Result
		end

feature -- Basic operation

	frozen auto_dispose (a_object: ANY)
			-- Automatically disposes of an object when Current is disposed of.
			--
			-- `a_object': Object to dispose of when Current is disposed.
		require
			a_object_attached: a_object /= Void
		do
			check
				not_is_zombie: not is_zombie
				not_is_actively_disposing: not is_actively_disposing
				not_disposable_pool_has_a_object: not disposable_pool.has (a_object)
			end
			if is_interface_usable then
				disposable_pool.force_last (a_object)
			end
		ensure
			disposable_pool_has_a_object: is_interface_usable implies disposable_pool.has (a_object)
		end

	frozen delayed_auto_dispose (a_action: FUNCTION [ANY, TUPLE, ANY])
			-- Automatically disposes of an object when Current is disposed of.
			-- Note: DO NOT create any objects in the performed action, this may be called
			--       during a real GC dispose.
			--
			-- `a_action': The action to retrieve a object for when Current is disposed.
			--             Warning: THe action should not create any objects for Current
		require
			a_action_attached: a_action /= Void
		do
			check
				not_is_zombie: not is_zombie
				not_is_actively_disposing: not is_actively_disposing
				not_disposable_pool_has_a_action: not disposable_pool.has (a_action)
			end
			if is_interface_usable then
				disposable_pool.force_last (a_action)
			end
		ensure
			disposable_pool_has_a_action: is_interface_usable implies disposable_pool.has (a_action)
		end

	frozen perform_auto_dispose (a_action: PROCEDURE [ANY, TUPLE])
			-- Automatically performs an action on dispose.
			-- Note: DO NOT create any objects in the performed action, this may be called
			--       during a real GC dispose.
			--
			-- `a_action': The action to called when Current is disposed.
		require
			a_action_attached: a_action /= Void
		do
			check
				not_is_zombie: not is_zombie
				not_is_actively_disposing: not is_actively_disposing
				not_disposable_actions_has_a_action: not disposable_actions.has (a_action)
			end
			if is_interface_usable then
				disposable_actions.extend (a_action)
			end
		ensure
			disposable_actions_has_a_action: is_interface_usable implies disposable_actions.has (a_action)
		end

feature {NONE} -- Query

	frozen reveal_disposable_item (a_object: ANY): ANY
			-- Attempts to reveal a disposable item, which will call an agent if the object
			-- actually represents an agent call to retrieve an object for the classes Current state
			-- instead of it's initial state.
		require
			a_object_attached: a_object /= Void
		local
			l_action: FUNCTION [ANY, TUPLE, ANY]
		do
			l_action ?= a_object
			if l_action /= Void then
				Result := l_action.item ([])
			else
				Result := a_object
			end
		end

feature {NONE} -- Internal implementation cache

	frozen internal_disposable_pool: like disposable_pool
			-- Cached version of `disposable_pool'
			-- Note: Do not use directly!

	frozen internal_disposable_actions: like disposable_actions
			-- Cached version of `disposable_actions'
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
