indexing
	description: "Main window class of the WEL example : List_view."
	status: "See notice at end of class."
	date: ""
	revision: ""

class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			class_background,
			default_style,
			on_size,
			on_control_id_command
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
		do
			make_top (Title)
			resize (355, 240)
			-- Create the output
			!! list.make (Current, 0, 0, client_rect.width, 60, 1)
			!! label.make (Current, "What happens?", 0, 60, client_rect.width, 20, 0)
			-- Create the list view.
			!! list_view.make (Current, 10, 90, client_rect.width - 20, client_rect.height - 130, -1)
			list_view.set_item_output (label)
			list_view.set_mess_output (list)
			-- Create a button
			!! button.make (Current, "Style", 10, height - 55, 50, 20, 3)
		end

feature -- Access

	list: WEL_SINGLE_SELECTION_LIST_BOX

	label: WEL_STATIC

	list_view: LISTVIEW

	button: WEL_PUSH_BUTTON

feature {NONE} -- Implementation

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (Id_ico_application)
		end

	Title: STRING is "WEL List View"
			-- Window's title

	class_background: WEL_BRUSH is
			-- background color
		once
			!! Result.make_by_sys_color (Color_background)
		end

	default_style: INTEGER is
			-- The window do not redraw the children.
		once
			Result := {WEL_FRAME_WINDOW} Precursor
				+ Ws_clipchildren + Ws_clipsiblings
		end

   	on_size (size_type, a_width, a_height: INTEGER) is
   			-- Wm_size message
   		do
			if list_view /= Void then
				list_view.resize (client_rect.width - 20, client_rect.height - 130)
			end
			if list /= Void then
				list.resize (client_rect.width, 60)
			end
			if button /= Void then
				button.move (10, height - 55)
			end
		end

	on_control_id_command (control_id: INTEGER) is
			-- A command has been received from `control_id'.
		do
			if control_id = 3 then
				list_view.change_style
			end
		end

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
