indexing
	description: "[
		A specialized pop up window that does not immediate hide when requested, instead it delays it for a set interval
		
		Note: Untested, work in progress!
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_POPUP_CLING_WINDOW

inherit
	ES_POPUP_WINDOW
		redefine
			hide,
			on_pointer_leave
		end

feature {NONE} -- Access

	hide_delay_timer: EV_TIMEOUT
			-- Timer used to perform actually hiding

	hide_delay_timer_interval: INTEGER
			-- Timeout interval for hiding the popup window
		do
			Result := 300
		ensure
			result_non_negative: Result >= 0
		end

feature -- Status report

	is_hide_requested: BOOLEAN
			-- Indicates if a hide operation has been requested

feature -- Basic operations

	hide
			-- Hides popup window.
		do
			Precursor {ES_POPUP_WINDOW}

				-- Clean up timer
			hide_delay_timer.set_interval (0)
			hide_delay_timer.destroy
			hide_delay_timer := Void
			is_hide_requested := False
		ensure then
			hide_delay_timer_cleaned_up: not is_shown implies hide_delay_timer = Void
			not_is_hide_requested: not is_hide_requested
		end

	hide_delayed (a_force: BOOLEAN)
			-- Requests a hide to be performed when appropriate.
			-- Note: The window will not be hidden if the mouse cursor is within the window region.
			--
			-- `a_force': True to ensure the window will be hidden, even with the mouse pointer within its region. False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_shown: is_shown
		local
			l_timer: like hide_delay_timer
		do
			if is_initialized then
				if hide_delay_timer_interval = 0 then
						-- No interval, so just hide
					on_hide_delay_timer_expired (a_force)
				else
						-- Set up timer
					l_timer := hide_delay_timer
					if l_timer /= Void then
							-- Remove previous actions (because the old and new force option may differ)
						l_timer.set_interval (0)
						l_timer.actions.wipe_out
					end

					is_hide_requested := False

						-- Create an start timer			
					create l_timer
					hide_delay_timer := l_timer

					l_timer.actions.extend (agent on_hide_delay_timer_expired (a_force))
					l_timer.set_interval (hide_delay_timer_interval)
					l_timer.actions.resume
				end
			end
		ensure
			is_hide_requested: is_initialized and then is_shown implies is_hide_requested
		end

feature {NONE} -- Action handlers

	on_pointer_leave
			-- Called when the mouse cursor leaves the pop up window.
		do
			Precursor {ES_POPUP_WINDOW}
			if is_hide_requested then
				on_hide_delay_timer_expired (False)
			end
		end

	on_hide_delay_timer_expired (a_force: BOOLEAN)
			-- Performs the actualy hiding of the popup window, if possible given the mouse coords.
			--
			-- `a_force': True to ensure the window will be hidden, even with the mouse pointer within its region. False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if is_shown then
				if a_force or not has_mouse_pointer then
					hide
				end
			end
		end

invariant
	not_is_hide_requested: not is_shown implies not is_hide_requested
	hide_delay_timer_attached: is_hide_requested implies hide_delay_timer /= Void

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
