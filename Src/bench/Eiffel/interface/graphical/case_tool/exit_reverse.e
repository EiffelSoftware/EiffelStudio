indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	EXIT_REVERSE

inherit
	CASE_COMMAND2

creation

	make

feature

	execute (a: ANY) is 
		do
			case_window.hide
		end	

end -- class EXIT_REVERSE
