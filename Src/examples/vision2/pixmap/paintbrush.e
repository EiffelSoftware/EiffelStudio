indexing
	description	: "Simple drawing program."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	PAINTBRUSH

inherit
	EV_APPLICATION

	EV_DRAWABLE_CONSTANTS
		undefine
			default_create
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Initialize world.
		local
			basic_interval: INTEGER_INTERVAL
			a_menu_bar: EV_MENU_BAR
			a_menu: EV_MENU
			a_menu_item: EV_MENU_ITEM
			a_menu_separator: EV_MENU_SEPARATOR
		do
				-- Create the container
			create my_container

				-- Create the pixmap
			new_bitmap

				-- Add widgets to our window
			first_window.extend(my_container)

				-- create Menus & menu items
			create a_menu_bar
			create a_menu.make_with_text ("File")

			create a_menu_item.make_with_text ("Load")
			a_menu_item.press_actions.extend (~on_menu_file_load)
			a_menu.extend (a_menu_item)

			create a_menu_item.make_with_text ("Close")
			a_menu_item.press_actions.extend (~on_menu_file_close)
			a_menu.extend (a_menu_item)

			create a_menu_separator
			a_menu.extend (a_menu_separator)

			create a_menu_item.make_with_text ("Exit")
			a_menu_item.press_actions.extend (~on_menu_file_exit)
			a_menu.extend (a_menu_item)

			a_menu_bar.extend (a_menu)
			first_window.set_menu_bar (a_menu_bar)

				-- Start the program.
			my_pixmap.disable_sensitive
		end

	first_window: EV_TITLED_WINDOW is
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Vision2 Pixmap example")
			Result.set_size (500, 500)
		end


feature {NONE} -- Graphical interface

	my_container: EV_HORIZONTAL_BOX
			-- Container that groups the pixmaps.

	my_pixmap: EV_PIXMAP
			-- Pixmap displayed on the screen

feature -- Process Vision2 events
	
	new_bitmap is
			-- create a new blank pixmap
		do
				-- remove the old pixmap
			my_container.prune_all (my_pixmap)

				-- create the new one & insert it
			create my_pixmap
			my_container.extend (my_pixmap)
--			my_pixmap.pointer_button_press_actions.extend(~on_mouse_button_down)
--			my_pixmap.pointer_button_release_actions.extend(~on_mouse_button_up)
--			my_pixmap.expose_actions.extend (~on_repaint)
--			my_pixmap.pointer_motion_actions.extend (~on_mouse_move)
		end

	on_menu_file_load is
			-- Feature executed when the user select file/load
			-- in the menu. Open the dialog box and let the
			-- user choose its file to load.
		local
			ofd: EV_FILE_OPEN_DIALOG
		do
			create ofd
			ofd.ok_actions.extend (~effective_load_file (ofd))
			ofd.show_modal
		end
	
	on_menu_file_close is
			-- Feature executed when the user select file/load
			-- in the menu. Open the dialog box and let the
			-- user choose its file to load.
		do
			new_bitmap
		end
	
	on_menu_file_exit is
			-- Feature executed when the user select file/load
			-- in the menu. Open the dialog box and let the
			-- user choose its file to load.
		do
--| FIXME Arnaud: Following line has been commented due to a lack of
--|               implementation in Vision2/Windows.
--			destroy
		end
feature {NONE} -- Load/Save File handling

	effective_load_file(file_d: EV_FILE_OPEN_DIALOG) is
			-- Actions performed when the user click on the
			-- "OK" button of the FileOpenDialog box.
		do
				-- Read and parse the file.
			file_name := file_d.file_name
			my_pixmap.set_with_named_file(file_name)

				-- Enable actions.
			my_pixmap.enable_sensitive
			my_pixmap.redraw
		end

feature {NONE} -- Initialisations and File status

	file_name: STRING
			-- Name of the current displayed pixmap.
	
end -- class PAINTBRUSH
