class
	TEST1

create
	make_once

feature {NONE} -- Initialization

	make_once
		once
			create value.make_from_string ("test1")
		end

feature -- Access

	value: STRING

end
