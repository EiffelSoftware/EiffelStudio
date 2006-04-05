indexing
	description: "Project root class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			thread_start: THREAD_START
			thread: SYSTEM_THREAD
			l_args: ARGUMENTS_PARSER
		do
			debug ("trace")
				print ("system launched%N")
			end
			create l_args.make
			if l_args.is_gui then
				debug ("trace")
					print ("in gui mode%N")
				end
				create thread_start.make (Current, $make_gui)
				create thread.make (thread_start)
				thread.set_apartment_state (feature {APARTMENT_STATE}.sta)
				thread.start
				thread.join
			elseif l_args.args_ok then
				debug ("trace")
					print ("in command line mode%N")
				end
				l_args.launch_command_line
			else
				io.put_string (l_args.argument_error)
				io.put_string ("%NPress any key to finish execution...%N")
				io.read_character
			end
		end
			
	make_gui is	
			-- Launch interface
		local
			retried: BOOLEAN
		do			
			if not retried then
				default_create
					-- create and initialize the first window.
				prepare
				if interface_initialized then
					launch
				end
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
		local
			retried: BOOLEAN
		do
			if not retried then	
				debug ("trace")
					print ("preparing interface for launching%N")
				end
				setup_preferences
				initialize_temp_directories
				create interface
				interface_initialized := True
				interface.Shared_constants.Application_constants.set_gui_mode (True)
				interface.show
			else
				interface_initialized := False
			end
		end
		
	interface: DOC_BUILDER_WINDOW
			-- Application window
			
	interface_initialized: BOOLEAN
			-- Has the interface been correctly initialized?

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class DOC_BUILDER
