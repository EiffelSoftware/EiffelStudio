indexing
	description: "Class responsible for adding a right corner on the right"
	date: "$Date$"
	revision: "$Revision$"

class
	ADV_RIGHT

inherit
	ADV_COM
		redefine
			symbol
		end

creation
	make

feature -- 

	right: BOOLEAN is TRUE

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		once
			Result := Pixmaps.left_handle
		end;


end -- class ADV_RIGHT
