indexing
	description: "Object representing a CLR host. It should be a singleton for the entire system."
	date: "$Date$"
	revision: "$Revision$"

class
	CLR_HOST

inherit
	COM_OBJECT

create {CLR_HOST_FACTORY}
	make_by_pointer

end -- class CLR_HOST
