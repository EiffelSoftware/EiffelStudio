indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	S_HANDLES_FOR_REVERSE

creation
	make

feature -- Initialization

	make is
		do
			!! list.make
		end

feature -- attributes

	list : LINKED_LIST [ S_HANDLE_REVERSE ]

end -- class S_HANDLES_FOR_REVERSE
