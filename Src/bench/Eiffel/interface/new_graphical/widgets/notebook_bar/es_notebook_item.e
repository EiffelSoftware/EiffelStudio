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
	make_with_mini_toolbar,
	make_with_info

feature {NONE} -- Initialization

	make (a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET; a_title: STRING) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
		do
			generic_make (a_parent, a_widget, a_title)
		end

	make_with_mini_toolbar (
		a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET;
				a_title: STRING; a_mini_toolbar: EV_TOOL_BAR) is
			-- Initialization
		require else
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
			mini_toolbar_not_void: a_mini_toolbar /= Void
		do
			mini_toolbar := a_mini_toolbar
			make (a_parent, a_widget, a_title)
		end
		
	make_with_info (
		a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET;
				a_title: STRING; info: EV_HORIZONTAL_BOX; a_mini_toolbar: EV_TOOL_BAR) is
			-- Initialization
		require else
			parent_not_void: a_parent /= Void
			widget_not_void: a_widget /= Void
			title_not_void: a_title /= Void
			header_not_void: info /= Void
		do
			mini_toolbar := a_mini_toolbar
			header_box   := info
			make (a_parent, a_widget, a_title)
		end

	generic_make (a_parent: ES_NOTEBOOK; a_widget: EV_WIDGET; a_title: STRING) is
			-- Generic Initialization
		require
			a_parent_not_void: a_parent /= Void
			a_widget_not_void: a_widget /= Void
			a_title_not_void: a_title /= Void
		local
			hb: EV_HORIZONTAL_BOX
			content_box: EV_VERTICAL_BOX
			tab_cell: EV_CELL
			left_handle: EV_LABEL
		do
			create selection_actions
			create drop_actions

				--| Set the attributes
			parent := a_parent
			widget := a_widget
			title := a_title
			
			create tab_cell
			tab_widget := tab_cell

			create hb
			create left_handle
			left_handle.set_minimum_width (15)
			left_handle.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (212, 208, 200))
			hb.extend (left_handle)
			hb.disable_item_expand (left_handle)
			create content_box
			content_box.extend (widget)
			hb.extend (content_box)

			tab_cell.extend (hb)

			left_handle.set_tooltip ("Use me to dock this tool out")
			docking_handle := left_handle
			docking_handle.enable_dockable
			docking_handle.dock_started_actions.extend (agent dock_start (Current))
			docking_handle.dock_ended_actions.extend (agent dock_end (Current))
			docking_handle.set_real_source (hb)
			
			show_docking_handle (False) --| by default don't show the docking grid
		end
		
feature -- Access

	hash_code: INTEGER is
		do
			Result := title.hash_code
		end

	title: STRING

	mini_toolbar: EV_TOOL_BAR
	
	header_box: EV_HORIZONTAL_BOX

	parent: ES_NOTEBOOK

	tab: EV_NOTEBOOK_TAB
	
	selection_actions: EV_NOTIFY_ACTION_SEQUENCE

	drop_actions: EV_PND_ACTION_SEQUENCE

	docking_handle_visible: BOOLEAN is
		do
			Result := docking_handle /= Void and then docking_handle.is_show_requested
		end
		
	is_selected: BOOLEAN is
		do
			Result := parent.selected_item = Current
		end

feature -- Change

	show_docking_handle (v: BOOLEAN) is
		do
			if v then
				docking_handle.show
			else
				docking_handle.hide
			end
		end

	close is
		do
			parent.prune (Current)
			tab := Void
		end	

feature {ES_NOTEBOOK} -- Implementation

	docking_handle: EV_WIDGET

	widget: EV_WIDGET

	tab_widget: EV_CELL

feature {NONE} -- Docking

	docked_handle_visible: BOOLEAN

	docked_in_witdh: INTEGER
	docked_in_height: INTEGER

	docked_out_witdh: INTEGER
	docked_out_height: INTEGER

	dock_start (nbi: ES_NOTEBOOK_ITEM) is
		do
			docked_handle_visible := docking_handle_visible
			docked_in_witdh := tab_widget.width
			docked_in_height := tab_widget.height

			nbi.parent.dock_it_out (nbi)
		end

	dock_end (nbi: ES_NOTEBOOK_ITEM) is
		local
			ddlg: EV_DOCKABLE_DIALOG
			lw, lh: INTEGER
			content_box: EV_BOX
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
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

				create hb
				content_box ?= widget.parent
				if content_box /= Void then
					content_box.put_front (hb)
					content_box.disable_item_expand (hb)
					hb.set_padding (2)
					hb.set_border_width (2)

					create lab.make_with_text (title)
					hb.extend (lab)
					hb.disable_item_expand (lab)					
					
					if mini_toolbar /= Void then
							--| here we suppose the generic_make always add the content_box the way it is now
							--| and when we dock this item back to other place ..
							--| it will remove and put the minitoolbar somewhere else
						hb.extend (mini_toolbar)
						hb.disable_item_expand (mini_toolbar)					
					end
					if header_box /= Void then
							--| here we suppose the generic_make always add the content_box the way it is now
							--| and when we dock this item back to other place ..
							--| it will remove and put the header_box somewhere else
						hb.extend (header_box)
					end
				end
				show_docking_handle (False)
				docking_handle.disable_dockable
			end
		end

	dock_resized (ax, ay, awidth, aheight: INTEGER) is
		do
			docked_out_witdh := awidth
			docked_out_height := aheight
			show_docking_handle (False)
		end

feature {ES_NOTEBOOK} -- Docking

	on_dock_back (nbi: ES_NOTEBOOK_ITEM) is
		do
			tab_widget.docked_actions.wipe_out
			nbi.parent.dock_it_back (nbi)
			
			docking_handle.enable_dockable
			show_docking_handle (docked_handle_visible)
		end

feature {ES_NOTEBOOK} -- Restricted access

	set_tab (t: like tab) is
		do
			tab := t
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
