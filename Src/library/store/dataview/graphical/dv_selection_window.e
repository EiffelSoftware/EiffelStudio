note
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

	make (display_l: DV_TABLEROW_MULTILIST)
			-- Create the window and the status bar.
		require
			not_void: display_l /= Void
		do
			display_list := display_l
			create selecting_control.make_with_text ("OK")

			default_create

			create_widgets

			close_request_actions.extend (agent hide)
		end

feature -- Access

	selecting_control: DV_BUTTON
			-- Button to select a table row.

feature -- Status setting

	show
			-- Show window.
		do
			if display_list.table_code_set then
				set_title (selection_window_title (tables.description (display_list.table_code).Table_name))
			end
			Precursor
		end

	hide
			-- Hide window.
		do
			set_title (selection_window_title (Undetermined_table_name))
			Precursor
		end

feature {NONE} -- Implementation

	create_widgets
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
			selecting_control.add_action (agent hide)
			hbox.extend (selecting_control)
			create cancel_button.make_with_text ("Cancel")
			cancel_button.add_action (agent hide)
			hbox.extend (cancel_button)
			hbox.extend_cell
			container.extend (hbox)
			container.disable_item_expand (hbox)
		end

	display_list: DV_TABLEROW_MULTILIST
			-- Selection list.	

	set_initial_focus
			-- Set initial focus to the multi-list.
		do
			display_list.set_focus
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"





end -- class DV_SELECTION_WINDOW


