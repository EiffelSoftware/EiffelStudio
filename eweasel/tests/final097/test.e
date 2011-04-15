note
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature

	make
		local
			u: USABLE
		do
			create t1
			t1.bind_help_shortcut ("")

			u := t1
			if attached {RECYCLABLE} t1 as r then
				print (r.is_interface_usable)
			end
			print (u.is_interface_usable)
		end

	t1: TEST5 [INTEGER]
	t2: TEST5 [STRING]

end
