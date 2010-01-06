indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature -- Initialization

	make is
		local
			l_proc: PROCEDURE [ANY, TUPLE]
		do
			l_proc := agent (v: A) 
				do
				end
		end

	$NEW_CODE

end -- class TEST
