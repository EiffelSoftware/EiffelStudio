indexing
	description: "Objects that provide access to constants used."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CONSTANTS

feature -- Access

	gb_main_window_title: STRING is "Graphical builder"
		-- Title to be displayed in GB_MAIN_WINDOW.
		
	gb_display_window_title: STRING is "Display window"
		-- Title to be displayed in GB_DISPLAY_WINDOW.
		
	gb_builder_window_title: STRING is "Builder window"
		-- Title to be displayed in GB_BUILDER_WINDOW.
		
	gb_object_editor_window_title: STRING is "Object editor"
		-- Title to be displayed in GB_OBJECT_EDITOR.

	
	
feature -- Menu texts.
	
	gb_file_menu_text: STRING is "&File"
		-- Text of file menu.
		
	gb_about_menu_text: STRING is "&About"
		-- Text of about menu.
		
	gb_settings_menu_text: STRING is "&Settings"
	
	gb_warnings_on_menu_text: STRING is "Warnings enabled"
	
	gb_warnings_off_menu_text: STRING is "Warnings disabled"
	
feature -- String representations of class names.

	gb_primitive_object_class_name: STRING is "GB_PRIMITIVE_OBJECT"
	
	ev_window_string: STRING is "EV_WINDOW"

feature -- Miscellaneous

	Internal_properties_string: STRING is "Internal_properties"
		-- Xml tag used to store proeprties stored by GB_OBJECT
		-- but not in the interface of Vision2.
	
feature -- Directories

	gb_ev_directory: STRING is "D:\work\build2\interface"
	
feature -- Default values

	Minimum_width_of_object_editor: INTEGER is 120
		-- The minimum width allowed for a GB_OBJECT_EDITOR
		
feature -- Pixmaps

	insert_in_pixmap: EV_CURSOR is
			-- Cursor used for insert in container pick and drop.
		local
			pixmap: EV_PIXMAP
		once
			create pixmap
			pixmap.set_with_named_file ("C:\insert_in_icon.ico")
			create Result.make_with_pixmap (pixmap, 16, 16)
		end
		
	insert_before_pixmap: EV_CURSOR is
			-- Cursor used for insert before during pick and drop.
		local
			pixmap: EV_PIXMAP
		once
			create pixmap
			pixmap.set_with_named_file ("C:\insert_before_icon.ico")
			create Result.make_with_pixmap (pixmap, 16, 16)
		end
		

end -- class GB_CONSTANTS
