note
	description: "[
		Base implementation for lockable interfaces {LOCKABLE_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LOCKABLE

inherit
	LOCKABLE_I

	DISPOSABLE_I

feature {NONE} -- Access

	lock_counter: NATURAL
			-- Lock counter.
			-- 0 indicates no lock, but use `is_locked'.

feature -- Status report

	is_locked: BOOLEAN
			-- <Precursor>
		do
			Result := lock_counter > 0
		ensure then
			lock_counter_positive: Result implies lock_counter > 0
		end

feature -- Basic operations

	lock
			-- <Precursor>
		local
			l_counter: like lock_counter
			l_events: like internal_locked_event
		do
			l_counter := lock_counter
			l_counter := l_counter + 1
			lock_counter := l_counter
			if l_counter = 1 then
				on_locked
			end
			l_events := internal_locked_event
			if attached l_events then
					-- Only publish events if Curren is locked, because a event handler may cause an unlock to be
					-- performed.
				l_events.publish_if ([Current], agent {attached LOCKABLE_I}.is_locked)
			end
		ensure then
			lock_counter_incremented: lock_counter = old lock_counter + 1
		end

	unlock
			-- <Precursor>
		local
			l_counter: like lock_counter
			l_events: like internal_unlocked_event
		do
			l_counter := lock_counter
			l_counter := l_counter - 1
			lock_counter := l_counter
			if l_counter = 0 then
				on_unlocked
			end
			l_events := internal_unlocked_event
			if attached l_events then
					-- Only publish events if Curren is unlocked, because a event handler may cause an unlock to be
					-- performed.
				l_events.publish_if ([Current], agent (ia_lock: attached LOCKABLE_I): BOOLEAN
					do
						Result := not ia_lock.is_locked
					end)
			end
		ensure then
			lock_counter_incremented: lock_counter = old lock_counter - 1
		end

feature {NONE} -- Event handlers

	on_locked
			-- Called when the first lock is placed.
		require
			is_interface_usable: is_interface_usable
			is_locked: is_locked
		do
		end

	on_unlocked
			-- Called when all the locks have been matched with an unlock.
		require
			is_interface_usable: is_interface_usable
			not_is_locked: not is_locked
		do
		end

feature -- Events

	locked_event: attached EVENT_TYPE [TUPLE [sender: attached LOCKABLE_I]]
			-- <Precursor>
		local
			l_result: like internal_locked_event
		do
			l_result := internal_locked_event
			if attached l_result then
				Result := l_result
			else
				create Result
				internal_locked_event := Result
				automation.auto_dispose (Result)
			end
		end

	unlocked_event: attached EVENT_TYPE [TUPLE [sender: attached LOCKABLE_I]]
			-- <Precursor>
		local
			l_result: like internal_unlocked_event
		do
			l_result := internal_unlocked_event
			if attached l_result then
				Result := l_result
			else
				create Result
				internal_unlocked_event := Result
				automation.auto_dispose (Result)
			end
		end

feature -- Events

	lockable_connection: !EVENT_CONNECTION_I [LOCKABLE_OBSERVER, LOCKABLE_I]
			-- <Precursor>
		local
			l_result: like internal_lockable_connection
		do
			l_result := internal_lockable_connection
			if l_result = Void then
				create {EVENT_CONNECTION [LOCKABLE_OBSERVER, LOCKABLE_I]} Result.make (
					agent (ia_observer: !LOCKABLE_OBSERVER): !ARRAY [TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								[locked_event, agent ia_observer.on_locked],
								[unlocked_event, agent ia_observer.on_unlocked] >>
						end)
				automation.auto_dispose (Result)
				internal_lockable_connection := Result
			else
				Result := l_result
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_locked_event: detachable like locked_event
			-- Cached version of `locked_event'.
			-- Note: Do not use directly!

	internal_unlocked_event: detachable like unlocked_event
			-- Cached version of `unlocked_event'.
			-- Note: Do not use directly!

	internal_lockable_connection: detachable like lockable_connection
			-- Cached version of `lockable_connection'.
			-- Note: Do not use directly!			

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
