note
	description: "[
		Objects that trigger events of type {AUT_PROXY_EVENT} and notify a list of observers.
		
		`Current' can either be executing these events through an interpreter or realoading them from
		a log file.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_PROXY_EVENT_PRODUCER

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create observers.make_default
		end

feature -- Status report

	is_executing: BOOLEAN
			-- Indicates whether the reported events are being executed by an interpreter.
			--
			-- Note: if False, this currently means they are being parsed from a log file.
		deferred
		end

	is_replaying: BOOLEAN
			-- Are events from a earlier execution being re-executed?
			--
			-- Note: this includes events parsed from a log or selected during minimization.
		require
			executing: is_executing
		deferred
		end

	has_observer (a_observer: AUT_PROXY_EVENT_OBSERVER): BOOLEAN
			-- Has observer been added?
			--
			-- `a_observer': Observer to be checked.
			-- `Result': True if `a_observer' has been added, False otherwise.
		do
			Result := observers.has (a_observer)
		ensure
			correct: Result = observers.has (a_observer)
		end

feature {NONE} -- Access

	observers: DS_ARRAYED_LIST [AUT_PROXY_EVENT_OBSERVER]

feature -- Element change

	add_observer (a_observer: AUT_PROXY_EVENT_OBSERVER)
			-- Add event observer.
			--
			-- `a_observer': Observer to be added to `observers'.
		require
			a_observer_attached: a_observer /= Void
			not_has_observer: not has_observer (a_observer)
		do
			observers.force_last (a_observer)
		ensure
			added: observers.has (a_observer)
			incremented_observers: observers.count = old observers.count + 1
		end

	remove_observer (a_observer: AUT_PROXY_EVENT_OBSERVER)
			-- Remove event observer.
			--
			-- `a_observer': Observer to be removed from `observers'.
		require
			a_observer_attached: a_observer /= Void
			has_observer: has_observer (a_observer)
		do
			observers.start
			observers.search_forth (a_observer)
			check
				not_off: not observers.off
			end
			observers.remove_at
		ensure
			not_added: not observers.has (a_observer)
			decreased_observers: observers.count = old observers.count - 1
		end

feature {NONE} -- Basic operations

	report_event (an_event: AUT_PROXY_EVENT)
			-- Report event to observers.
			--
			-- `an_event': Event to be reported (request or response).
		local
			l_item: AUT_PROXY_EVENT_OBSERVER
		do
			from
				observers.start
			until
				observers.off
			loop
				l_item := observers.item_for_iteration
				an_event.publish (Current, l_item)

					-- Making sure we only move cursor if `l_item' has not been removed in the mean while.
				if not observers.off and then l_item = observers.item_for_iteration then
					observers.forth
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
