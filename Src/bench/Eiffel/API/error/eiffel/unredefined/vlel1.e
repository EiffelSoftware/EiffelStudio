-- keyword all in export clause is repeated more than once

class VLEL1 

inherit

	VLEL
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is 1;

	build_explain is
		do
			print_parent;
		end;

end
