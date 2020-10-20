class
	ES_NOTIFICATION_MANAGER

inherit
	NOTIFICATION_OBSERVER

	EV_SHARED_APPLICATION

	ES_SHARED_FONTS_AND_COLORS

	EB_SHARED_PREFERENCES

	SHARED_NOTIFICATION_SERVICE

	EB_CONSTANTS
		export
			{NONE} all
		end

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
			create messages.make (100)
			autoclose_delay_ms := preferences.dialog_data.notification_autoclose_delay_ms
			attach_to_status_bar (a_status_bar)
		end

feature -- Association

	attach_to_status_bar (a_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR)
		do
			is_attachment_to_status_bar_completed := False
			a_status_bar.notifications_icon.pointer_double_press_actions.extend (agent (i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					do
						if i_button = {EV_POINTER_CONSTANTS}.left then
							show_notification_messages
						end
					end
				)
			a_status_bar.notifications_icon.pointer_button_press_actions.extend (agent (i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					local
						m,pm: EV_MENU
						mi: EV_MENU_ITEM
					do
						if i_button = {EV_POINTER_CONSTANTS}.right then
							create m.make_with_text ("Notifications")
							create mi.make_with_text ("Show messages (" + messages.count.out + ")")
							mi.select_actions.extend (agent show_notification_messages)
							m.extend (mi)
							m.extend (create {EV_MENU_SEPARATOR})
							if attached notifications_suspended_until as dt and then (create {DATE_TIME}.make_now) <= dt then
								create mi.make_with_text ("Resume")
								mi.select_actions.extend (agent resume_notifications)
								m.extend (mi)
							end
							create pm.make_with_text ("Suspend ...")
							pm.select_actions.extend (agent suspend_notifications_for (0))
							m.extend (pm)

							if not notifications_suspended then
								create mi.make_with_text ("for ever")
								mi.select_actions.extend (agent suspend_notifications_for (15))
								pm.extend (mi)
							end

							create mi.make_with_text ("for 1 minute")
							mi.select_actions.extend (agent suspend_notifications_for (1))
							pm.extend (mi)

							create mi.make_with_text ("for 5 minutes")
							mi.select_actions.extend (agent suspend_notifications_for (5))
							pm.extend (mi)

							create mi.make_with_text ("for 15 minutes")
							mi.select_actions.extend (agent suspend_notifications_for (15))
							pm.extend (mi)

							create mi.make_with_text ("for 1 hour")
							mi.select_actions.extend (agent suspend_notifications_for (60))
							pm.extend (mi)

							create mi.make_with_text ("for 1 day")
							mi.select_actions.extend (agent suspend_notifications_for (24 * 60))
							pm.extend (mi)

							m.extend (create {EV_MENU_SEPARATOR})

							create mi.make_with_text ("Clear all messages")
							mi.select_actions.extend (agent clear_messages)
							m.extend (mi)

							m.show
						end
					end
				)
			update_status_bar
		end

	ensure_attachment_to_status_bar_is_completed
		do
			if
				not is_attachment_to_status_bar_completed and then
				attached parent_window (status_bar.widget) as pwin
			then
				pwin.move_actions.extend (agent (i_x: INTEGER; i_y: INTEGER; i_width: INTEGER; i_height: INTEGER)
							do
								update_notification_positions
							end
						)
				is_attachment_to_status_bar_completed := True
			end
		end

	is_attachment_to_status_bar_completed: BOOLEAN

feature -- Access

	status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR

	autoclose_delay_ms: INTEGER

feature -- Settings

	notifications_suspended_until: detachable DATE_TIME
	notifications_suspended: BOOLEAN

	suspend_notifications_for (a_delay_in_minutes: INTEGER)
		local
			dt: DATE_TIME
		do
			if a_delay_in_minutes <= 0 then
				notifications_suspended := True
				notifications_suspended_until := Void
			else
				notifications_suspended := False
				create dt.make_now
				dt.minute_add (a_delay_in_minutes)
				notifications_suspended_until := dt
			end
			ev_application.add_idle_action_kamikaze (agent update_status_bar)
		end

	resume_notifications
		do
			notifications_suspended_until := Void
			notifications_suspended := False
			ev_application.add_idle_action_kamikaze (agent update_status_bar)
		end

feature -- Actions

	messages_dialog: detachable ES_NOTIFICATION_STACK_DIALOG

	show_notification_messages
		local
			l_dialog: like messages_dialog
			l_scaler: EVS_DPI_SCALER
		do
			deactivate_all_windows
			l_dialog := messages_dialog
			if l_dialog = Void or else l_dialog.is_destroyed then
				create l_dialog.make (Current)
				create l_scaler.make
				l_dialog.set_size (l_scaler.scaled_size (400), l_scaler.scaled_size (400))
				messages_dialog := l_dialog
			end
			l_dialog.update
			if attached parent_window (status_bar.widget) as pwin then
				l_dialog.set_height (pwin.height)
				l_dialog.set_position (pwin.x_position + pwin.width - l_dialog.width, pwin.y_position)
--				l_dialog.show_modal_to_window (pwin)
				l_dialog.show_relative_to_window (pwin)
			else
				if l_dialog.is_show_requested then
					l_dialog.raise
				else
					l_dialog.show
				end
			end
		end

feature {NONE} -- Status bar

	update_status_bar
		local
			p: EV_PIXMAP
		do
			if attached status_bar.notifications_icon as l_icon then
				if
					attached messages as l_messages and then
					l_messages.count_of_unacknowledged_items > 0
				then
					p := pixmaps.icon_pixmaps.general_notifications_not_empty_icon
				elseif
					notifications_suspended
					or else	(attached notifications_suspended_until as dt and then (create {DATE_TIME}.make_now) <= dt)
				 then
				 	p := pixmaps.icon_pixmaps.general_notifications_suspended_icon
				else
					p := pixmaps.icon_pixmaps.general_notifications_icon
				end
				if attached status_bar.notifications_cell as cell then
					l_icon.set_background_color (cell.background_color)
				end
				l_icon.clear
				l_icon.draw_pixmap (0, 0, p)
			end
		end

feature {NOTIFICATION_S} -- Event handlers

	on_notification (m: NOTIFICATION_MESSAGE)
		local
			l_is_suspended: BOOLEAN
		do
			ensure_attachment_to_status_bar_is_completed
			record (m)
			if notifications_suspended then
				l_is_suspended := True
			elseif attached notifications_suspended_until as dt then
				if (create {DATE_TIME}.make_now) >= dt then
					resume_notifications
				else
					l_is_suspended := True
				end
			end
			if not l_is_suspended then
				ev_application.add_idle_action_kamikaze (agent show_notification (m))
			end
			ev_application.add_idle_action_kamikaze (agent update_status_bar)
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
			w, l_prev_focused_widget: EV_WIDGET
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
			a_window.set_auto_close_delay (autoclose_delay_ms)
			l_prev_focused_widget := ev_application.focused_widget
			if attached parent_window (w) as win then
				a_window.show_relative_to_window (win)
			else
				a_window.show
			end
			a_window.set_position (w.screen_x + w.width - a_window.width - 1, y - a_window.height - 1)
			ev_application.add_idle_action_kamikaze (agent update_notification_positions)
			if l_prev_focused_widget /= Void then
					-- Restore previous focus
				ev_application.add_idle_action_kamikaze (agent (i_w: EV_WIDGET)
						do
							if not i_w.is_destroyed then
								i_w.set_focus
							end
						end(l_prev_focused_widget)
					)
			end
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
					deactivate_notification (lst.first, True)
				end
			end
		end

	deactivate_notification (p: ES_NOTIFICATION_WINDOW; is_auto: BOOLEAN)
		local
			y,h: INTEGER
		do
			if not p.is_destroyed then
				h := p.height
				y := p.screen_y
			end
			notification_windows.prune (p)
			ev_application.add_idle_action_kamikaze (agent update_notification_positions)
			if not is_auto then
				p.message.mark_acknowledged
			end
			ev_application.add_idle_action_kamikaze (agent update_status_bar)
		end

	notification_windows: ARRAYED_SET [ES_NOTIFICATION_WINDOW]

feature {ES_NOTIFICATION_STACK_DIALOG} -- Archive	

	clear_messages
		do
			messages.wipe_out
			update_status_bar
		end

	refresh (m: detachable NOTIFICATION_MESSAGE)
		local
			win: detachable ES_NOTIFICATION_WINDOW
		do
			if m /= Void then
				across
					notification_windows as ic
				until
					win /= Void
				loop
					if ic.item.message = m then
						win := ic.item
					end
				end
				if win /= Void then
					win.close
				end
			end
			update_status_bar
		end

	record (a_message: NOTIFICATION_MESSAGE)
		do
			messages.put (a_message) --.to_archive)
		end

	delete (a_message: NOTIFICATION_MESSAGE)
		do
			messages.delete (a_message)
		end

	messages: ES_NOTIFICATION_STACK

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
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
