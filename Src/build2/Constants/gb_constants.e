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
	
	Ev_window_string: STRING is "EV_WINDOW"
	
	Ev_titled_window_string: STRING is "EV_TITLED_WINDOW"

feature -- Miscellaneous

	Internal_properties_string: STRING is "Internal_properties"
		-- Xml tag used to store proeprties stored by GB_OBJECT
		-- but not in the interface of Vision2.
	
feature -- Directories

	gb_ev_directory: FILE_NAME is
		do
			create Result.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)
			Result.extend ("build")
			Result.extend ("interface")
		end
	
feature -- Default values

	Minimum_width_of_object_editor: INTEGER is 120
		-- The minimum width allowed for a GB_OBJECT_EDITOR
		

feature -- Generation constants

	template_file_name: FILE_NAME is
			-- `Result' is location of build template file,
			-- including the name.
		do
			create Result.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)		
			Result.extend ("build")
			Result.extend ("templates")
			Result.extend ("build_template.e")
		end
		
	class_name_tag: STRING is
			-- `Result' is tag used in templates
			-- for the class name.
		once
			Result := "<CLASS_NAME>"
		end
		
	create_tag: STRING is
			-- `Result' is tag used in templates
			-- for the creation of widgets.
		once
			Result := "<CREATE>"
		end
		
	build_tag: STRING is
			-- `Result' is tag used in templates
			-- for buiilding of the widget heirarchy.
		once
			Result := "<BUILD>"
		end
		
	set_tag: STRING is
			-- `Result' is tag used in templates
			-- for the setting of widgets properties.
		once
			Result := "<SET>"
		end
		
	local_tag: STRING is
			-- `Result' is tag used in tamplates
			-- for local definitions.
		once
			Result := "<LOCAL>"
		end
		
	indent: STRING is
			-- String representing standard indent
			-- for code generation.
		once
			Result := "%N%T%T%T"
		end
		
feature -- XML saving

	filename: FILE_NAME is
			-- File to be generated.
		do
			--| FIXME
			create Result.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)
			Result.extend ("build")
			Result.extend ("temp")
			Result.extend ("xml_output.xml")
		end		
		
feature -- XML constants


	True_string: STRING is "True"
		-- String constant representing True.
		
	False_string: STRING is "False"
		-- String constant representing False.
		
	Item_string: STRING is "item"
		-- String constant representing "item".
		
	Name_string: STRING is "name"

end -- class GB_CONSTANTS
