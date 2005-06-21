indexing
	description : "Objects that represent a notebook tools container"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_NOTEBOOK
	
inherit
	EB_EXPLORER_BAR_ATTACHABLE
		redefine
			change_attach_explorer
		end

create
	make

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
			notebook.pointer_button_press_actions.extend (agent on_pointer_button_press)
			create {EV_VERTICAL_BOX} docking_box
			box.extend (docking_box)
			box.disable_item_expand (docking_box)
			docking_box.hide
			docking_box.docked_actions.extend (agent on_docked_event)
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

	pixmap: ARRAY [EV_PIXMAP]
	
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
					Result := item_by_tab (notebook.item_tab (w))
				end
			end
		end

	item_by_tab (tab: EV_NOTEBOOK_TAB): ES_NOTEBOOK_ITEM is
			-- Notebook item corresponding to `tab'.
		require
			tab_not_void: tab /= Void
			tab_not_destroyed: not tab.is_destroyed
		local
			cursor: DS_HASH_TABLE_CURSOR [EV_NOTEBOOK_TAB, ES_NOTEBOOK_ITEM]
			tabw: EV_WIDGET
		do
			tabw := tab.widget
			from
				cursor := items.new_cursor
				cursor.start
			until
				cursor.after or Result /= Void
			loop
				if 
					not cursor.item.is_destroyed
					and then cursor.item.widget = tabw
				then
					Result := cursor.key
				end
				cursor.forth
			end
		end

	item_by_title (t: STRING): ES_NOTEBOOK_ITEM is
		require
			title_valid: t /= Void
		local
			cursor: DS_HASH_TABLE_CURSOR [EV_NOTEBOOK_TAB, ES_NOTEBOOK_ITEM]
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
			items.force (tab, t)
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
				selected_item := item_by_tab (notebook.item_tab (w))
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
		do
			if ab = 3 then --| Right click
				open_notebook_menu
			end
		end
		
	open_notebook_menu is
			-- Open menu related to the pointed tool
		local
			m: EV_MENU
			mci: EV_CHECK_MENU_ITEM
			ni: ES_NOTEBOOK_ITEM
		do
			create m.make_with_text (title)
			ni := pointed_item
			if ni /= Void then
				create mci.make_with_text ("Display docking grip on " + ni.title)
				if ni.docking_handle_visible then
					mci.enable_select
				end
				mci.select_actions.extend (agent ni.show_docking_handle (not ni.docking_handle_visible))
				m.extend (mci)
			end
			m.show
		end
	
feature {NONE} -- Drop action

	on_dropped_stone (a_data: ANY) is
		local
			pointed_w: EV_WIDGET
			i: INTEGER
			t: ES_NOTEBOOK_ITEM
		do
			i := notebook.pointed_tab_index
			if notebook.valid_index (i) then
				pointed_w := notebook.i_th (i)
				notebook.item_tab (pointed_w).enable_select
				t := item_by_tab (notebook.item_tab (pointed_w))
				t.drop_actions.call ([a_data])
			end
		end

feature {NONE} -- Dock item action

	on_docked_event (s: EV_DOCKABLE_SOURCE) is
		do
		end
		
feature {ES_NOTEBOOK_ITEM} -- exported Dock item action

	dock_it_out (nbi: ES_NOTEBOOK_ITEM) is
		local
			tcell: EV_CELL
			par: EV_CONTAINER
		do
			tcell ?= nbi.tab_widget
			check tcell /= Void end
			
			notebook.prune (tcell)
			docking_box.extend (tcell)
			if nbi.mini_toolbar /= Void then
				par := nbi.mini_toolbar.parent
				if par /= Void then
					par.prune_all (nbi.mini_toolbar)
				end
			end
			if nbi.header_box /= Void then
				par := nbi.header_box.parent
				if par /= Void then
					par.prune_all (nbi.header_box)
				end
			end
			tcell.docked_actions.force_extend (agent nbi.on_dock_back (nbi))
		end
		
	dock_it_back (nbi: ES_NOTEBOOK_ITEM) is
		local
			wbox: EV_BOX
			tcell: EV_CELL
		do
			wbox ?= docking_box
			check wbox /= Void end
			tcell ?= nbi.tab_widget
			check tcell /= Void end

			wbox.prune (tcell)
			tcell.docked_actions.wipe_out
			extend (nbi)
			nbi.tab.enable_select
		end

feature {NONE} -- Implementation

	items: DS_HASH_TABLE [EV_NOTEBOOK_TAB, ES_NOTEBOOK_ITEM]

	notebook: EV_NOTEBOOK
	
	docking_box: EV_BOX
	
end
