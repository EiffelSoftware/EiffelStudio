indexing
	description	: "Item for an EB_EXPLORER_BAR"
	status		: "See notice at end of class"
	keywords	: "split, area, box, header, item"
	date		: "$Date$"
	revision	: "$Revision$"

class 
	EB_EXPLORER_BAR_ITEM

inherit
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make,
	make_with_mini_toolbar,
	make_with_info

feature {NONE} -- Initialization

	make (a_parent: EB_EXPLORER_BAR; a_widget: EV_WIDGET; a_title: STRING; closeable: BOOLEAN) is
			-- Initialization
		do
			is_closeable := closeable
			is_maximizable := True
			is_minimizable := True
			generic_make (a_parent, a_widget, a_title)
		end

	make_with_mini_toolbar (
		a_parent: EB_EXPLORER_BAR; a_widget: EV_WIDGET;
		a_title: STRING; closeable: BOOLEAN;
		a_mini_toolbar: EV_TOOL_BAR) is
			-- Initialization
		do
			mini_toolbar := a_mini_toolbar
			make (a_parent, a_widget, a_title, closeable)
		end

	make_with_info (
		a_parent: EB_EXPLORER_BAR; a_widget: EV_WIDGET;
		a_title: STRING; closeable: BOOLEAN;
		info: EV_HORIZONTAL_BOX; a_mini_toolbar: EV_TOOL_BAR) is
			-- Initialization
		do
			mini_toolbar := a_mini_toolbar
			header_addon := info
			make (a_parent, a_widget, a_title, closeable)
		end

	generic_make (a_parent: EB_EXPLORER_BAR; a_widget: EV_WIDGET; a_title: STRING) is
			-- Generic Initialization
		do
				-- Set the attributes
			parent := a_parent
			widget := a_widget
			is_visible := False
			menu_name := "Explorer bar item"
			create show_actions

				-- Build the header
			build_header (a_widget, a_title)
		end

feature -- Access

	widget: EV_WIDGET
			-- Widget.

	header: EV_FRAME
		-- First item, Void if none

	associated_command: EB_TOOLBARABLE_AND_MENUABLE_COMMAND
				-- Command associated with Current.

	pixmap: ARRAY [EV_PIXMAP]
			-- Pixmap representing the item (for buttons)

	menu_name: STRING
			-- Name as it appears in menus.

	parent: EB_EXPLORER_BAR
		-- Associated outlook bar.

	explorer_bar_manager: EB_EXPLORER_BAR_MANAGER is
			-- Associated Explorer Bar manager
		do
			Result := parent.explorer_bar_manager
		end

	show_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called when the item becomes visible.

feature -- Status Report

	is_visible: BOOLEAN
			-- Is item visible?

	is_minimized: BOOLEAN
			-- Is the item minimized? (only the header is visible)

	is_maximized: BOOLEAN
			-- Is the item maximized? (obscures other items)

	is_restored: BOOLEAN is
			-- Is the item neither minimized nor maximized?
		do
			Result := not is_minimized and not is_maximized
		end

	is_closeable: BOOLEAN
			-- Is the current item closeable?

	is_maximizable: BOOLEAN
			-- Is the current item maximizable?

	is_minimizable: BOOLEAN
			-- Is the current item minimizable?

	is_text_on_button: BOOLEAN
			-- Is there a text displayed on some buttons?

feature -- Element change

	set_pixmap (a_pixmap: ARRAY [EV_PIXMAP]) is
			-- Set `pixmap' to `a_pixmap'.
		require
			valid_pixmap: a_pixmap /= Void and then a_pixmap.count = 2
		do
			pixmap := a_pixmap
		end

	set_menu_name (a_name: STRING) is
			-- Set `a_name' to `menu_name'.
		do
			menu_name := a_name
		end

	set_associated_command (a_command: like associated_command) is
			-- Set `a_command' to `associated_command'.
		do
			associated_command := a_command
		end

feature -- Status Setting

	close is
			-- Hide/Close current
		local
			selectable_command: EB_SELECTABLE
		do
			is_visible := False
			is_maximized := False
			selectable_command ?= associated_command
			if selectable_command /= Void then
				selectable_command.disable_selected
			end
			parent.on_item_hidden (Current)
		end

	show is
			-- Show current
		local
			selectable_command: EB_SELECTABLE
		do
			if not is_visible then
				is_visible := True
				show_actions.call ([])
			end
			rebuild_system_toolbar

			selectable_command ?= associated_command
			if selectable_command /= Void then
				selectable_command.enable_selected
			end
			parent.on_item_shown (Current)
		end
	
	minimize is
			-- Set the item to be minimized.
		require
			not_minimized: not is_minimized
		do
			is_minimized := True
			is_maximized := False
			rebuild_system_toolbar

				-- Notify the parent
			parent.on_item_minimized (Current)
		end

	maximize is
			-- Set the item to be maximized.
		require
			not_maximized: not is_maximized
		do
			is_maximized := True
			is_minimized := False
			rebuild_system_toolbar

				-- Notify the parent
			parent.on_item_maximized (Current)
		ensure
			maximized: is_maximized
		end

	restore is
			-- Set the item not to be minimized.
		require
			not_restored: not is_restored
		do
			is_minimized := False
			is_maximized := False
			rebuild_system_toolbar

				-- Notify the parent
			parent.on_item_restored (Current)
		ensure
			restored: is_restored
		end

	recycle is
			-- Recycle current when not needed any longer.
		local
			selectable_command: EB_SELECTABLE
		do
			if parent /= Void then
					-- `parent' = `Void' iff we are already recycled.
				is_visible := False
				is_maximized := False
				selectable_command ?= associated_command
				if selectable_command /= Void then
					selectable_command.disable_selected
				end
				parent.on_item_hidden (Current)
				parent.prune (Current)
				parent := Void
			end
		end

	disable_minimizable is
			-- Set `is_minimizable' to False
		do
			is_minimizable := False
		end

	enable_minimizable is
			-- Set `is_minimizable' to True
		do
			is_minimizable := True
		end

	disable_maximizable is
			-- Set `is_maximizable' to False
		do
			is_maximizable := False
		end

	enable_maximizable is
			-- Set `is_maximizable' to True
		do
			is_maximizable := True
		end

feature {EB_TOOL} -- Status setting

	set_parent (new_parent: EB_EXPLORER_BAR) is
			-- Define a new explorer bar as the parent.
		require
			unparented: parent = Void
		do
			parent := new_parent
			new_parent.add (Current)
			new_parent.repack_widgets
		end

feature {NONE} -- Controls

	mini_toolbar: EV_TOOL_BAR

	system_toolbar: EV_TOOL_BAR

	minimize_button: EV_TOOL_BAR_BUTTON

	maximize_button: EV_TOOL_BAR_BUTTON

	restore_button: EV_TOOL_BAR_BUTTON

	close_button: EV_TOOL_BAR_BUTTON

feature {NONE} -- Implementation

	header_addon: EV_HORIZONTAL_BOX
			-- Horizontal bar displayed in the header.

	build_header (a_widget: EV_WIDGET; a_title: STRING) is
			-- Create a header titled `a_title' for the widget `a_widget'.
			--
			-- Create a frame containing a label
			-- with text `a_title'.
		local
			title_label: EV_LABEL
			horizontal_box: EV_HORIZONTAL_BOX
			cell: EV_CELL
		do
				-- A small space
			create cell
			cell.set_minimum_width (3)
			
				-- Build the Title bar.
			create title_label
			title_label.set_text (a_title)

				-- create the system tool bar & the buttons
			build_system_toolbar

				-- Pack everything
			create horizontal_box
			horizontal_box.extend (cell)
			horizontal_box.disable_item_expand (cell)
			horizontal_box.extend (title_label)
			horizontal_box.disable_item_expand (title_label)

			if mini_toolbar /= Void then
				create cell
				cell.set_minimum_width (6)
				horizontal_box.extend (cell)
				horizontal_box.disable_item_expand (cell)
				horizontal_box.extend (mini_toolbar)
				horizontal_box.disable_item_expand (mini_toolbar)
			end

			if header_addon /= Void then
				create cell
				cell.set_minimum_width (6)
				horizontal_box.extend (cell)
				horizontal_box.disable_item_expand (cell)
				horizontal_box.extend (header_addon)
			else
				create cell
				cell.set_minimum_width (6)
				horizontal_box.extend (cell)
			end

			horizontal_box.extend (system_toolbar)
			horizontal_box.disable_item_expand (system_toolbar)

			create header
			header.set_style (Frame_constants.Ev_frame_raised)
			header.extend (horizontal_box)
		end

	build_system_toolbar is
			-- Create system toolbar and fill it.
		do
			create system_toolbar

			if is_minimizable then
				create minimize_button
				minimize_button.set_pixmap (Pixmaps.icon_minimize @ 1)
				minimize_button.enable_sensitive
				minimize_button.select_actions.extend (~minimize)
				minimize_button.set_tooltip (Interface_names.f_Minimize)

				system_toolbar.extend (minimize_button)
			end

			if is_maximizable then
				create maximize_button
				maximize_button.set_pixmap (Pixmaps.icon_maximize @ 1)
				maximize_button.enable_sensitive
				maximize_button.select_actions.extend (~maximize)
				maximize_button.set_tooltip (Interface_names.f_Maximize)

				system_toolbar.extend (maximize_button)
			end

			if is_minimizable or is_maximizable then
				create restore_button
				restore_button.set_pixmap (Pixmaps.icon_restore @ 1)
				restore_button.enable_sensitive
				restore_button.select_actions.extend (~restore)
				restore_button.set_tooltip (Interface_names.f_Restore)
			end

			create close_button
			close_button.set_pixmap (Pixmaps.icon_close @ 1)
			close_button.set_tooltip (Interface_names.f_Close)
			if is_closeable then
				close_button.enable_sensitive
				close_button.select_actions.extend (~close)
			else
				close_button.disable_sensitive
			end

			system_toolbar.extend (close_button)
		end

	rebuild_system_toolbar is
			-- Update buttons in `system_toolbar'.
		do
			system_toolbar.wipe_out
			if is_minimizable and then not is_minimized then
				system_toolbar.extend (minimize_button)
			end
			if (is_minimizable or is_maximizable) and then not is_restored then
				system_toolbar.extend (restore_button)
			end
			if is_maximizable and then not is_maximized then
				system_toolbar.extend (maximize_button)
			end
			system_toolbar.extend (close_button)
		end

feature {NONE} -- Constants

	Frame_constants: EV_FRAME_CONSTANTS is
		once
			create Result
		end

invariant
	closed_implies_not_maximized: not is_visible implies not is_maximized
	not_minimized_and_maximized: not (is_minimized and is_maximized)

end -- class EB_EXPLORER_BAR_ITEM

