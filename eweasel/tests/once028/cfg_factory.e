note
	description: "Summary description for {CFG_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	CFG_FACTORY

create
	make

feature -- Implementation

	make
		do
			create b.make
		end

feature -- Access

	b: like {CFG}.c

end
