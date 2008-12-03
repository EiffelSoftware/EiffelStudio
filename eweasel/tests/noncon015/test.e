class
	TEST

inherit {NONE}
	TEST1 [STRING]
		rename
			make as list_make
		undefine
			is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
		end

end
