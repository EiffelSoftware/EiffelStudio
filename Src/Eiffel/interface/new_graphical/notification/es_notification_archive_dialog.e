note
	description: "Summary description for {ES_NOTIFICATION_ARCHIVE_DIALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NOTIFICATION_ARCHIVE_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
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
			lab: EV_LABEL
		do
			Precursor
			create vb
			extend (vb)
			create g
			g.set_column_count_to (2)
			g.column (1).set_title ("Message")
			g.column (2).set_title ("Time")
			grid := g
			vb.extend (g)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding_width (2)
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
		end

feature -- Access

	manager: ES_NOTIFICATION_MANAGER

	grid: ES_GRID

feature -- Action

	clear
		do
			manager.clear_message_archive
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
			glab: EV_GRID_LABEL_ITEM
			r: INTEGER
		do
			g := grid

			if attached manager.message_archive as l_archive then
				lst := l_archive.linear
				g.set_row_count_to (lst.count)
				across
					lst.new_cursor.reversed as ic
				loop
					r := r + 1
					create glab.make_with_text (ic.item.date.out)
					g.set_item (2, r, glab)

					create glab.make_with_text (ic.item.text)
					g.set_item (1, r, glab)
				end
				g.set_auto_resizing_column (1, True)
				g.enable_auto_size_best_fit_column (1)
			end
		end

invariant

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
