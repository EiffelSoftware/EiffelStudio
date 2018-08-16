note
	description: "Summary description for {A}."
	date: "$Date$"
	revision: "$Revision$"

class
	A

create
	make

feature {NONE} -- Initialization

	make
		do
			create t.make_from_string ("A")
		end

feature -- Access

	t: STRING

end
