class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			(create {B}.make).do_nothing
		end

end
