note
	description: "[
		A automation handler for managing automatic disposal of ancillary objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DISPOSABLE_AUTOMATION_HANDLER

inherit
	DISPOSABLE_AUTOMATION_I

	SHARED_DISPOSABLE_UTILITIES
		export
			{NONE} all
		end

feature {NONE} -- Access

	frozen object_pool: LIST [ANY]
			-- List of objects to be automatically disposed when Current is disposed.
			--
			--| Call `auto_dispose' or `delayed_auto_dispose' rather than use directly!
		require
			not_is_disposed: not is_disposed
		local
			l_result: like internal_object_pool
		do
			l_result := internal_object_pool
			if l_result = Void then
				check not_is_actively_disposing: not is_actively_disposing end
				create {ARRAYED_LIST [ANY]} Result.make (0)
				internal_object_pool := Result
			else
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: attached {LIST [detachable ANY]} Result as l_list implies
				not l_list.has (Void)
			result_is_consistent: Result = object_pool
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := not is_disposed
		ensure then
			not_is_disposed: is_disposed implies not Result
		end

	is_notified_on_disposing (a_action: PROCEDURE [ANY, TUPLE]): BOOLEAN
			-- <Precursor>
		local
			l_events: like internal_disposing_event
		do
			if is_interface_usable then
				l_events := internal_disposing_event
				if l_events /= Void and then l_events.is_interface_usable then
					Result := l_events.is_subscribed (a_action)
				end
			end
		ensure then
			a_action_is_subscribed: is_interface_usable implies disposing_event.is_subscribed (a_action)
		end

	is_notified_on_disposed (a_action: PROCEDURE [ANY, TUPLE]): BOOLEAN
			-- <Precursor>
		local
			l_events: like internal_disposed_event
		do
			if is_interface_usable then
				l_events := internal_disposed_event
				if l_events /= Void and then l_events.is_interface_usable then
					Result := l_events.is_subscribed (a_action)
				end
			end
		ensure then
			a_action_is_subscribed: is_interface_usable implies disposed_event.is_subscribed (a_action)
		end

feature {NONE} -- Status report

	is_disposed: BOOLEAN
			-- Indicates if `Current' has been disposed of.

	is_actively_disposing: BOOLEAN
			-- Indicates if `Current' is actively being dispose

feature {NONE} -- Query

	frozen reveal_disposable_object (a_object: ANY): ANY
			-- Attempts to reveal a disposable item, which will call an agent if the object
			-- actually represents an agent call to retrieve an object for the classes Current state
			-- instead of it's initial state.
		require
			a_object_attached: a_object /= Void
		do
			if attached {FUNCTION [ANY, TUPLE, ANY]} a_object as l_action then
				Result := l_action.item (Void)
			else
				Result := a_object
			end
		ensure
			result_attached: Result /= Void
		end

feature {DISPOSABLE_I, DISPOSABLE} -- Basic operations

	perform_automotive_dispose (a_action: PROCEDURE [ANY, TUPLE])
			-- <Precursor>
		require
			is_interface_usable: is_interface_usable
		local
			l_event: detachable EVENT_TYPE [TUPLE]
			l_pool: detachable like internal_object_pool
			l_utils: like disposable_utils
		do
			check not_is_actively_disposing: not is_actively_disposing end
			is_actively_disposing := True

				-- Call the pre-dispose event				
			l_event := internal_disposing_event
			if l_event /= Void then
				l_event.publish (Void)
				l_event.dispose
			end

			l_pool := internal_object_pool
			if l_pool /= Void then
				l_utils := disposable_utils
				from l_pool.start until l_pool.after loop
					l_utils.dispose (reveal_disposable_object (l_pool.item_for_iteration))
					l_pool.forth
				end
				l_pool.wipe_out
			end

				-- Perform actual dispose.
			a_action.call (Void)
			is_disposed := True

				-- Call the post-dispose event				
			l_event := internal_disposed_event
			if l_event /= Void then
				l_event.publish (Void)
				l_event.dispose
			end

			is_actively_disposing := False
		ensure
			internal_object_pool_is_empty:
				attached old internal_object_pool as el_pool implies el_pool.is_empty
			not_internal_disposing_event_is_interface_usable:
				attached old internal_disposing_event as l_disposing implies not l_disposing.is_interface_usable
			not_internal_disposed_event_is_interface_usable:
				attached old internal_disposed_event as l_disposed implies not l_disposed.is_interface_usable
			is_disposed: is_disposed
		rescue
			is_actively_disposing := False
			is_disposed := True
			l_event := internal_disposing_event
			if l_event /= Void and then l_event.is_interface_usable then
				l_event.dispose
			end
			l_event := internal_disposed_event
			if l_event /= Void and then l_event.is_interface_usable then
				l_event.dispose
			end
			debug ("dispose")
				print ("ERROR: Dispose failed to complete, potential memory leak!%N")
			end
		end

feature -- Basic operation

	frozen auto_dispose (a_object: ANY)
			-- <Precursor>
		do
			check
				not_is_actively_disposing: not is_actively_disposing
				not_object_pool_has_a_object: not object_pool.has (a_object)
			end
			object_pool.extend (a_object)
		ensure then
			object_pool_has_a_object: is_interface_usable implies object_pool.has (a_object)
		end

	frozen delayed_auto_dispose (a_action: FUNCTION [ANY, TUPLE, ANY])
			-- <Precursor>
		do
			check
				not_is_actively_disposing: not is_actively_disposing
				not_object_pool_has_a_action: not object_pool.has (a_action)
			end
			object_pool.extend (a_action)
		ensure then
			object_pool_has_a_action: is_interface_usable implies object_pool.has (a_action)
		end

feature -- Notification

	notify_on_disposing (a_action: PROCEDURE [ANY, TUPLE])
			-- <Precursor>
		do
			check not_is_actively_disposing: not is_actively_disposing end
			disposing_event.subscribe (a_action)
		end

	ignore_on_disposing (a_action: PROCEDURE [ANY, TUPLE])
			-- <Precursor>
		do
			disposing_event.unsubscribe (a_action)
		end

	notify_on_disposed (a_action: PROCEDURE [ANY, TUPLE])
			-- <Precursor>
		do
			check not_is_actively_disposing: not is_actively_disposing end
			if not is_actively_disposing then
				disposed_event.subscribe (a_action)
			end
		end

	ignore_on_disposed (a_action: PROCEDURE [ANY, TUPLE])
			-- <Precursor>
		do
			disposed_event.unsubscribe (a_action)
		end

feature {NONE} -- Events

	disposing_event: EVENT_TYPE [TUPLE]
			-- Event published prior to a dispose of Current.
		require
			is_interface_usable: is_interface_usable
		local
			l_result: like internal_disposing_event
		do
			l_result := internal_disposing_event
			if l_result = Void then
				check not_is_actively_disposing: not is_actively_disposing end
				create Result
				internal_disposing_event := Result
			else
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = disposing_event
		end

	disposed_event: EVENT_TYPE [TUPLE]
			-- Event published after Current has been disposed of.
		require
			is_interface_usable: is_interface_usable
		local
			l_result: like internal_disposed_event
		do
			l_result := internal_disposed_event
			if l_result = Void then
				check not_is_actively_disposing: not is_actively_disposing end
				create Result
				internal_disposed_event := Result
			else
				Result := l_result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = disposed_event
		end

feature {NONE} -- Implementation: Internal cache

	frozen internal_disposing_event: detachable like disposing_event
			-- Cached version of `disposing_event'.
			-- Note: Do not use directly!

	frozen internal_disposed_event: detachable like disposed_event
			-- Cached version of `disposed_event'.
			-- Note: Do not use directly!

	frozen internal_object_pool: detachable like object_pool
			-- Cached version of `object_pool'
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
