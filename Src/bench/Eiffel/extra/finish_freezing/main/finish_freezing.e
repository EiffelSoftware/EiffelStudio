class FINISH_FREEZING

inherit
	ARGUMENTS

	EXECUTION_ENVIRONMENT
		rename
			command_line as non_used_command_line
		export
			{NONE} non_used_command_line
		end

create
	make

feature -- Initialization

	make is
		local
			retried: BOOLEAN -- did an error occur?
			c_error: BOOLEAN -- did an error occur during C compilation?
			l_msg, make_util: STRING -- the C make utility for this platform
			status_box: STATUS_BOX -- the status box displayed at the end of execution
			location: STRING
			location_index: INTEGER
			unc_mapper: UNC_PATH_MAPPER
			mapped_path: BOOLEAN
			l_exception: EXCEPTIONS
			gen_only: BOOLEAN
		do
			if not retried then
					-- Location defaults to the current directory
				location := current_working_directory
	
					-- if location has been specified, update it
				location_index := index_of_word_option ("location")
				if location_index /= 0 and then argument_count >= location_index + 1 then
					location := argument (location_index + 1)
				end
				
					-- if generate_only is specified then only generate makefile
				gen_only := index_of_word_option ("generate_only") /= 0
			
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
	
				set_option_sign ('-')
				create translator.make (mapped_path)

				translator.translate
				if not gen_only and translator.has_makefile_sh then
						-- We don't want to be launched when there is no Makefile.SH file.
					translator.run_make
					c_error := c_compilation_error
				end
			end

				-- Destroy network path mapping if any
			if unc_mapper /= Void then
				unc_mapper.destroy
				unc_mapper := Void
			end
 
			if not gen_only then
				if translator = Void then
					l_msg := "Internal error during Makefile translation preparation.%N%N%
							%Please report this problem to Eiffel Software at:%N%
							%http://support.eiffel.com"
					if index_of_word_option ("silent") = 0 then
						create status_box.make_fatal (l_msg)
					else
						io.put_string (l_msg)
						io.default_output.flush
					end
				else
					if translator.has_makefile_sh then
						if index_of_word_option ("silent") = 0 then
							make_util := translator.options.get_string ("make", "make utility")
							create status_box.make (make_util, retried, c_error, False, False)
						else
							if not c_error then
									-- For eweasel processing
								io.put_string ("C compilation completed%N")
								io.default_output.flush
							end
						end
					else
						if index_of_word_option ("silent") /= 0 and translator.is_il_code and not c_error then
								-- For eweasel processing
							io.put_string ("C compilation completed%N")
							io.default_output.flush
						end
					end
				end
			end
			if index_of_word_option ("vs") /= 0 then
				if retried or else (c_error and not gen_only) then
						-- Make the application return a non-zero value to OS to flag an error
						-- to calling process.
					create l_exception
					l_exception.die (1)
				end
			end	
		rescue
			retried := True
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
				Result := True
			else
				completed.delete
				Result := False
			end
		end

end -- class FINISH_FREEZING
