indexing
	description: "Page on which is displayed the usable color"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PALETTE_PAGE

inherit
	ONCES
		
	CONSTANTS

creation
	make

feature -- Initialization

	make(par: EV_NOTEBOOK) is
		require
			notebook_exists: par /= Void
		local
			h1: EV_HORIZONTAL_BOX
		do
			!! h1.make(par)
			par.append_page(h1,"Colors") 	
		end

	update is do end
end -- class PALETTE_PAGE
