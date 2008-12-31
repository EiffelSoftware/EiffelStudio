note
	description: "Main window class of the WEL example : Header_Control."
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
			on_size
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
		do
			make_top (Title)
			resize (400, 240)

			-- Create the list view.
			create header_control.make (Current, client_rect.x, client_rect.y, 
												 client_rect.width, client_rect.height, -1)
			header_control.set_font(gui_font)

			-- Create the output
			create label.make (Current, "What happens?", 0, 30, client_rect.width, 20, 0)
			label.set_font(gui_font)
			create list.make (Current, 0, 50,
							  client_rect.width, client_rect.height - 55, 1)
			list.set_font(gui_font)

			header_control.set_item_output (label)
			header_control.set_mess_output (list)
		end

feature -- Access

	list: WEL_SINGLE_SELECTION_LIST_BOX

	label: WEL_STATIC

	header_control: HEADER_CONTROL

feature {NONE} -- Implementation

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	Title: STRING = "WEL Header Control"
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
			if header_control /= Void then
				header_control.retrieve_and_set_windows_pos (client_rect)
			end
			if list /= Void then
				list.resize (client_rect.width, client_rect.height - 55)
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

