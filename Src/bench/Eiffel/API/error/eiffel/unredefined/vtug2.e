-- Error for wrong number of generic parameter for an argument type

class VTUG2 

inherit

	VTUG
		redefine
			subcode
		end;
	
feature 

	subcode: INTEGER is 2

end
