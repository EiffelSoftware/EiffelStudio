-- Error when two local variables (or more) have the same name

class VRLE2 

inherit

	VRLE1
		redefine
			subcode
		end;
	
feature 

	subcode: INTEGER is 2;

end
