indexing
	description: "Core of the application"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_KERNEL

inherit
	EB_SHARED_INTERFACE_TOOLS

	EIFFEL_ENV

	ISED_X_SLAVE

	EV_COMMAND

	NEW_EB_CONSTANTS

	ARGUMENTS
		rename
			command_line as arguments_line
		end

	SHARED_BENCH_LICENSES

	SHARED_CONFIGURE_RESOURCES

	SHARED_EIFFEL_PROJECT

creation
	make

feature -- Initialization

	make is
			-- Create and map the first window: the system window.
		local
			temp: STRING
			new_resources: EB_RESOURCES_INITIALIZER
			compiler: ES
			graphic_compiler: ES_GRAPHIC
			eifgen_init: INIT_SERVERS
			project_index, create_project_index: INTEGER
			open_project: EB_OPEN_PROJECT_CMD
			new_project: EB_NEW_PROJECT_CMD
			memory: MEMORY
		do
			if not retried then
					-- Check that environment variables
					-- are properly set.
				temp := Execution_environment.get ("EIFFEL4")
				if (temp = Void) or else temp.empty then
					io.error.putstring ("ISE Eiffel4: the environment variable $EIFFEL4 is not set%N")
					die (-1)
				end
				temp := Execution_environment.get ("PLATFORM")
				if (temp = Void) or else temp.empty then
					io.error.putstring ("ISE Eiffel4: the environment variable $PLATFORM is not set%N")
					die (-1)
				end

					-- Check then for the license and make sure that we are allowed to launch the
					-- product.
--debug				if init_license then

						--| Initialization of the run-time, so that at the end of a store/retrieve
						--| operation (like retrieving or storing the project, creating the CASEGEN
						--| directory, generating the profile information, ...) the run-time is initialized
						--| back to the values which permits the compiler to access correctly the EIFGEN
						--| directory
--debug					create eifgen_init.make

						-- Read the resource files
					if argument_count > 0 and then
						(argument (1).is_equal ("-bench") or
						else argument (1).is_equal ("-from_bench"))
					then
						Eiffel_project.set_batch_mode (False)
						init_connection (argument (1).is_equal ("-bench"))

--|
					create eifgen_init.make
--|

--						if toolkit = Void then end
						create memory
						memory.set_collection_period (Configure_resources.get_integer (r_collection_period, memory.collection_period))
--						project_index := index_of_word_option ("project")
--						if project_index /= 0 then
--								-- Project open by `ebench name_of_project.epr'
--							create open_project.make_from_project_file (Project_tool, argument (project_index + 1))
--							open_project.open_from_ebench
--						else
--								-- Project create by `ebench -create my_path'
--							create_project_index := index_of_word_option ("create")
--							if create_project_index /= 0 then
--								create new_project.make_from_ebench (Project_tool, argument (create_project_index + 1))
--							end
--						end
--| FIXME
--| Christophe, 26 oct 1999
--| Options for launching es4. Not implemented yet.
						create graphic_compiler.make_with_caller (Current)
					else
						Eiffel_project.set_batch_mode (True)
						create new_resources.initialize	
						create memory
						memory.set_collection_period (Configure_resources.get_integer (r_collection_period, memory.collection_period))
							-- Start the compilation in batch mode from the bench executable.
						create compiler.make_unlicensed
						discard_licenses
					end
--debug				end
			else
					-- Ensure clean exit in case of exception
				die (-1)
			end
		rescue
			discard_licenses
			if not Eiffel_project.batch_mode then
					-- The rescue in ES will display the tag
				io.error.putstring ("ISE Eiffel4: Session aborted%N")
				io.error.putstring ("Exception tag: ")
				temp := original_tag_name
				if temp /= Void then
					io.error.putstring (temp)
				end
				io.error.new_line
			end
			if not fail_on_rescue then
				retried := True
				retry
			end
		end

feature -- Properties

	retried: BOOLEAN
			-- For rescues

feature {NONE} -- Initialization

--	init_toolkit: TOOLKIT_IMP is
--		once
--			create Result.make (Interface_names.n_X_resource_name)
--		end

feature -- Communications

	listen_to: RAW_FILE
			-- File used to listen 

	create_handler is
		local
			listener: EB_FILE_LISTENER
		do
				-- Associate the file descriptor corresponding
				-- to the pipe on which reading is done
				-- with `listen_to'.
			create listen_to.make ("toto")
			listen_to.fd_open_read (Listen_to_const)

			create listener.make (listen_to, Current, Void)

--			app_context := init_toolkit.application_context
				-- Add an IO handler which
				-- listens to the appropriate
				-- pipe.
				-- Set `Current' as callback to be called
				-- when there is something new to read on
				-- the `Listen_to_const' pipe.
--			app_context.set_input_read_callback (listen_to, Current, Void)
	        end
--| FIXME
--| Christophe, 26 oct 1999
--| Class EB_FILE_LISTENER has been created for handling the problem.
--| This class could be packed with the vision2 library.

end -- class EB_KERNEL
