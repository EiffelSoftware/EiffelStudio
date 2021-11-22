note
	description: "Summary description for {ES_NOTIFICATION_STACK_DIALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NOTIFICATION_STACK_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	ES_SHARED_FONTS_AND_COLORS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_notif_manager: like manager)
		do
			manager := a_notif_manager
			make_with_title ("Notification messages...")
		end

	initialize
		local
			vb: EV_VERTICAL_BOX
			g: like grid
			but: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			cl: EV_CELL
		do
			Precursor
			create vb
			extend (vb)
			create cl
			display_cell := cl
			create g
			g.set_column_count_to (3)
			g.column (column_message).set_title ("Message")
			g.column (column_time).set_title ("Time")
			g.column (column_category).set_title ("Category")
			grid := g
			vb.extend (g)

			vb.extend (cl)
			vb.disable_item_expand (cl)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding_width (2)

			debug ("es_notification")
				create but.make_with_text_and_action ("Debug", agent
						do
							if attached manager.notification_s.service as notif then
								notif.notify_message ("TEST Notif", "debug")
							end
						end)
				hb.extend (but)
				hb.disable_item_expand (but)
			end

			create but.make_with_text_and_action ("Clear", agent clear)
			hb.extend (but)
			hb.disable_item_expand (but)
			create but.make_with_text_and_action ("Refresh", agent update)
			hb.extend (but)
			hb.disable_item_expand (but)
			create but.make_with_text_and_action ("Close", agent close)
			hb.extend (but)
			hb.disable_item_expand (but)
			set_default_cancel_button (but)

			g.enable_single_row_selection
			g.key_press_actions.extend (agent key_pressed_on_grid (g, ?))
		end

	column_message: INTEGER = 1
	column_time: INTEGER = 2
	column_category: INTEGER = 3

feature -- Access

	manager: ES_NOTIFICATION_MANAGER

	grid: ES_GRID

	display_cell: EV_CELL

feature -- Action

	clear
		do
			manager.clear_messages
			update
		end

	close
		do
			hide
		end

	update
		local
			lst: LIST [NOTIFICATION_MESSAGE]
			g: like grid
			r: INTEGER
		do
			g := grid
			g.wipe_out
			g.set_column_count_to (3)
			g.column (column_message).set_title ("Message")
			g.column (column_time).set_title ("Time")
			g.column (column_category).set_title ("Category")
			g.set_row_count_to (0)

			if attached manager.messages as l_messages then
				lst := l_messages.linear
				g.set_row_count_to (lst.count)
				across
					lst.new_cursor.reversed as ic
				loop
					r := r + 1
--					g.insert_new_row (r)
					fill_notification_row (g.row (r), ic.item)
				end
--				g.item_select_actions.extend (agent on_item_selected)
				g.row_select_actions.extend (agent on_row_selected)
				g.row_deselect_actions.extend (agent on_row_deselected)

				g.set_auto_resizing_column (column_message, True)
				g.set_auto_resizing_column (column_category, True)
				g.enable_auto_size_best_fit_column (column_message)
			end
		end

	fill_notification_row (a_row: EV_GRID_ROW; a_message: NOTIFICATION_MESSAGE)
		local
			glab: EV_GRID_LABEL_ITEM
			m: IMMUTABLE_STRING_32
		do
			a_row.set_data (a_message)
			m := a_message.text
			if attached a_message.title as l_title then
				m := l_title + "%N" + m
			end
			create glab.make_with_text (m)
			a_row.set_item (column_message, glab)
			if not a_message.is_acknowledged then
				glab.set_font (fonts.highlighted_label_font)
			end

			create glab.make_with_text (a_message.category)
			a_row.set_item (column_category, glab)

			create glab.make_with_text (a_message.date.out)
			a_row.set_item (column_time, glab)
		end

	key_pressed_on_grid (g: EV_GRID; k: EV_KEY)
		do
			if
				k.code = {EV_KEY_CONSTANTS}.key_delete and then
				attached g.selected_rows as lst and then
				not lst.is_empty
			then
				across
					lst as ic
				loop
					if attached {NOTIFICATION_MESSAGE} ic.item.data as l_message then
						manager.delete (l_message)
						ic.item.hide
						ic.item.set_data (Void)
					end
				end
				display_cell.wipe_out
				ev_application.add_idle_action_kamikaze (agent manager.refresh (Void))
			end
		end

	on_row_deselected (a_row: EV_GRID_ROW)
		do
			display_cell.wipe_out
			if attached {NOTIFICATION_MESSAGE} a_row.data as l_message then
				if not l_message.is_acknowledged then
					l_message.mark_acknowledged
					ev_application.add_idle_action_kamikaze (agent manager.refresh (l_message))
				end
				ev_application.add_idle_action_kamikaze (agent fill_notification_row (a_row, l_message))
			end
		end

	on_row_selected (a_row: EV_GRID_ROW)
		local
			w: ES_NOTIFICATION_WIDGET
		do
			if
				attached a_row.parent as g and then
				attached {NOTIFICATION_MESSAGE} a_row.data as l_message
			then
				create w.make (l_message)
				display_cell.wipe_out
				display_cell.extend (w)

				if not l_message.is_acknowledged then
					l_message.mark_acknowledged
					ev_application.add_idle_action_kamikaze (agent manager.refresh (l_message))
				end
				w.set_terminate_action (agent fill_notification_row (a_row, l_message))
			end
		end

invariant

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
