indexing
	description: "Put an handle left"
	date: "$Date$"
	revision: "$Revision$"

class
	ADV_LEFT

inherit
	ADV_COM
		redefine
			symbol
		end

creation
	make

feature --properties

	right : BOOLEAN is FALSE

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated.
		once
			Result := Pixmaps.right_handle
		end;

end -- class ADV_LEFT
