class FINISH_FREEZING

inherit
	ARGUMENTS

creation
	make

feature -- Initialization

	make is
		local
			retried: BOOLEAN -- did an error occur?
			c_error: BOOLEAN -- did an error occur during C compilation?
			platform: STRING -- the platform we are on
			make_util: STRING -- the C make utility for this platform
			status_box: STATUS_BOX -- the status box displayed at the end of execution
		do
			if not retried then
				set_option_sign ('-')
				!!translator.make

				translator.translate
				translator.run_make

				c_error := c_compilation_error
			end

			if index_of_word_option ("silent") = 0 then
				make_util := translator.options.get_string ("make", "make utility")
				!! status_box.make (make_util, retried, c_error)
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
			!!Result
		end

	c_compilation_error: BOOLEAN is
			-- check if the c-compilation went ok
		local
			completed: PLAIN_TEXT_FILE
		do
			!!completed.make("completed.eif")
			if not completed.exists then
				Result := true
			else
				completed.delete
				Result := false
			end
		end

end -- class FINISH_FREEZING
