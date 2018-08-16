note
	description: "Summary description for {CFG_FACTORY_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CFG_FACTORY_2
inherit

	CFG_FACTORY
		redefine
			b
		end

create
	make

feature -- Implementation

	b: like {CFG}.d

end
