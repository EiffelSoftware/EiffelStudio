-- Error for unvalid renaming
-- renaming a feature as itselt

class VHRC3 obsolete "NOT DEFINED IN THE BOOK"

inherit

	VHRC
		redefine
			subcode
		end;
	
feature 

	subcode: INTEGER is 3;

end
