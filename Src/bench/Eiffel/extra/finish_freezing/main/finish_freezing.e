class FINISH_FREEZING

inherit
	ARGUMENTS

	EXECUTION_ENVIRONMENT
		rename
			command_line as non_used_command_line
		export
			{NONE} non_used_command_line
		end

creation
	make

feature -- Initialization

	make is
		local
			retried: BOOLEAN -- did an error occur?
			c_error: BOOLEAN -- did an error occur during C compilation?
			make_util: STRING -- the C make utility for this platform
			status_box: STATUS_BOX -- the status box displayed at the end of execution
			location: STRING
			location_index: INTEGER
			unc_mapper: UNC_PATH_MAPPER
			mapped_path: BOOLEAN
		do
				-- Location defaults to the current directory
			location := current_working_directory

				-- if location has been specified, update it
			location_index := index_of_word_option ("location")
			if location_index /= 0 and then argument_count >= location_index + 1 then
				location := argument (location_index + 1)
			end
			
				-- Map `location' if it is a network path if needed
			if location.substring (1, 2).is_equal ("\\") then
				create unc_mapper.make (location)
				if unc_mapper.access_name /= Void then
					mapped_path := True
					location := unc_mapper.access_name + "\"
				end
			end
			
				-- Change the working directory if needed
			if not location.is_equal (current_working_directory) then
				change_working_directory (location)				
			end

			if not retried then
				set_option_sign ('-')
				create translator.make (mapped_path)

				translator.translate
				translator.run_make

				c_error := c_compilation_error
			end
			
				-- Destroy network path mapping if any
			if unc_mapper /= Void then
				unc_mapper.destroy
				unc_mapper := Void
			end

			if index_of_word_option ("silent") = 0 then
				make_util := translator.options.get_string ("make", "make utility")
				create status_box.make (make_util, retried, c_error, False, False)
			end
		rescue
			retried := true
			retry
		end

feature -- Access

	translator: MAKEFILE_TRANSLATOR		
			-- used to translate Makefile.SH into Makefile

	env: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

	c_compilation_error: BOOLEAN is
			-- check if the c-compilation went ok
		local
			completed: PLAIN_TEXT_FILE
		do
			create completed.make("completed.eif")
			if not completed.exists then
				Result := true
			else
				completed.delete
				Result := false
			end
		end

end -- class FINISH_FREEZING
