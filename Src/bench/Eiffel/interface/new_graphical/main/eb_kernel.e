indexing
	description: "Core of the application"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_KERNEL

inherit
	ANY

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

	ISED_X_SLAVE
		export
			{NONE} all
		end

	ARGUMENTS
		rename
			command_line as arguments_line
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	SHARED_FORMAT_INFO
		export
			{NONE} all
		end
		
	SHARED_LICENSE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create and map the first window: the system window.
		local
			compiler: ES
			eifgen_init: INIT_SERVERS
			new_resources: TTY_RESOURCES
			pref_strs: PREFERENCE_CONSTANTS
			fn: FILE_NAME					
			--| uncomment the following line when profiling 
			--prof_setting: PROFILING_SETTING
		do
			--| uncomment the following lines when profiling 
			--create prof_setting.make
			--prof_setting.stop_profiling

				-- Check that environment variables
				-- are properly set.
			check_environment_variable

				--| Initialization of the run-time, so that at the end of a store/retrieve
				--| operation (like retrieving or storing the project, creating the CASEGEN
				--| directory, generating the profile information, ...) the run-time is initialized
				--| back to the values which permits the compiler to access correctly the EIFGEN
				--| directory
			create eifgen_init.make

				--| Initialization of global resources.		
			create pref_strs
				-- Initialize pixmaps
			pref_strs.Pixmaps_extension_cell.put ("png")
			create fn.make_from_string (Bitmaps_path)
			fn.extend ("png")
			pref_strs.Pixmaps_path_cell.put (fn)


				-- Initialization of compiler resources.
			setup_preferences
			create new_resources.initialize
			if not new_resources.error_occurred then
					-- Read the resource files
				if argument_count > 0 and then
					(argument (1).is_equal ("-bench") or
					else argument (1).is_equal ("-from_bench"))
				then
					Eiffel_project.set_batch_mode (False)

						-- Initialize debugger communication
					if argument (1).is_equal ("-bench") then
							-- True is for binary
						init_connection (False)
					end

						-- Formatting includes breakpoints
					set_is_with_breakable
	
					create graphic_compiler.make_and_launch
				else
					Eiffel_project.set_batch_mode (True)
					if
						(argument_count > 1 and then 
						argument (1).is_equal ("-precompile") and then
						argument (2).is_equal ("-ace"))
					then
							-- Start the compilation in batch mode from the bench executable.
						create compiler.make
					else
						license.check_activation
						if license.is_licensed or license.can_run then
							create compiler.make
						end
					end
				end
				eifgen_init.dispose
			end

			--| uncomment the following line when profiling 
			--prof_setting.start_profiling
		end

	setup_preferences is
			-- Setup the preferences
		local
			l_prefs: PREFERENCES
			studio_prefs: EB_SHARED_PREFERENCES	
		do
			create l_prefs.make_with_default_values_and_location (system_general, eiffel_preferences)			
			create studio_prefs.make_preferences (l_prefs)						
		end		

feature {NONE} -- Implementation

	graphic_compiler: ES_GRAPHIC
			-- Object needed to interact with Vision2 initialization

	create_handler is do end
			-- Still needed to ensure compatibility with old compiler.

end -- class EB_KERNEL
