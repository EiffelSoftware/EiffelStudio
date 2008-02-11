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
		do
			if not a_disposing and then internal_disposable_pool /= Void then
				internal_disposable_pool.do_all (agent (a_item: ANY)
					local
						l_disposable: SAFE_DISPOSABLE
						retried: BOOLEAN
					do
						if not retried then
							l_disposable ?= reveal_disposable_item (a_item)
							if l_disposable /= Void then
									-- Perform dispose
								l_disposable.dispose
							end
						end
					rescue
						retried := True
						retry
					end)
				internal_disposable_pool.wipe_out
			end
		end

feature {NONE} -- Access

	frozen disposable_pool: DS_ARRAYED_LIST [ANY]
			-- List of items to be automatically disposed when Current is disposed
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

feature {NONE} -- Basic operation

	frozen auto_dispose (a_object: ANY)
			-- Automatically disposes of an object when Current is disposed of.
			--
			-- `a_object': Object to dispose of when Current is disposed.
		require
			not_is_zombie: not is_zombie
			not_is_actively_disposing: not is_actively_disposing
			a_object_attached: a_object /= Void
			not_disposable_pool_has_a_object: not disposable_pool.has (a_object)
		do
			disposable_pool.force_last (a_object)
		ensure
			disposable_pool_has_a_object: disposable_pool.has (a_object)
		end

	frozen delayed_auto_dispose (a_action: FUNCTION [ANY, TUPLE, ANY])
			-- Automatically disposes of an object when Current is disposed of.
			--
			-- `a_action': The action to retrieve a object for when Current is disposed.
			--             Warning: THe action should not create any objects for Current
		require
			not_is_zombie: not is_zombie
			not_is_actively_disposing: not is_actively_disposing
			a_action_attached: a_action /= Void
			not_disposable_pool_has_a_action: not disposable_pool.has (a_action)
		do
			disposable_pool.force_last (a_action)
		ensure
			disposable_pool_has_a_action: disposable_pool.has (a_action)
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
