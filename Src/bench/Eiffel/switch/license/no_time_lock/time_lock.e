class TIME_LOCK

creation
	make

feature {NONE} -- Initialization

	make (init_dir: DIRECTORY_NAME) is
			-- Initialize time lock.
		do
			Licensed := True
		end

feature -- Access

	licensed: BOOLEAN
				-- Is the produce licensed?

end -- class TIME_LOCK
