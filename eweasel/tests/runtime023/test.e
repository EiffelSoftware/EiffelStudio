class
	TEST

create
	default_create,
	make

feature {NONE} -- Initialization

	make
			-- Run application
		local
			a: VALUE
		do
			a.twin.do_nothing
		end

end
