indexing
	description	: "TIMER for debugger on mswin"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DEBUGGER_TIMER

inherit
	DEBUGGER_TIMER
		redefine default_create end

feature {NONE} -- Initialization

	default_create is
			-- Create Current debugger timer
		do
			Precursor
			create ev_timer
		end

feature -- Access

	interval: INTEGER is
		do
			Result := ev_timer.interval
		end

	actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed at a regular interval.
			-- Only called when interval is greater than 0.	
		do
			Result := ev_timer.actions
		end

feature -- Change

	set_interval (i: like interval) is
		do
			ev_timer.set_interval (i)
		end

feature {NONE} -- Implementation

	ev_timer: EV_TIMEOUT

invariant
	ev_timer /= Void

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
