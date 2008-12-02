indexing
	description: "Main window class of the WEL example : List_view."
	legal: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make is
		do
			make_top (Title)
			resize (355, 360)

				-- Create the output
			create list.make (Current, 0, 0, client_rect.width, 120, 1)
			list.set_font(gui_font)
			create label.make (Current, "What happens?", 0, 120, client_rect.width, 20, 0)
			label.set_font(gui_font)

				-- Create the list view.
			create list_view.make (Current, 10, 150, client_rect.width - 20, client_rect.height - 190, -1)
			list_view.set_item_output (label)
			list_view.set_mess_output (list)
			
				-- Create a button
			create button.make (Current, "Style", 10, height - 55, 50, 20, 3)
			button.set_font(gui_font)
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
			create Result.make_by_id (Id_ico_application)
		end

	Title: STRING is "WEL List View"
			-- Window's title

	class_background: WEL_BRUSH is
			-- background color
		once
			create Result.make_by_sys_color (Color_background)
		end

	default_style: INTEGER is
			-- The window do not redraw the children.
		once
			Result := Precursor {WEL_FRAME_WINDOW}
				+ Ws_clipchildren + Ws_clipsiblings
		end

   	on_size (size_type, a_width, a_height: INTEGER) is
   			-- Wm_size message
   		do
			if list_view /= Void then
				list_view.resize (client_rect.width - 20, client_rect.height - 190)
			end
			if list /= Void then
				list.resize (client_rect.width, 120)
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


end -- class MAIN_WINDOW

