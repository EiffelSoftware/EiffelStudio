indexing
	description: "Splash Screen"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUILD_PRESENT_WINDOW

inherit

	CONSTANTS

	EB_TOP_SHELL
		redefine
			make
		end

	CLOSEABLE

creation

	make

feature -- Creation

	make (a_name: STRING; a_parent: SCREEN) is
		local
			a_color: COLOR
			a_pixmap: PIXMAP
			a, b: INTEGER
			del_com: DELETE_WINDOW
		do
			Precursor (a_name, a_parent)
			set_title (Widget_names.main_panel)

			a_pixmap := Pixmaps.presentation_pixmap
			set_background_pixmap (a_pixmap)

 			a := a_parent.width
 			b := a_parent.height
 			if a > a_pixmap.width // 2 and then b > a_pixmap.height // 2 then
				a := a // 2 - a_pixmap.width // 2
				b := b // 2 - a_pixmap.height // 2
			else
				a := 0
				b := 0
			end
			set_size (a_pixmap.width, a_pixmap.height)
			forbid_resize
			set_x_y (a, b)

			!! del_com.make (Current)
			set_delete_command (del_com)
		end

	close is
		do
			destroy
		end

end -- class BUILD_PRESENT_WINDOW
