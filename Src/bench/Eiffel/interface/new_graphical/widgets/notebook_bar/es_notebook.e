indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_NOTEBOOK

create
	make

feature  -- Init

	make is
		do
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
			notebook.drop_actions.extend (agent on_dropped_stone)
			create {EV_VERTICAL_BOX} docking_box
			box.extend (docking_box)
			box.disable_item_expand (docking_box)
			docking_box.hide
			docking_box.docked_actions.extend (agent on_docked_event)
		end

feature -- Drop action

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
				t := item (i) -- maybe index can change ??
				t.drop_actions.call ([a_data])
			end
		end

feature -- Dock item action

	on_docked_event (s: EV_DOCKABLE_SOURCE) is
		do
		end

	dock_it_out (nbi: ES_NOTEBOOK_ITEM) is
		local
			wbox: EV_BOX
			tbox: EV_CELL
		do
			wbox ?= docking_box
			check wbox /= Void end
			tbox ?= nbi.tab_widget
			check tbox /= Void end

			notebook.prune (tbox)
			docking_box.extend (tbox)
			docking_box.disable_item_expand (tbox)
			tbox.docked_actions.force_extend (agent nbi.on_dock_back (nbi))
--			nbi.tab_widget.hide
		end
		
	dock_it_back (nbi: ES_NOTEBOOK_ITEM) is
		local
			wbox: EV_BOX
			tbox: EV_CELL
		do
			wbox ?= docking_box
			check wbox /= Void end
			tbox ?= nbi.tab_widget
			check tbox /= Void end

			wbox.prune (tbox)
			tbox.docked_actions.wipe_out
			extend (nbi)
--			nbi.tab_widget.hide
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
			items.force (t, notebook.index_of (tw, 1))
		end

	prune (t: ES_NOTEBOOK_ITEM) is
		do
			notebook.prune (t.tab_widget)
		end

	item_tab (w: EV_WIDGET): EV_NOTEBOOK_TAB is
		do
			Result := notebook.item_tab (w)
		end

feature -- Access

	item (i: INTEGER): ES_NOTEBOOK_ITEM is
		require
		do
			Result := items.item (i)
		end

	items: DS_HASH_TABLE [ES_NOTEBOOK_ITEM, INTEGER]

	widget: EV_WIDGET
	notebook: EV_NOTEBOOK
	
	docking_box: EV_BOX

end
