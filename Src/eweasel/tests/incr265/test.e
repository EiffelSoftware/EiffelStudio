indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature -- Initialization

	make is
		local
			d: D
		do
			create {E}d
			d.init
			d.selected_action.call ([])
		end

end -- class TEST
