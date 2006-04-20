indexing
	description: "Abstract root class for gui eiffelbench class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EWB

inherit
	WINDOWS

	EIFFEL_ENV

	ISED_X_SLAVE

	GRAPHICS

	ARGUMENTS
		rename
			command_line as arguments_line
		end

	SHARED_BENCH_LICENSES

	SHARED_CONFIGURE_RESOURCES

	SHARED_EIFFEL_PROJECT

feature -- Initialization

	make is
			-- Create and map the first window: the system window.
		local
			new_resources: EB_RESOURCES
			compiler: ES
			eifgen_init: INIT_SERVERS
			project_index, create_project_index: INTEGER
			open_project: OPEN_PROJECT
			new_project: NEW_PROJECT
			memory: MEMORY
			--| uncomment the following line when profiling 
			--prof_setting: PROFILING_SETTING
		do
			--| uncomment the following lines when profiling 
			--create prof_setting.make
			--prof_setting.stop_profiling

				-- Check that environment variables
				-- are properly set.
			check_environment_variable

				-- Check then for the license and make sure that we are allowed to launch the
				-- product.
			if init_license then

					--| Initialization of the run-time, so that at the end of a store/retrieve
					--| operation (like retrieving or storing the project, creating the CASEGEN
					--| directory, generating the profile information, ...) the run-time is initialized
					--| back to the values which permits the compiler to access correctly the EIFGEN
					--| directory
				create eifgen_init.make

					-- Read the resource files
				if argument_count > 0 and then
					(argument (1).is_equal ("-bench") or
					else argument (1).is_equal ("-from_bench"))
				then
					Eiffel_project.set_batch_mode (False)
					if argument (1).is_equal ("-bench") then
							-- Connect to EiffelBench using EiffelVision 1.
						init_connection (True)
					end
					if toolkit = Void then end
					init_windowing
					create memory
					memory.set_collection_period (Configure_resources.get_integer (r_collection_period, memory.collection_period))
					project_index := index_of_word_option ("project")
					if project_index /= 0 then
							-- Project open by `ebench name_of_project.epr'
						create open_project.make_from_project_file (Project_tool, argument (project_index + 1))
						open_project.open_from_ebench
					else
							-- Project create by `ebench -create my_path'
						create_project_index := index_of_word_option ("create")
						if create_project_index /= 0 then
							create new_project.make_from_ebench (Project_tool, argument (create_project_index + 1))
						end
					end
					iterate
					exit
				else
					Eiffel_project.set_batch_mode (True)
					create new_resources.initialize	
					create memory
					memory.set_collection_period (Configure_resources.get_integer (r_collection_period, memory.collection_period))
						-- Start the compilation in batch mode from the bench executable.
					create compiler.make_unlicensed
					discard_licenses
				end
			end

			--| uncomment the following line when profiling 
			--prof_setting.start_profiling
		rescue
			if not fail_on_rescue then
				clean_exit (exception_trace)
				retry
			end
		end

feature {NONE} -- Implementation

	clean_exit (trace: STRING) is
			-- Perform clean quit of EiffelBench
		local
			msg_d: ERROR_D
		do
			create msg_d.make ("Internal Error", Project_tool)
			msg_d.set_message ("An internal error occurred.%N%N%
						%1 - Check that you have enough space to compile.%N%
						%2 - Check that you are not using specific Eiffel%N%
						%     construct not supported by EiffelSharp%N%
						%3 - If this happens even after relaunching the environment%N%
						%     delete your EIFGEN and recompile from scratch.%N%N%
						%Follow the instructions at http://support.eiffel.com/submit.html in%N%
						%order to submit a bug report at http://support.eiffel.com")
			msg_d.set_ok_label ("Quit now!")
			msg_d.set_cancel_label ("Display Trace!")
			msg_d.set_help_label ("Restart now!")

			msg_d.add_ok_action (create {ROUTINE_CMD}.make (agent Current.execute_die) , Void)
			msg_d.add_cancel_action (create {ROUTINE_CMD}. make (agent Current.crash (trace)), Void)
			msg_d.add_help_action (create {ROUTINE_CMD}. make (agent Current.restart), Void)

			msg_d.set_exclusive_grab
			msg_d.popup
			iterate
		end

	execute_die is
			-- Command call when a crash occurs to clean up disk
		do
				-- Ensure clean exit in case of exception
			die (-1)
		end

	crash (trace: STRING) is
		do
			io.error.put_string (trace)
		end

	restart is
		local
			launcher: COMMAND_EXECUTOR
		do
			create launcher
			launcher.execute ((create {EIFFEL_ENV}).Estudio_command_name)
			die (-1)
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

end -- class EWB
