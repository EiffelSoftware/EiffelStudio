-- Error for wrong number of generic parameter for an argument type

class VTUG2 

inherit

	VTUG1
		redefine
			subcode
		end;
	
feature 

	subcode: INTEGER is
			-- Error code
		do
			Result := NOT USED
		end;

end
