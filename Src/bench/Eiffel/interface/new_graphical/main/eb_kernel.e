indexing
	description: "Core of the application"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_KERNEL

inherit
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

	SHARED_BENCH_LICENSES
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

create
	make

feature {NONE} -- Initialization

	make is
			-- Create and map the first window: the system window.
		local
			compiler: ES
			eifgen_init: INIT_SERVERS
			memory: MEMORY
			new_resources: TTY_RESOURCES
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

				-- Initialization of compiler resources.
			create new_resources.initialize
			if not new_resources.error_occurred then
				create memory
				memory.set_collection_period (
						Configure_resources.get_integer (r_collection_period,
								memory.collection_period))

					-- Read the resource files
				if argument_count > 0 and then
					(argument (1).is_equal ("-bench") or
					else argument (1).is_equal ("-from_bench"))
				then
						-- Check then for the license and make sure that we are allowed to launch the
						-- product.
					if init_license then
						Eiffel_project.set_batch_mode (False)
	
							-- Initialize debugger communication
						if argument (1).is_equal ("-bench") then
								-- True is for binary
							init_connection (False)
						end
	
							-- Formatting includes breakpoints
						set_is_with_breakable
	
						create graphic_compiler.make_and_launch
					end
				else
					if
						(argument_count > 0 and then 
						argument (1).is_equal ("-precompile")) or else init_license
					then
						Eiffel_project.set_batch_mode (True)
	
							-- Start the compilation in batch mode from the bench executable.
						create compiler.make_unlicensed
						discard_licenses
					end
				end
				eifgen_init.dispose
			end

			--| uncomment the following line when profiling 
			--prof_setting.start_profiling
		end

feature {NONE} -- Implementation

	graphic_compiler: ES_GRAPHIC
			-- Object needed to interact with Vision2 initialization

	create_handler is do end
			-- Still needed to ensure compatibility with old compiler.

end -- class EB_KERNEL
