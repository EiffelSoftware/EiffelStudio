indexing

	description: 
		"Error for invalid renaming. Renaming a feature as itselt.";
	date: "$Date$";
	revision: "$Revision $"

class VHRC3 obsolete "NOT DEFINED IN THE BOOK"

inherit

	VHRC
		redefine
			subcode
		end;
	
feature -- Properties

	subcode: INTEGER is 3;

end -- class VHRC3
