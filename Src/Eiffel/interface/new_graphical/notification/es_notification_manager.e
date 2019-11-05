class
	ES_NOTIFICATION_MANAGER

inherit
	NOTIFICATION_OBSERVER

	EV_SHARED_APPLICATION

	ES_SHARED_FONTS_AND_COLORS

	SHARED_NOTIFICATION_SERVICE

create
	make

feature {NONE} -- Initialization

	make (a_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR)
		do
			if attached notification_s.service as s_notif then
					-- Connect code template catalog observer, to receive change notifications.
				s_notif.notification_connection.connect_events (Current)
			end
			status_bar := a_status_bar
			create notification_windows.make (5)
			create message_archive.make (100)
		end

feature -- Access

	status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR

	delay_ms: INTEGER = 10_000

feature -- Actions

	archive_dialog: detachable ES_NOTIFICATION_ARCHIVE_DIALOG

	show_notification_messages
		local
			l_dialog: like archive_dialog
			l_scaler: EVS_DPI_SCALER
		do
			deactivate_all_windows
			l_dialog := archive_dialog
			if l_dialog = Void or else l_dialog.is_destroyed then
				create l_dialog.make (Current)
				create l_scaler.make
				l_dialog.set_size (l_scaler.scaled_size (400), l_scaler.scaled_size (400))
				archive_dialog := l_dialog
			end
			l_dialog.update
			l_dialog.show
		end

feature {NOTIFICATION_S} -- Event handlers

	on_notification (m: NOTIFICATION_MESSAGE)
		do
			ev_application.add_idle_action_kamikaze (agent show_notification (m))
		end

feature {NOTIFICATION_S, ES_NOTIFICATION_WINDOW} -- Event handlers		

	show_notification (m: NOTIFICATION_MESSAGE)
		local
			win: ES_NOTIFICATION_WINDOW
		do
			create win.make (m, Current)
			activate_notification (win)
		end

	activate_notification (a_window: ES_NOTIFICATION_WINDOW)
		local
			w: EV_WIDGET
			y,ny: INTEGER
		do
			w := status_bar.widget
			y := w.screen_y + w.height
			across
				notification_windows as ic
			loop
				ny := ic.item.screen_y
				if ny < y then
					y := ny
				end
			end
			notification_windows.force (a_window)
			a_window.set_auto_close_delay (delay_ms)
			if attached parent_window (w) as win then
				a_window.show_relative_to_window (win)
			else
				a_window.show
			end
			a_window.set_position (w.screen_x + w.width - a_window.width - 1, y - a_window.height - 1)
			ev_application.add_idle_action_kamikaze (agent update_notification_positions)
		end

	update_notification_positions
		local
			x,y, min_y: INTEGER
			pwin, win: EV_WINDOW
			sep_size: INTEGER
		do
			sep_size := {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (3)
			if attached status_bar.widget as w then
				x := w.screen_x + w.width - 1
				y := w.screen_y
				pwin := parent_window (w)
				if pwin /= Void then
					min_y := pwin.screen_y + (pwin.height * 3) // 10 -- Max 3/10 of the parent Window height
				end
			end
			across
				notification_windows as ic
			loop
				win := ic.item
				if not win.is_destroyed then
					y := (y - win.height - sep_size).max (min_y)
					win.set_position (x - win.width, y)
				end
			end
		end

	deactivate_all_windows
		do
			if attached notification_windows as lst then
				from
				until
					lst.is_empty
				loop
					deactivate_notification (lst.first)
				end
			end
		end

	deactivate_notification (p: ES_NOTIFICATION_WINDOW)
		local
			y,h: INTEGER
		do
			archive (p.message)
			if not p.is_destroyed then
				h := p.height
				y := p.screen_y
			end
			notification_windows.prune (p)
			ev_application.add_idle_action_kamikaze (agent update_notification_positions)
		end

	notification_windows: ARRAYED_SET [ES_NOTIFICATION_WINDOW]

feature {ES_NOTIFICATION_ARCHIVE_DIALOG} -- Archive	

	clear_message_archive
		do
			message_archive.wipe_out
		end

	archive (a_message: NOTIFICATION_MESSAGE)
		do
			message_archive.put (a_message.to_archive)
		end

	message_archive: ES_NOTIFICATION_ARCHIVE

feature {NONE} -- Implementation

	parent_window (w: EV_WIDGET): detachable EV_WINDOW
		do
			if attached {EV_WINDOW} w as win then
				Result := win
			elseif attached w.parent as p then
				Result := parent_window (p)
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
