note
	description: "project2 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		local
			l_a, l_b: INTEGER
		do
			l_a := 4
			l_b := 6
			if half (l_a) = half (l_b) then
				io.put_string ("The halves of the numbers are equal.")
			end
		end

	half (a_number: INTEGER): INTEGER
		do
			Result := a_number // 2
		end

end
