note
	description: "Observable objects used in Eiffel Query Language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_OBSERVABLE

feature -- Status report

	changed: BOOLEAN
			-- Has current changed after last `notify'?			

feature -- Setting

	set_changed
			-- Set `changed' to True.
		do
			changed := True
		ensure
			changed_set: changed
		end

	clear_changed
			-- Set `changed' to False.
		do
			changed := False
		ensure
			changed_cleared: not changed
		end

	block
			-- Block `notify' (i.e., `notify' will not notify registered observers.)
		do
			block_count := block_count + 1
		ensure
			block_count_increased: block_count = old block_count + 1
		end

	resume
			-- Resume `notify'.
		do
			if block_count > 0 then
				block_count := block_count - 1
			end
		ensure
			block_count_decreased: (old block_count > 0) implies block_count = old block_count - 1
		end

feature -- Notification

	notify (a_data: like observed_data_type)
			-- Notify all registered obervers if `changed' is True.
		local
			l_observers: like registered_observers
		do
			if changed and then not is_blocked then
				clear_changed
				if observer_count > 0 then
					from
						l_observers := registered_observers
						l_observers.start
					until
						l_observers.after
					loop
						l_observers.item.update (Current, a_data)
						l_observers.item.actions.call (Void)
						l_observers.forth
					end
				end
			end
		end

feature -- Observer registration

	add_observer (a_observer: like observer_type)
			-- Register `a_observer' into `registered_observers'.
		require
			a_observer_attached: a_observer /= Void
		do
			registered_observers.extend (a_observer)
		ensure
			observer_registered: registered_observers.has (a_observer)
		end

	remove_observer (a_observer: like observer_type)
			-- Remove `a_observer' from `registered_observers'.
		require
			a_observer_attached: a_observer /= Void
		do
			registered_observers.search (a_observer)
			if not registered_observers.exhausted then
				registered_observers.remove
			end
		ensure
			observer_removed: not registered_observers.has (a_observer)
		end

	clear_observers
			-- Remove all registered observers
		do
			registered_observers.wipe_out
		ensure
			all_observers_removed: registered_observers.is_empty
		end

feature -- Access

	observers: like registered_observers
			-- List of registered observers
		do
			Result := registered_observers.twin
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	observer_count: INTEGER
			-- Number of registered observers
		do
			Result := registered_observers.count
		ensure
			good_result: Result = registered_observers.count
		end

	has_observer (a_observer: like observer_type): BOOLEAN
			-- Does `registered_observers' contain `a_observer'?
		require
			a_observer_attached: a_observer /= Void
		do
			Result := registered_observers.has (a_observer)
		ensure
			good_result: Result implies registered_observers.has (a_observer)
		end

	is_blocked: BOOLEAN
			-- Is `notify' blocked?
		do
			Result := block_count > 0
		end

feature{NONE} -- Observers

	registered_observers: LINKED_LIST [like observer_type]
			-- List of registered observers
		do
			if internal_observers = Void then
				create internal_observers.make
			end
			Result := internal_observers
		ensure
			result_attached: Result /= Void
			good_result: Result = internal_observers
		end

	internal_observers: like registered_observers
			-- Implementation of `registered_observers'

	observer_type: QL_OBSERVER
			-- Anchor type for observers

	observed_data_type: ANY
			-- Anchor type for observed data

feature{NONE} -- Implementation

	block_count: INTEGER
			-- Block count
			-- if it's zero, `notify' is resumed, it it's positive, `notify' is blocked.

invariant
	observers_attached: registered_observers /= Void
	block_count_non_negative: block_count >= 0

note
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
