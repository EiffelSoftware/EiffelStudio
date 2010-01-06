class
	TEST

create
	make, default_create

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_file: RAW_FILE
			l_obj: like Current
		do
			$CREATE
			create l_file.make ("titi")
			if l_file.exists then
				l_file.open_read
				l_obj ?= l_file.retrieved
				l_file.close
			else
				l_file.open_write
				l_file.independent_store (Current)
				l_file.close
			end
		end

	$ATTRIBUTE

end
