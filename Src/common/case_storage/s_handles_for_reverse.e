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


feature -- extract result

	put_handles is
		do
		end
	

feature -- attributes

	list : LINKED_LIST [ S_HANDLE_REVERSE ]

	set_list ( l : LINKED_LIST [ S_HANDLE_REVERSE ] ) is
		do
			list := l
		end

end -- class S_HANDLES_FOR_REVERSE
