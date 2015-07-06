note
	description: "Test if the argument passing rule in SCOOP is correctly applied to generic classes."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make, default_create

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_list: separate LINKED_LIST [STRING]
			l_test_list: separate TEST
		do
			create l_list.make
			create l_test_list

			separate l_list as l do
				l.extend ("abc")
			end
			separate l_test_list as tl do
				tl.extend ("def")
			end
		end

feature -- Element change

	extend (s: STRING)
			-- TEST also serves as a stub list with no generic arguments.
		do
		end

end
