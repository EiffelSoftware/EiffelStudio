indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_NOTEBOOK

create
	make

feature {NONE} -- Initialization

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

feature -- Access

	item_by_tab (tab: EV_NOTEBOOK_TAB): ES_NOTEBOOK_ITEM is
		require
			tab /= Void
		local
			cursor: DS_HASH_TABLE_CURSOR [EV_NOTEBOOK_TAB, ES_NOTEBOOK_ITEM]
		do
			from
				cursor := items.new_cursor
				cursor.start
			until
				cursor.after or Result /= Void
			loop
				if cursor.item.widget = tab.widget then
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
		end

	prune (t: ES_NOTEBOOK_ITEM) is
		do
			items.remove (t)
			notebook.prune (t.tab_widget)
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

feature {NONE} -- Implementation

	items: DS_HASH_TABLE [EV_NOTEBOOK_TAB, ES_NOTEBOOK_ITEM]

	notebook: EV_NOTEBOOK
	
	docking_box: EV_BOX

end
