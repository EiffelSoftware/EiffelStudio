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

feature -- Access

	make_and_launch is
		do
			default_create
			prepare
			first_window.show
			launch
		end

feature -- Initialization

	prepare is
			-- Initialize world.
		local
			a_menu_bar: EV_MENU_BAR
			a_menu: EV_MENU
			a_menu_item: EV_MENU_ITEM
			a_menu_separator: EV_MENU_SEPARATOR
			a_toolbar_button: EV_TOOL_BAR_BUTTON
			a_toolbar_separator: EV_TOOL_BAR_SEPARATOR
			a_icon: EV_PIXMAP
			a_gray_icon: EV_PIXMAP
			
			a_color: EV_COLOR
		do
			create a_color
			a_color.set_rgb (1.0, 0.0, 0.0)

				-- create Menus & menu items
			create a_menu_bar
			create a_menu.make_with_text ("File")
			create a_menu_item.make_with_text ("Load")
			a_menu_item.select_actions.extend (agent on_menu_file_load)
			a_menu.extend (a_menu_item)
			create a_menu_item.make_with_text ("Close")
			a_menu_item.select_actions.extend (agent on_menu_file_close)
			a_menu.extend (a_menu_item)
			create a_menu_separator
			a_menu.extend (a_menu_separator)
			create a_menu_item.make_with_text ("Exit")
			a_menu_item.select_actions.extend (agent on_menu_file_exit)
			a_menu.extend (a_menu_item)
			a_menu_bar.extend (a_menu)
			first_window.set_menu_bar (a_menu_bar)

				-- create the toolbar
			create my_toolbar

			create a_icon
			a_icon.set_with_named_file ("blue.ico")
			create a_gray_icon
			a_gray_icon.set_with_named_file ("gray.ico")
			create a_toolbar_button
			a_toolbar_button.set_pixmap (a_icon)
			a_toolbar_button.set_gray_pixmap (a_gray_icon)
			a_toolbar_button.set_text ("ICO")
			my_toolbar.extend (a_toolbar_button)

			create a_toolbar_separator
			my_toolbar.extend (a_toolbar_separator)
			
			create a_icon
			a_icon.set_with_named_file ("magenta.png")
			create a_gray_icon
			a_gray_icon.set_with_named_file ("gray.png")
			create a_toolbar_button
			a_toolbar_button.set_pixmap (a_icon)
			a_toolbar_button.set_gray_pixmap (a_gray_icon)
			a_toolbar_button.set_text ("PNG")
			my_toolbar.extend (a_toolbar_button)

			first_window.upper_bar.extend (create {EV_HORIZONTAL_SEPARATOR})
			first_window.upper_bar.extend (my_toolbar)
			first_window.upper_bar.extend (create {EV_HORIZONTAL_SEPARATOR})

				-- Create the pixmap
			create my_container

				-- Create the pixmap
			new_bitmap

				-- Add widgets to our window
			first_window.extend (my_container)
			first_window.close_request_actions.extend (agent on_menu_file_exit)

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

	my_container: EV_VERTICAL_BOX
			-- Container that groups the pixmaps.

	my_pixmap: EV_PIXMAP
			-- Pixmap displayed on the screen

	my_toolbar: EV_TOOL_BAR

feature -- Process Vision2 events
	
	new_bitmap is
			-- create a new blank pixmap
		do
				-- remove the old pixmap
			my_container.prune_all (my_pixmap)

				-- create the new one & insert it
			create my_pixmap
		end

	on_menu_file_load is
			-- Feature executed when the user select file/load
			-- in the menu. Open the dialog box and let the
			-- user choose its file to load.
		local
			ofd: EV_FILE_OPEN_DIALOG
		do
			create ofd
			ofd.ok_actions.extend (agent effective_load_file (ofd))
			ofd.show_modal_to_window (first_window)
		end
	
	on_menu_file_close is
			-- Feature executed when the user select file/close
			-- in the menu.
		do
			new_bitmap
		end
	
	on_menu_file_exit is
			-- Feature executed when the user select file/exit
			-- in the menu.
		do
			first_window.destroy;
			(create {EV_ENVIRONMENT}).application.destroy
		end

feature {NONE} -- Load/Save File handling

	effective_load_file (file_d: EV_FILE_OPEN_DIALOG) is
			-- Actions performed when the user click on the
			-- "OK" button of the FileOpenDialog box.
		do
				-- Read and parse the file.
			file_name := file_d.file_name
			my_pixmap.set_with_named_file (file_name)

				-- Enable actions.
			my_pixmap.enable_sensitive
			my_pixmap.draw_text (5, 5, "toto")
		end

feature {NONE} -- Initialisations and File status

	file_name: STRING
			-- Name of the current displayed pixmap.
	
end -- class PAINTBRUSH
