indexing
	description: "Project root class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_BUILDER

inherit
	EV_APPLICATION
	
	SHARED_OBJECTS
		undefine
			default_create,
			copy
		end

create
	make_and_launch 

feature {NONE} -- Initialization
		
	make_and_launch is
			-- Initialize and launch application
		local
			l_args: ARGUMENTS_PARSER
			l_app: EV_APPLICATION
		do				
			create l_app
			(create {APPLICATION_CONSTANTS}).set_mode ("classic")
			create l_args.make
			if l_args.is_gui then
				make_gui
			elseif l_args.args_ok then
				setup_preferences
				initialize_temp_directories
				l_args.launch_command_line
			else
				io.putstring (l_args.argument_error)
				io.putstring ("%NPress any key to finish execution...")
				io.read_character
			end		
		end
			
	make_gui is	
		local
			retried: BOOLEAN
		do
			if not retried then
				default_create
					-- create and initialize the first window.
				prepare			
				interface.maximize
				launch
			else
				is_launched := False				
				show_exception_dialog
				shared_document_manager.save_all
			end
		rescue
			retried := True
			retry
		end

	prepare is
			-- Prepare the interface window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			setup_preferences
			initialize_temp_directories
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
			l_dir: KL_DIRECTORY
			l_constants: SHARED_CONSTANTS
		once
			l_constants := (create {SHARED_OBJECTS}).shared_constants
			
			create l_dir.make (l_constants.Application_constants.Temporary_directory)
			if not l_dir.exists then
				l_dir.create_directory
			end
			if l_dir.exists then
						-- Temporary directory for Help projects
				create l_dir.make (l_constants.Application_constants.Temporary_help_directory)
				if l_dir.exists then
					l_dir.recursive_delete
				end	
				l_dir.create_directory
				if not l_dir.exists then
					io.error.put_string ("Could not create output directory at " + l_dir.name)
					io.error.put_new_line;
					(create {EXCEPTIONS}).die (0)
				end
				
						-- 	Temporary directory for HTML
				create l_dir.make (l_constants.Application_constants.Temporary_html_directory)
				if l_dir.exists then
					l_dir.recursive_delete
				end	
				l_dir.create_directory	
				if not l_dir.exists then
					io.error.put_string ("Could not create output directory at " + l_dir.name)
					io.error.put_new_line;
					(create {EXCEPTIONS}).die (0)
				end
				
						-- Temporary directory for XML
				create l_dir.make (l_constants.Application_constants.Temporary_xml_directory)
				if l_dir.exists then
					l_dir.recursive_delete
				end	
				l_dir.create_directory
				if not l_dir.exists then
					io.error.put_string ("Could not create output directory at " + l_dir.name)
					io.error.put_new_line;
					(create {EXCEPTIONS}).die (0)
				end
			else
				io.error.put_string ("Could not create output directory at " + l_dir.name)
				io.error.put_new_line;
				(create {EXCEPTIONS}).die (0)
			end
		end	
		
	show_exception_dialog is
			-- Display an exception dialog containing details of last raised exception
		local
			l_dialog: EXCEPTION_DIALOG			
			l_exceptions: EXCEPTIONS
		do
			create l_exceptions
			create l_dialog
			l_dialog.set_summary ("There has been an unexpected error.")
			l_dialog.set_exception_type (l_exceptions.meaning (l_exceptions.exception))
			l_dialog.set_exception_trace (l_exceptions.exception_trace)
			l_dialog.show_modal_to_window (interface)
		end
		
	setup_preferences is
			-- Initialize preference library						
		do
			shared_preferences.initialize
		end	

end -- class DOC_BUILDER
