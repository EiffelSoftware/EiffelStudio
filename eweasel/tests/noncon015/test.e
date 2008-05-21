class
	TEST

inherit {NONE}
	LINKED_LIST [STRING]
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
