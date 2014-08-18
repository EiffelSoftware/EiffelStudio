note
	description: "Summary description for {MAIN_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, create_interface_objects
		end

create
	default_create,
	make_with_title

feature -- Cursor Strings

	Busy_cursor_string: STRING = "Busy"
	Standard_cursor_string: STRING = "Standard"
	Crosshair_cursor_string: STRING = "Crosshair"
	Help_cursor_string: STRING = "Help"
	Ibeam_cursor_string: STRING = "Ibeam"
	No_cursor_string: STRING = "No"
	Sizeall_cursor_string: STRING = "Sizeall"
	Sizens_cursor_string: STRING = "Sizens"
	Sizewe_cursor_string: STRING = "Sizewe"
	Uparrow_cursor_string: STRING = "Uparrow"
	Wait_cursor_string: STRING = "Wait"
	Question_pixmap_string: STRING = "Question"
	Warning_pixmap_string: STRING = "Warning"
	Information_pixmap_string: STRING = "Information"
	Error_pixmap_string: STRING = "Error";

feature {NONE}-- Initialization

	initialize
		do
			Precursor
			prepare
		end

	create_interface_objects
		do
			Precursor
			create container
			create list
			create instructions
		end

	prepare
			-- Initialize world.
		local
			a_button: EV_BUTTON
			a_menu_bar: EV_MENU_BAR
			a_menu: EV_MENU
			a_menu_item: EV_MENU_ITEM
			a_hb: EV_HORIZONTAL_BOX
			a_field: EV_TEXT_FIELD
		do

				-- create Menus & menu items
			create a_menu_bar
			create a_menu.make_with_text ("File")
			create a_menu_item.make_with_text ("Exit")
			a_menu_item.select_actions.extend (agent on_exit)
			a_menu.extend (a_menu_item)
			a_menu_bar.extend (a_menu)
			set_menu_bar (a_menu_bar)

				-- Allow the window to be closed.
			close_request_actions.extend (agent on_exit)

			instructions.extend (create {EV_LABEL}.make_with_text ("Select a cursor in the list, and then%Npress the 'Apply' button to set the cursor for this label."))
			instructions.extend (create {EV_LABEL}.make_with_text ("Or pick (right click) an item in the list %Nand drop it onto the text field%Nat the bottom right to see the cursor name."))
			create a_hb
			a_hb.enable_homogeneous
			instructions.extend (a_hb)
			instructions.disable_item_expand (a_hb)

			create a_button
			a_button.set_text ("Apply")
			a_button.set_minimum_height (30)
			a_button.select_actions.extend (agent on_apply)
			create a_field
			a_field.drop_actions.extend (agent a_field.set_text (?))

			a_hb.set_border_width (10)
			a_hb.set_padding (10)
			a_hb.extend (a_button)
			a_hb.extend (a_field)
			a_hb.center_pointer


			list.disable_multiple_selection
			list.set_pixmaps_size (32, 32)

			list.extend (new_row (Busy_cursor_string, Default_pixmaps.Busy_cursor))
			list.extend (new_row (Standard_cursor_string,Default_pixmaps.Standard_cursor))
			list.extend (new_row (Crosshair_cursor_string,Default_pixmaps.Crosshair_cursor ))
			list.extend (new_row (Help_cursor_string,Default_pixmaps.Help_cursor))
			list.extend (new_row (Ibeam_cursor_string, Default_pixmaps.Ibeam_cursor))
			list.extend (new_row (No_cursor_string,Default_pixmaps.no_cursor))
			list.extend (new_row (Sizeall_cursor_string,Default_pixmaps.Sizeall_cursor))
			list.extend (new_row (Sizens_cursor_string, Default_pixmaps.Sizens_cursor))
			list.extend (new_row (Sizewe_cursor_string,Default_pixmaps.Sizewe_cursor))
			list.extend (new_row (Uparrow_cursor_string,Default_pixmaps.Uparrow_cursor))
			list.extend (new_row (Wait_cursor_string, Default_pixmaps.Wait_cursor))

			container.extend (list)
			container.extend (instructions)

				-- Add widgets to our window
			extend (container)
			set_title ("Vision2 EV_CURSOR example")
			set_size (800, 400)
	end

feature {NONE} -- Graphical interface

	list: detachable EV_MULTI_COLUMN_LIST

	container: detachable EV_HORIZONTAL_BOX

	instructions: detachable EV_VERTICAL_BOX

feature {NONE} -- Graphical events

	new_row  (t: STRING cursor: EV_POINTER_STYLE): EV_MULTI_COLUMN_LIST_ROW
			-- New row entry that is configured for pick and drop.
		do
			create Result
			Result.set_pixmap (cursor)
			Result.extend (t)
			Result.set_accept_cursor (cursor)
			Result.set_deny_cursor (default_pixmaps.no_cursor)
			Result.set_pebble (t)
		end

	on_exit
			-- Quit the program
		do
			destroy_and_exit_if_last
		end

	on_apply
			-- Set a cursor
		local
			cursor_text: STRING
			ev_pointer_style: EV_POINTER_STYLE
			l_instructions: like instructions
		do
			l_instructions := instructions
			check l_instructions /= Void end
			if attached list as l_list and then attached l_list.selected_item as mc_row then
				cursor_text := mc_row.first
				if cursor_text.is_equal (Busy_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Busy_cursor)

				elseif cursor_text.is_equal (Standard_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Standard_cursor)

				elseif cursor_text.is_equal (Crosshair_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Crosshair_cursor)

				elseif cursor_text.is_equal (Help_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Help_cursor)

				elseif cursor_text.is_equal (Ibeam_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Ibeam_cursor)

				elseif cursor_text.is_equal (No_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.No_cursor)

				elseif cursor_text.is_equal (Sizeall_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Sizeall_cursor)

				elseif cursor_text.is_equal (Sizens_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Sizens_cursor)

				elseif cursor_text.is_equal (Sizewe_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Sizewe_cursor)

				elseif cursor_text.is_equal (Uparrow_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Uparrow_cursor)

				elseif cursor_text.is_equal (Wait_cursor_string) then
					l_instructions.set_pointer_style (Default_pixmaps.Wait_cursor)

				elseif cursor_text.is_equal (Question_pixmap_string) then
					create ev_pointer_style.make_with_pixmap (Default_pixmaps.Question_pixmap, 0, 0)
					l_instructions.set_pointer_style (ev_pointer_style)

				elseif cursor_text.is_equal (Information_pixmap_string) then
					create ev_pointer_style.make_with_pixmap (Default_pixmaps.Information_pixmap, 0, 0)
					l_instructions.set_pointer_style (ev_pointer_style)

				elseif cursor_text.is_equal (Error_pixmap_string) then
					create ev_pointer_style.make_with_pixmap (Default_pixmaps.Error_pixmap, 0, 0)
					l_instructions.set_pointer_style (ev_pointer_style)

				elseif cursor_text.is_equal (Warning_pixmap_string) then
					create ev_pointer_style.make_with_pixmap (Default_pixmaps.Warning_pixmap, 0, 0)
					l_instructions.set_pointer_style (ev_pointer_style)
				end
			end
		end

end
