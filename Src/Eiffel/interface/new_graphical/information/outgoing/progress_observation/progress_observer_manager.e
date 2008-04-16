indexing
	description: "Progress observer manager"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROGRESS_OBSERVER_MANAGER

feature -- Element Change

	add_observer (a_observer: !PROGRESS_OBSERVER) is
			-- Add observer to be managed
		do
			if progress_observers = Void then
				create progress_observers.make (1)
			end
			progress_observers.extend (a_observer)
		end

	remove_observer (a_observer: !PROGRESS_OBSERVER) is
			-- Add observer to be managed
		do
			if progress_observers /= Void and then not progress_observers.is_empty then
				progress_observers.prune_all (a_observer)
			end
		end

feature {NONE} -- Observer notification

	on_progress_start (a_total: INTEGER) is
			-- On starting visiting the system
		require
			a_total_not_void: a_total > 0
		local
			l_observers: like progress_observers
		do
			total := a_total
			if progress_observers /= Void then
				l_observers := progress_observers
				from
					l_observers.start
				until
					l_observers.after
				loop
					l_observers.item.on_progress_start
					l_observers.forth
				end
			end
		end

	on_progress_progress (a_value: INTEGER) is
			-- On progress has been made
		require
			value_valid: is_value_valid (a_value)
		local
			l_observers: like progress_observers
			l_propotion: REAL
		do
			if progress_observers /= Void then
				l_observers := progress_observers
				if total /= 0 then
					l_propotion := a_value / total
				else
					l_propotion := 1
				end
				from
					l_observers.start
				until
					l_observers.after
				loop
					l_observers.item.on_progress_progress (l_propotion)
					l_observers.forth
				end
			end
		end

	on_progress_stop is
			-- On stop visiting the system
		local
			l_observers: like progress_observers
		do
			total := 0
			if progress_observers /= Void then
				l_observers := progress_observers
				from
					l_observers.start
				until
					l_observers.after
				loop
					l_observers.item.on_progress_stop
					l_observers.forth
				end
			end
		end

	on_progress_finish is
			-- On finish visiting the system
		local
			l_observers: like progress_observers
		do
			total := 0
			if progress_observers /= Void then
				l_observers := progress_observers
				from
					l_observers.start
				until
					l_observers.after
				loop
					l_observers.item.on_progress_finish
					l_observers.forth
				end
			end
		end

feature {NONE} -- Querry

	is_value_valid (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' valid?
		do
			Result := a_value >= 0 and then a_value <= total
		end

feature {NONE} -- Observers

	progress_observers: ?ARRAYED_LIST [PROGRESS_OBSERVER]
			-- List of observers

	total: INTEGER;
			-- Total amount of the progress.

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
