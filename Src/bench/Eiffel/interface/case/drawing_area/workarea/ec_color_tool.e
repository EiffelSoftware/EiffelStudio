indexing
	description: "Tool which allows selecting colors."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_COLOR_TOOL

inherit
	EV_COLOR_DIALOG
		redefine
			make
		end
creation
	make

feature -- Creation

	make (par: EV_CONTAINER) is
		do
			precursor(par)
		end

end -- class EC_COLOR_TOOL
