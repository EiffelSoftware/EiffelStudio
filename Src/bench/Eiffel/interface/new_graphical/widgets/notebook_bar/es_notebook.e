indexing
	description : "Objects that represent a notebook tools container"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	ES_NOTEBOOK

inherit
	EB_EXPLORER_BAR_ATTACHABLE
		redefine
			change_attach_explorer
		end

feature {NONE} -- Initialization

	make (a_title: like title; a_menu_name: like menu_name; a_pixmap: like pixmap) is
		do
			title := a_title
			menu_name := a_menu_name
			pixmap := a_pixmap
			create items.make (3)
			build_interface
		end

	build_interface is
		local
			box: EV_VERTICAL_BOX
		do
			create box
			create notebook
			notebook.set_tab_position (notebook.tab_bottom)
			box.extend (notebook)
			widget := box
			notebook.selection_actions.extend (agent on_tab_selected)
			notebook.drop_actions.extend (agent on_dropped_stone)
			notebook.drop_actions.set_veto_pebble_function (agent on_dropped_stone_veto)
			notebook.pointer_button_press_actions.extend (agent on_pointer_button_press)
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			create header_box
			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_info (
				explorer_bar, widget, title, False, header_box, Void
			)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

feature -- Access

	title: STRING

	menu_name: STRING

	pixmap: EV_PIXMAP

	header_box: EV_HORIZONTAL_BOX

	selected_item: ES_NOTEBOOK_ITEM

	pointed_item: ES_NOTEBOOK_ITEM is
			-- Pointer notebook item.
		local
			i: INTEGER
			w: EV_WIDGET
		do
			i := notebook.pointed_tab_index
			if i /= 0 then
				w := notebook.i_th (i)
				if w /= Void then
					Result := item_by_widget (w)
				end
			end
		end

	item_by_widget (w: EV_WIDGET): ES_NOTEBOOK_ITEM is
			-- Notebook item corresponding to `w'.
		require
			valid_item_widget (w)
		local
			cursor: DS_HASH_TABLE_CURSOR [EV_WIDGET, ES_NOTEBOOK_ITEM]
			tabw: EV_WIDGET
		do
			tabw := w
			from
				cursor := items.new_cursor
				cursor.start
			until
				cursor.after or Result /= Void
			loop
				if
					not cursor.item.is_destroyed
					and then cursor.item = tabw
				then
					Result := cursor.key
				end
				cursor.forth
			end
		end

	item_by_index (i: INTEGER): ES_NOTEBOOK_ITEM is
			-- Notebook item corresponding to index `i'.
		require
			valid_notebook_index (i)
		local
			tabw: EV_WIDGET
		do
			if valid_notebook_index (i) then
				tabw := notebook.i_th (i)
				if valid_item_widget (tabw) then
					Result := item_by_widget (tabw)
				end
			end
		end

	item_by_tab (tab: EV_NOTEBOOK_TAB): ES_NOTEBOOK_ITEM is
			-- Notebook item corresponding to `tab'.
		require
			tab_not_void: tab /= Void
			tab_not_destroyed: not tab.is_destroyed
		local
			tabw: EV_WIDGET
		do
			tabw := tab.widget
			if valid_item_widget (tabw) then
				Result := item_by_widget (tabw)
			end
		end

	item_by_title (t: STRING): ES_NOTEBOOK_ITEM is
		require
			title_valid: t /= Void
		local
			cursor: DS_HASH_TABLE_CURSOR [EV_WIDGET, ES_NOTEBOOK_ITEM]
		do
			from
				cursor := items.new_cursor
				cursor.start
			until
				cursor.after or Result /= Void
			loop
				Result := cursor.key
				if Result /= Void then
					if not Result.title.is_equal (t) then
						Result := Void
					end
				end
				cursor.forth
			end
		end

	widget: EV_WIDGET

feature -- Status

	valid_notebook_index (i: INTEGER): BOOLEAN is
		do
			Result := notebook.valid_index (i)
		end

	valid_item_widget (w: EV_WIDGET): BOOLEAN is
		do
			Result := items.has_item (w)
		end

feature -- Change

	extend (t: ES_NOTEBOOK_ITEM) is
		local
			tw: EV_WIDGET
			tab: EV_NOTEBOOK_TAB
		do
			tw := t.tab_widget
			notebook.extend (tw)
			tab := notebook.item_tab (tw)
			tab.set_text (t.title)
			t.set_tab (tab)
			items.force (tw, t)
			update
		end

	prune (t: ES_NOTEBOOK_ITEM) is
		do
			items.remove (t)
			notebook.prune (t.tab_widget)
		end

	update is
		do
			update_selected_item
			if selected_item /= Void then
				update_header_box
				update_mini_toolbar
			end
		end

	update_selected_item is
		local
			w: EV_WIDGET
		do
			w := notebook.selected_item
			if w /= Void then
				selected_item := item_by_widget (w)
			else
				selected_item := Void
			end
		end

	update_header_box is
		require
			selected_item /= Void
		local
			par: EV_CONTAINER
			hbox: EV_HORIZONTAL_BOX
		do
			header_box.wipe_out
			hbox := selected_item.header_box
			if explorer_bar_item /= Void and then hbox /= Void then
				par := hbox.parent
				if par /= Void then
					par.prune_all (hbox)
				end
				check
					hbox.parent = Void
				end
				header_box.extend (hbox)
			end
		end

	update_mini_toolbar	is
		require
			selected_item /= Void
		local
			par: EV_CONTAINER
			mtb: EV_TOOL_BAR
		do
			mtb := selected_item.mini_toolbar
			if explorer_bar_item /= Void and then mtb /= Void then
				par := mtb.parent
				if par /= Void then
					par.prune_all (mtb)
				end
				check
					mtb.parent = Void
				end
				explorer_bar_item.update_mini_toolbar (mtb)
			end
		end

	change_attach_explorer (an_explorer_bar: EB_EXPLORER_BAR) is
			-- Change the window and explorer bar `Current' is in.
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
				-- Link with the manager and the explorer.
			set_explorer_bar (an_explorer_bar)
		end

feature {NONE} -- tab selection

	on_tab_selected	is
		do
			update
		end

	on_pointer_button_press (ax, ay, ab: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
		local
			ni: ES_NOTEBOOK_ITEM
		do
			ni := pointed_item
			if ni /= Void then
				ni.pointer_button_pressed_actions.call ([ax, ay, ab, x_tilt, y_tilt, pressure, screen_x, screen_y])
			end
		end

feature {NONE} -- Drop action

	on_dropped_stone (a_data: ANY) is
		local
			pointed_w: EV_WIDGET
			t: ES_NOTEBOOK_ITEM
		do
			t := pointed_notebook_item
			if t /= Void then
				pointed_w := t.widget
				t.tab.enable_select
				t.drop_actions.call ([a_data])
			end
		end

	on_dropped_stone_veto (a: ANY): BOOLEAN is
		local
			t: ES_NOTEBOOK_ITEM
		do
			t := pointed_notebook_item
			if t /= Void then
				if t.drop_actions.accepts_pebble (a) then
					Result := t.drop_actions.veto_pebble_function = Void
						or else t.drop_actions.veto_pebble_function.item ([a])
				end
			end
		end

	pointed_notebook_item: ES_NOTEBOOK_ITEM is
		local
			pointed_w: EV_WIDGET
			i: INTEGER
		do
			i := notebook.pointed_tab_index
			if notebook.valid_index (i) then
				pointed_w := notebook.i_th (i)
				Result := item_by_widget (pointed_w)
			end
		end

feature {NONE} -- Implementation

	items: DS_HASH_TABLE [EV_WIDGET, ES_NOTEBOOK_ITEM]
			-- [notebook item -> tab widget]

	notebook: EV_NOTEBOOK;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
