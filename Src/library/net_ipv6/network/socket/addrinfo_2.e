indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	ADDRINFO_2

inherit

	ADDRINFO_1
		redefine
			c_free
		end

create

	make_from_external

feature {NONE} -- Externals

	c_free (obj_ptr: POINTER) is
		do
		end

end

