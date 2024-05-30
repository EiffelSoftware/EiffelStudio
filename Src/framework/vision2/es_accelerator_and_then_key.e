note
	description: "[
		Accelerator used to implement 2 step shortcuts
		such as [Ctrl+Shift+E] then a key pressed event
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCELERATOR_AND_THEN_KEY

inherit
	EV_ACCELERATOR
		rename
			actions as real_actions
		export
			{NONE} real_actions
		redefine
			initialize,
			create_interface_objects
		end

	EV_SHARED_APPLICATION
		undefine
			default_create,
			copy, is_equal,
			out
		end

create
	default_create,
	make_with_key_combination

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create actions
		end

	initialize
		do
			Precursor
			real_actions.extend (agent on_trigger)
			set_timeout (Default_timeout)
		end

feature -- Change

	set_timeout (a_timeout: INTEGER)
			-- Set `timeout` with `a_timeout`.
		require
			timeout_positive: a_timeout > 0
		do
			timeout := a_timeout
		end

feature -- Actions

	actions: EV_KEY_ACTION_SEQUENCE
			-- Actions triggered when the second key is pressed.
			-- The argument is the second key as a EV_KEY object.

feature -- Access

	timeout: INTEGER
			-- Timeout between first shortcut and then the second key pressed.	

feature {NONE} -- Implementation

	Default_timeout: INTEGER = 1000 -- 1 second

	timer: detachable EV_TIMEOUT

	key_press_actions_backup: detachable EV_KEY_ACTION_SEQUENCE

	prepare_key_press_actions (w: EV_WIDGET)
		do
			key_press_actions_backup := w.key_press_actions.twin
			w.key_press_actions.wipe_out
			w.key_press_actions.extend (agent event_key_pressed (?, w))
		end

	restore_key_press_actions (w: EV_WIDGET)
		do
			if attached key_press_actions_backup as l_actions then
				w.key_press_actions.wipe_out
				w.key_press_actions.fill (l_actions)
			end
		end

	stop_timer
		do
			if attached timer as t then
				t.actions.wipe_out
				t.destroy
				timer := t
			end
		end

	on_trigger
		local
			w: EV_WIDGET
			pop: EV_POPUP_WINDOW
			t: like timer
		do
			w := ev_application.focused_widget
			last_focused_widget := w
			if
				w /= Void and then
				attached parent_window_of (w) as win
			then
				create pop.make_with_shadow
				last_key_pressed := Void
				create t
				timer := t
				t.actions.extend (agent event_and_key_timer (pop))
				t.set_interval (timeout)

				prepare_key_press_actions (pop)
				pop.show_relative_to_window (win)
				pop.set_focus
			else
				-- no action ...
			end
		end

	last_focused_widget: detachable EV_WIDGET

	last_key_pressed: detachable EV_KEY

	event_key_pressed (k: EV_KEY; w: EV_WIDGET)
		do
			last_key_pressed := k
			event_and_key_timer (w)
		end

	event_and_key_timer (w: EV_WIDGET)
		do
			stop_timer
			restore_key_press_actions (w)
			if attached last_focused_widget as fw then
				fw.set_focus
				last_focused_widget := Void
			end
			if attached last_key_pressed as k then
				actions.call ([k])
				last_key_pressed := Void
			end
		end

	parent_window_of (w: EV_WIDGET): detachable EV_WINDOW
		do
			if attached {EV_WINDOW} w as win then
				Result := win
			elseif attached w.parent as par then
				Result := parent_window_of (par)
			end
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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
end

