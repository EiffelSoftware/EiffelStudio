note
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

	make
		local
			l_list_view: like list_view
			l_list: like list
			l_label: like label
			l_button: like button
		do
			make_top (Title)
			resize (355, 360)

				-- Create the output
			create l_list.make (Current, 0, 0, client_rect.width, 120, 1)
			list := l_list
			l_list.set_font(gui_font)
			create l_label.make (Current, "What happens?", 0, 120, client_rect.width, 20, 0)
				-- For GC reference
			label := l_label
			l_label.set_font(gui_font)

				-- Create the list view.
			create l_list_view.make (Current, 10, 150, client_rect.width - 20, client_rect.height - 190, -1)
			list_view := l_list_view
			l_list_view.set_item_output (l_label)
			l_list_view.set_mess_output (l_list)

				-- Create a button
			create l_button.make (Current, "Style", 10, height - 55, 50, 20, 3)
			button := l_button
			l_button.set_font(gui_font)
		end

feature -- Access

	list: ?WEL_SINGLE_SELECTION_LIST_BOX

	label: ?WEL_STATIC

	list_view: ?LISTVIEW

	button: ?WEL_PUSH_BUTTON

feature {NONE} -- Implementation

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	Title: STRING = "WEL List View"
			-- Window's title

	class_background: WEL_BRUSH
			-- background color
		once
			create Result.make_by_sys_color (Color_background)
		end

	default_style: INTEGER
			-- The window do not redraw the children.
		once
			Result := Precursor {WEL_FRAME_WINDOW}
				+ Ws_clipchildren + Ws_clipsiblings
		end

   	on_size (size_type, a_width, a_height: INTEGER)
   			-- Wm_size message
   		do
			if {l_list_view: like list_view} list_view then
				l_list_view.resize (client_rect.width - 20, client_rect.height - 190)
			end
			if {l_list: like list} list then
				l_list.resize (client_rect.width, 120)
			end
			if {l_button: like button} button then
				l_button.move (10, height - 55)
			end
		end

	on_control_id_command (control_id: INTEGER)
			-- A command has been received from `control_id'.
		do
			if control_id = 3 and then {l_list_view: like list_view} list_view then
				l_list_view.change_style
			end
		end

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


end -- class MAIN_WINDOW

