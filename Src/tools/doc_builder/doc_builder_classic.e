indexing
	description: "Project root class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_BUILDER

inherit
	EV_APPLICATION

create
	make_and_launch 

feature {NONE} -- Initialization
		
	make_and_launch is
			-- Initialize and launch application
		local
			l_args: ARGUMENTS_PARSER
		do				
			(create {APPLICATION_CONSTANTS}).set_mode ("classic")
			initialize_temp_directories
			create l_args.make
			if l_args.is_gui then
				make_gui
			elseif l_args.args_ok then				
				l_args.launch_command_line
			else
				io.putstring (l_args.argument_error)
				io.putstring ("%NPress any key to finish execution...")
				io.read_character
			end		
		end
			
	make_gui is	
		do
			default_create
				-- create and initialize the first window.
			prepare			
			interface.maximize
			launch
		end

	prepare is
			-- Prepare the interface window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			create interface
			interface.Shared_constants.Application_constants.set_gui_mode (True)
			interface.show
		end
		
	interface: DOC_BUILDER_WINDOW
			-- Application window

	initialize_temp_directories is
		-- Initialize directory for storage of temporary information.  Currently this is a directory
		-- on the root drive because help compilation for Microsoft Help 1.x fails in directories
		-- with absolute path names of a certain size.  By placing in the root this reduces the overall
		-- size of path names.
		local
			l_dir: DIRECTORY
			l_constants: SHARED_CONSTANTS
		once
			l_constants := (create {SHARED_OBJECTS}).shared_constants
			
					-- Main temporary directory
			create l_dir.make (l_constants.Application_constants.Temporary_directory)
			if l_dir.exists then
				l_dir.recursive_delete
			end
			l_dir.create_dir
			
					-- Temporary directory for Help projects
			create l_dir.make (l_constants.Application_constants.Temporary_help_directory)
			if not l_dir.exists then
				l_dir.create_dir
			end		
			
					-- 	Temporary directory for HTML
			create l_dir.make (l_constants.Application_constants.Temporary_html_directory)
			if not l_dir.exists then
				l_dir.create_dir
			end
			
					-- Temporary directory for XML
			create l_dir.make (l_constants.Application_constants.Temporary_xml_directory)
			if not l_dir.exists then
				l_dir.create_dir
			end
		end	

end -- class DOC_BUILDER
