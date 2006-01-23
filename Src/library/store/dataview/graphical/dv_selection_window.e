indexing
	description: "Windows that enable to select a%
		%database table row."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_SELECTION_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			show,
			hide
		end

	DB_TABLES_ACCESS_USE
		undefine
			default_create,
			copy
		end

	DV_MESSAGES
		undefine
			default_create,
			copy
		end

create
	make

feature -- Initialization

	make is
			-- Create the window and the status bar.
		do
			default_create
			close_request_actions.extend (agent hide)
		end

	set_display_list (display_l: DV_TABLEROW_MULTILIST) is
				-- Set selection list to `display_list'.
		require
			not_void: display_l /= Void
		do
			display_list := display_l
		end

	set_content is
			-- Set window widgets.
		do
			create_widgets
		end

feature -- Access

	selecting_control: DV_BUTTON
			-- Button to select a table row.

feature -- Status setting

	show is
			-- Show window.
		do
			if display_list.table_code_set then
				set_title (selection_window_title (tables.description (display_list.table_code).Table_name))
			end
			Precursor
		end

	hide is
			-- Hide window.
		do
			set_title (selection_window_title (Undetermined_table_name))
			Precursor
		end

feature {NONE} -- Implementation

	create_widgets is
			-- Set window content. Clicking on "OK" performs `ok_action'.
		local
			hbox: DV_HORIZONTAL_BOX
			cancel_button: DV_BUTTON
			container: DV_VERTICAL_BOX
		do
			set_title (selection_window_title (Undetermined_table_name))
			set_minimum_size (400, 267)
			create container.make
			extend (container)
			container.extend (display_list)
			create hbox.make
			hbox.disable_default_expand
			hbox.extend_cell
			create selecting_control.make_with_text ("OK")
			selecting_control.add_action (agent hide)
			hbox.extend (selecting_control)
			create cancel_button.make_with_text ("Cancel")
			cancel_button.add_action (agent hide)
			hbox.extend (cancel_button)
			hbox.extend_cell
			container.extend (hbox)
			container.disable_item_expand (hbox)
		end

	content: DV_TABLE_COMPONENT
			-- Component contained in window enabling
			-- to select data to export.

	display_list: DV_TABLEROW_MULTILIST
			-- Selection list.	

	set_initial_focus is
			-- Set initial focus to the multi-list.
		do
			display_list.set_focus
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_SELECTION_WINDOW


