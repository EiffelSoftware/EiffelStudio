indexing
	description	: "Simple drawing program."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	PAINTBRUSH

inherit
	EV_APPLICATION
	
	PAINTBRUSH_CONSTANTS
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
			a_icon: EV_PIXMAP
		do
				-- create Menus & menu items
			create a_menu_bar
			create a_menu.make_with_text ("File")
			create a_menu_item.make_with_text ("New")
			a_menu_item.select_actions.extend (agent on_file_new)
			a_menu.extend (a_menu_item)
			create a_menu.make_with_text ("File")
			create a_menu_item.make_with_text ("Open")
			a_menu_item.select_actions.extend (agent on_file_open)
			a_menu.extend (a_menu_item)
			create a_menu_item.make_with_text ("Save")
			a_menu_item.select_actions.extend (agent on_file_save)
			a_menu.extend (a_menu_item)
			create a_menu_separator
			a_menu.extend (a_menu_separator)
			create a_menu_item.make_with_text ("Exit")
			a_menu_item.select_actions.extend (agent on_file_exit)
			a_menu.extend (a_menu_item)
			a_menu_bar.extend (a_menu)
			first_window.set_menu_bar (a_menu_bar)

				-- create the toolbar
			create my_toolbar
			add_toolbar_button (my_toolbar, "new.png", agent on_file_new)
			add_toolbar_button (my_toolbar, "open.png", agent on_file_open)
			add_toolbar_button (my_toolbar, "save.png", agent on_file_save)

			first_window.upper_bar.extend (create {EV_HORIZONTAL_SEPARATOR})
			first_window.upper_bar.extend (my_toolbar)
			first_window.upper_bar.extend (create {EV_HORIZONTAL_SEPARATOR})

				-- Create the pixmap
			create my_pixmap
			my_pixmap.set_size (128, 128)
			my_pixmap.set_background_color ((create {EV_STOCK_COLORS}).White)
			my_pixmap.clear

				-- Create the pixmap
			create my_container
			my_container.extend (my_pixmap)

				-- Add widgets to our window
			first_window.extend (my_container)
			
				-- Request that close actions emulate "File menu / Exit"
				-- (close actions are fired when the user click on the small
				-- cross in the title bar for example)
			first_window.close_request_actions.extend (agent on_file_exit)

				-- Start the program.
			my_pixmap.disable_sensitive
		end

	add_toolbar_button (a_toolbar: EV_TOOL_BAR; pixmap_name: STRING; command: PROCEDURE [ANY, TUPLE]) is
			-- Add a button to the toolbar `a_toolbar' with the pixmap `pixmap_name' and the action
			-- `command'.
		local
			a_toolbar_button: EV_TOOL_BAR_BUTTON
			a_icon: EV_PIXMAP
		do
			create a_icon
			a_icon.set_with_named_file (pixmap_name)
			create a_toolbar_button
			a_toolbar_button.set_pixmap (a_icon)
			a_toolbar_button.select_actions.extend (command)
			a_toolbar.extend (a_toolbar_button)
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

	on_file_open is
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
	
	on_file_new is
			-- Feature executed when the user select file/new
			-- in the menu. 
		local
			create_new_pixmap_dialog: PAINTBRUSH_CREATE_NEW_PIXMAP_DIALOG
		do
			create create_new_pixmap_dialog.make
			create_new_pixmap_dialog.show_modal_to_window (first_window)
			if create_new_pixmap_dialog.ok_selected then
				my_pixmap.set_size (create_new_pixmap_dialog.desired_width, create_new_pixmap_dialog.desired_height)
				my_pixmap.set_background_color (create_new_pixmap_dialog.desired_background_color)
				my_pixmap.clear
			end
		end
	
	on_file_save is
			-- Feature executed when the user select file/close
			-- in the menu.
		do
		end
	
	on_file_exit is
			-- Feature executed when the user select file/exit
			-- in the menu.
		do
				-- Destroy the main window
			first_window.destroy;
			
				-- Stop the message loop causing the application
				-- to exit.
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
		end

feature {NONE} -- Initialisations and File status

	file_name: STRING
			-- Name of the current displayed pixmap.
	
end -- class PAINTBRUSH
