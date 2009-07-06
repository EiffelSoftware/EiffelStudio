note
	description	: "Simple program demonstrating the use of cursors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	CURSOR_TEST

inherit
	EV_APPLICATION
		redefine
			create_interface_objects
		end

create
	make_and_launch

feature -- Initialization

	make_and_launch
			-- Create and launch.
		do
			default_create
			prepare
			launch
		end

	create_interface_objects
		do
			Precursor {EV_APPLICATION}
			create my_container
			create my_label
			create my_list
			create my_instructions
		end

	prepare
			-- Initialize world.
		local
			an_item: EV_MULTI_COLUMN_LIST_ROW
			a_button: EV_BUTTON
			a_menu_bar: EV_MENU_BAR
			a_menu: EV_MENU
			a_menu_item: EV_MENU_ITEM
			a_hb: EV_HORIZONTAL_BOX
			a_hb2: EV_HORIZONTAL_BOX
			a_cell: EV_CELL
		do
				-- create Menus & menu items
			create a_menu_bar
			create a_menu.make_with_text ("File")
			create a_menu_item.make_with_text ("Exit")
			a_menu_item.select_actions.extend (agent on_exit)
			a_menu.extend (a_menu_item)
			a_menu_bar.extend (a_menu)
			first_window.set_menu_bar (a_menu_bar)

				-- Allow `first_window' to be closed.
			first_window.close_request_actions.extend (agent on_exit)

				-- Create the container

			create a_hb
			create a_cell
			a_hb.extend (a_cell)

			create a_hb2
			--a_hb2.enable_homogeneous
			a_hb2.set_border_width (12)
			a_hb2.set_padding (12)

			create a_button
			a_button.set_text (" Apply ")
			a_button.select_actions.extend (agent on_apply)
			a_hb2.extend (a_button)

			a_hb.extend (a_hb2)
			a_hb.disable_item_expand (a_hb2)

			my_label.set_text ("Select a cursor in the list, and then%Npress the 'Apply' button to set the cursor for this label.")
			my_instructions.extend (my_label)
			my_instructions.extend (a_hb)
			my_instructions.disable_item_expand (a_hb)


			my_list.disable_multiple_selection
			my_list.set_pixmaps_size (32, 32)

			create an_item
			an_item.extend (Busy_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Busy_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Standard_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Standard_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Crosshair_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Crosshair_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Help_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Help_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Ibeam_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Ibeam_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (No_cursor_string)
			an_item.set_pixmap (Default_pixmaps.No_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Sizeall_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Sizeall_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Sizens_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Sizens_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Sizewe_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Sizewe_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Uparrow_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Uparrow_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Wait_cursor_string)
			an_item.set_pixmap (Default_pixmaps.Wait_cursor)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Question_pixmap_string)
			an_item.set_pixmap (Default_pixmaps.Question_pixmap)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Information_pixmap_string)
			an_item.set_pixmap (Default_pixmaps.Information_pixmap)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Error_pixmap_string)
			an_item.set_pixmap (Default_pixmaps.Error_pixmap)
			my_list.extend (an_item)

			create an_item
			an_item.extend (Warning_pixmap_string)
			an_item.set_pixmap (Default_pixmaps.Warning_pixmap)
			my_list.extend (an_item)

			my_container.extend (my_list)
			my_container.extend (my_instructions)

				-- Add widgets to our window
			first_window.extend(my_container)
			first_window.show
		end

	first_window: EV_TITLED_WINDOW
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Vision2 EV_CURSOR example")
			Result.set_size (800, 400)
		end

feature {NONE} -- Graphical interface

	my_list: EV_MULTI_COLUMN_LIST

	my_label: EV_LABEL

	my_container: EV_HORIZONTAL_BOX
			-- Container that groups the da.

	my_instructions: EV_VERTICAL_BOX

feature {NONE} -- Implementation

	on_exit
			-- Quit the program
		do
			destroy
		end

	on_apply
		local
			mc_row: detachable EV_MULTI_COLUMN_LIST_ROW
			cursor_text: STRING
			ev_pointer_style: EV_POINTER_STYLE
		do
			mc_row := my_list.selected_item
			if attached mc_row as l_row then
				cursor_text := l_row.first
				if cursor_text.is_equal (Busy_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Busy_cursor)

				elseif cursor_text.is_equal (Standard_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Standard_cursor)

				elseif cursor_text.is_equal (Crosshair_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Crosshair_cursor)

				elseif cursor_text.is_equal (Help_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Help_cursor)

				elseif cursor_text.is_equal (Ibeam_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Ibeam_cursor)

				elseif cursor_text.is_equal (No_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.No_cursor)

				elseif cursor_text.is_equal (Sizeall_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Sizeall_cursor)

				elseif cursor_text.is_equal (Sizens_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Sizens_cursor)

				elseif cursor_text.is_equal (Sizewe_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Sizewe_cursor)

				elseif cursor_text.is_equal (Uparrow_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Uparrow_cursor)

				elseif cursor_text.is_equal (Wait_cursor_string) then
					my_instructions.set_pointer_style (Default_pixmaps.Wait_cursor)
					
				elseif cursor_text.is_equal (Question_pixmap_string) then
					create ev_pointer_style.make_with_pixmap (Default_pixmaps.Question_pixmap, 0, 0)
					my_instructions.set_pointer_style (ev_pointer_style)

				elseif cursor_text.is_equal (Information_pixmap_string) then
					create ev_pointer_style.make_with_pixmap (Default_pixmaps.Information_pixmap, 0, 0)
					my_instructions.set_pointer_style (ev_pointer_style)

				elseif cursor_text.is_equal (Error_pixmap_string) then
					create ev_pointer_style.make_with_pixmap (Default_pixmaps.Error_pixmap, 0, 0)
					my_instructions.set_pointer_style (ev_pointer_style)

				elseif cursor_text.is_equal (Warning_pixmap_string) then
					create ev_pointer_style.make_with_pixmap (Default_pixmaps.Warning_pixmap, 0, 0)
					my_instructions.set_pointer_style (ev_pointer_style)
				end
			end
		end

	Default_pixmaps: EV_STOCK_PIXMAPS
		once
			Create Result
		end

feature {NONE} -- Cursor Strings

	Busy_cursor_string			: STRING = "Busy"
	Standard_cursor_string		: STRING = "Standard"
	Crosshair_cursor_string		: STRING = "Crosshair"
	Help_cursor_string			: STRING = "Help"
	Ibeam_cursor_string			: STRING = "Ibeam"
	No_cursor_string			: STRING = "No"
	Sizeall_cursor_string		: STRING = "Sizeall"
	Sizens_cursor_string		: STRING = "Sizens"
	Sizewe_cursor_string		: STRING = "Sizewe"
	Uparrow_cursor_string		: STRING = "Uparrow"
	Wait_cursor_string			: STRING = "Wait"
	Question_pixmap_string		: STRING = "Question"
	Warning_pixmap_string		: STRING = "Warning"
	Information_pixmap_string	: STRING = "Information"
	Error_pixmap_string			: STRING = "Error";

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CURSOR_TEST

