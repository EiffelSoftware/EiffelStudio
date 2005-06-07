indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_NOTEBOOK_ITEM

inherit
	HASHABLE

create
	make,
	make_with_mini_toolbar

feature {NONE} -- Initialization

	make (a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET; a_docking_handle: EV_DOCKABLE_SOURCE; a_title: STRING) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
		do
			generic_make (a_parent, a_widget, a_docking_handle, a_title)
		end

	make_with_mini_toolbar (
		a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET; a_docking_handle: EV_DOCKABLE_SOURCE;
		a_title: STRING; a_mini_toolbar: EV_TOOL_BAR) is
			-- Initialization
		require else
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
			mini_toolbar_not_void: a_mini_toolbar /= Void
		do
			mini_toolbar := a_mini_toolbar
			make (a_parent, a_widget, a_docking_handle, a_title)
		end

	generic_make (a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET; a_docking_handle: EV_DOCKABLE_SOURCE; a_title: STRING) is
			-- Generic Initialization
		require
			a_parent_not_void: a_parent /= Void
			a_widget_not_void: a_widget /= Void
			a_title_not_void: a_title /= Void
		local
			hb: EV_HORIZONTAL_BOX
			tab_cell: EV_CELL
			left_handle: EV_CELL
		do
			create drop_actions

				--| Set the attributes
			parent := a_parent
			widget := a_widget
			docking_handle := a_docking_handle
			title := a_title
			
			create tab_cell
			tab_widget := tab_cell

			create hb
			create left_handle
			left_handle.set_minimum_width (8)
			left_handle.set_background_color ((create {EV_STOCK_COLORS}).grey)
			hb.extend (left_handle)
			hb.disable_item_expand (left_handle)
			hb.extend (widget)

			tab_cell.extend (hb)

			if docking_handle = Void then
				docking_handle := left_handle
			end
				
			docking_handle.enable_dockable
			docking_handle.dock_started_actions.extend (agent dock_start (Current))
			docking_handle.dock_ended_actions.extend (agent dock_end (Current))
			docking_handle.set_real_source (hb)
		end
		
feature -- Access

	hash_code: INTEGER is
		do
			Result := title.hash_code
		end

	title: STRING

	mini_toolbar: EV_TOOL_BAR

	parent: ES_NOTEBOOK

	tab: EV_NOTEBOOK_TAB

	drop_actions: EV_PND_ACTION_SEQUENCE

feature {ES_NOTEBOOK} -- Implementation

	docking_handle: EV_DOCKABLE_SOURCE

	widget: EV_WIDGET

	tab_widget: EV_CELL

feature {NONE} -- Docking

	docked_in_witdh: INTEGER
	docked_in_height: INTEGER

	docked_out_witdh: INTEGER
	docked_out_height: INTEGER

	dock_start (nbi: ES_NOTEBOOK_ITEM) is
		do
			docked_in_witdh := tab_widget.width
			docked_in_height := tab_widget.height

			nbi.parent.dock_it_out (nbi)
		end

	dock_end (nbi: ES_NOTEBOOK_ITEM) is
		local
			ddlg: EV_DOCKABLE_DIALOG
			lw, lh: INTEGER
		do
			ddlg := parent_dockable_dialog (widget)
			if ddlg /= Void then
				if docked_out_witdh = 0 then
					lw := docked_in_witdh
				else
					lw := docked_out_witdh
				end
				if docked_out_height = 0 then
					lh := docked_in_height
				else
					lh := docked_out_height
				end
				ddlg.set_size (lw, lh)
				ddlg.resize_actions.extend (agent dock_resized)

				docking_handle.disable_dockable
			end
		end

	dock_resized (ax, ay, awidth, aheight: INTEGER) is
		do
			docked_out_witdh := awidth
			docked_out_height := aheight
		end

feature {ES_NOTEBOOK} -- Docking

	on_dock_back (nbi: ES_NOTEBOOK_ITEM) is
		do
			tab_widget.docked_actions.wipe_out
			nbi.parent.dock_it_back (nbi)
			
			docking_handle.enable_dockable
		end

feature {ES_NOTEBOOK} -- Restricted access

	set_tab (t: like tab) is
		do
			tab := t
		end

feature -- Change

	close is
		do
			parent.prune (Current)
			tab := Void
		end
		
feature {NONE} -- Implementation

	parent_dockable_dialog (w: EV_WIDGET): EV_DOCKABLE_DIALOG is
			-- `Result' is dialog parent of `widget'.
			-- `Void' if none.
		require
			widget_not_void: w /= Void
		local
			dialog: EV_DOCKABLE_DIALOG
		do
			dialog ?= w.parent
			if dialog = Void then
				if w.parent /= Void then
					Result := parent_dockable_dialog (w.parent)
				end
			else
				Result := dialog
			end
		end

end
