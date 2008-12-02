indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_paint,
			on_control_command
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			make_top (Title)
			resize (415, 330)
			create maze_button.make (Current, "Maze",
				35, 240, 100, 50, -1)
			create artist_button.make (Current, "Artist",
				154, 240, 100, 50, -1)
			create fun_button.make (Current, "Fun",
				270, 240, 100, 50, -1)
		end

feature -- Access

	maze: MAZE

	artist: ARTIST

	fun_dialog: FUN_DIALOG

	maze_button, artist_button, fun_button: WEL_PUSH_BUTTON

feature {NONE} -- Implementation

	on_control_command (control: WEL_CONTROL) is
		do
			if control = maze_button then
				create maze.make
			elseif control = artist_button then
				create artist.make (Current)
			elseif control = fun_button then
				create fun_dialog.make (Current)
				fun_dialog.activate
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Draw the ISE logo bitmap
		do
			paint_dc.draw_bitmap (ise_logo, 20, 40,
				ise_logo.width, ise_logo.height)
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	ise_logo: WEL_BITMAP is
			-- ISE logo bitmap
		once
			create Result.make_by_id (Id_bmp_ise_logo)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL GDI demo";
			-- Window's title

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

