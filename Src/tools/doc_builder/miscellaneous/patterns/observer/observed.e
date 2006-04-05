indexing
	description: "Observed (Subject on Observer pattern, (Design Patterns, 293, Gamma et.al))"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBSERVED

feature -- Access

	observers: ARRAYED_LIST [OBSERVER]
			-- Observers of Current

	is_updating: BOOLEAN
			-- Is Current currently updating?

feature -- Commands

	attach (o: OBSERVER) is
			-- Attach observer `o'
		require
			observer_not_void: o /= Void
		do
			if observers = Void then
				create observers.make (1)
			end
			if not has (o) then
				observers.extend (o)
			end			
		end
		
	detach 	(o: OBSERVER) is
			-- Detach observer `o'
		require
			has_observer: has (o)
			observers_list_not_void: observers /= Void
		do
			observers.prune (o)
		end
		
feature -- Query

	has (o: OBSERVER): BOOLEAN is
			-- Is `o' an observer?
		require
			observer_not_void: o /= Void
			observers_list_not_void: observers /= Void
		do			
			Result := observers.has (o)
		end		

	has_observers: BOOLEAN is
			-- Has any observers?
		do			
			Result := observers /= Void and not observers.is_empty	
		end		

feature {NONE} -- Implementation

	notify_observers is
			-- Notify observers of change
		require
			not_busy: not is_updating
		do
			is_updating := True
			if has_observers then
				from
					observers.start
				until
					observers.after
				loop
					if observers.item.should_update then
						observers.item.update	
					end
					observers.forth
				end
			end
			is_updating := False
		end

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
end -- class OBSERVED
