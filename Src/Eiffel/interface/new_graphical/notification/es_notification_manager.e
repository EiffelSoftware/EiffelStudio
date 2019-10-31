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
			create popup_list.make (5)
		end

feature -- Access

	status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR

	delay_ms: INTEGER = 10_000

feature -- Actions

	show_notification_messages
		do
			on_notification (create {NOTIFICATION_MESSAGE}.make ("Not Yet implemeted!"))
		end

feature {NOTIFICATION_S} -- Event handlers

	on_notification (m: NOTIFICATION_MESSAGE)
		do
			ev_application.add_idle_action_kamikaze (agent popup_notification (m))
		end

	popup_notification (m: NOTIFICATION_MESSAGE)
		local
			popup: EV_POPUP_WINDOW
			lab: EVS_LABEL
			t: EV_TIMEOUT
			w: EV_WIDGET
			vb, fr: EV_VERTICAL_BOX
		do
			create popup.make_with_shadow
			create lab.make_with_text (m.text)
			lab.set_is_text_wrapped (True)
			lab.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (200))

			create fr
			popup.extend (fr)
			fr.set_background_color (colors.stock_colors.blue)
			fr.set_padding_width (3)
			fr.set_border_width (3)

			create vb
			vb.set_border_width (10)
			fr.extend (vb)

			vb.extend (lab)
			vb.set_background_color (colors.stock_colors.white)
			vb.set_foreground_color (colors.stock_colors.blue)
			vb.propagate_background_color
			vb.propagate_foreground_color

			activate_popup (popup, <<lab>>)
		end

	activate_popup (a_popup: EV_POPUP_WINDOW; a_contents: detachable ITERABLE [EV_WIDGET])
		local
			t: EV_TIMEOUT
			w: EV_WIDGET
			y,ny: INTEGER
		do
			w := status_bar.widget
			y := w.screen_y + w.height
			across
				popup_list as ic
			loop
				ny := ic.item.screen_y
				if ny < y then
					y := ny
				end
			end
			popup_list.force (a_popup)
			create t
			a_popup.set_data (t)
			if a_contents /= Void then
				across
					a_contents as ic
				loop
					ic.item.pointer_double_press_actions.extend (agent (p: EV_WINDOW; i_t: EV_TIMEOUT;
								i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
							do
								i_t.destroy
								deactivate_popup (p)
							end(a_popup,t,?,?,?,?,?,?,?,?)
						)
				end
			end
			t.actions.extend (agent (p: EV_WINDOW; i_t: EV_TIMEOUT)
					do
						i_t.destroy
						deactivate_popup (p)
					end (a_popup, t)
				)
			if attached parent_window (w) as win then
				a_popup.show_relative_to_window (win)
			else
				a_popup.show
			end
			a_popup.set_position (w.screen_x + w.width - a_popup.width, y - a_popup.height - 1)
			t.set_interval (delay_ms)
			ev_application.add_idle_action_kamikaze (agent update_notification_positions)
		end

	update_notification_positions
		local
			x,y,h, min_y: INTEGER
			pwin, win: EV_WINDOW
			sep_size: INTEGER
		do
			sep_size := {EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (3)
			if attached status_bar.widget as w then
				x := w.screen_x + w.width
				y := w.screen_y
				pwin := parent_window (w)
				if pwin /= Void then
					min_y := pwin.screen_y + (pwin.height * 3) // 10 -- Max 3/10 of the parent Window height
				end
			end
			across
				popup_list as ic
			loop
				win := ic.item
				if not win.is_destroyed then
					y := (y - win.height - sep_size).max (min_y)
					win.set_position (x - win.width, y)
				end
			end
		end

	deactivate_popup (p: EV_WINDOW)
		local
			y,h: INTEGER
		do
			if not p.is_destroyed then
				h := p.height
				y := p.screen_y
				p.destroy
			end
			popup_list.prune (p)
			ev_application.add_idle_action_kamikaze (agent update_notification_positions)
		end

	popup_list: ARRAYED_SET [EV_WINDOW]

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
