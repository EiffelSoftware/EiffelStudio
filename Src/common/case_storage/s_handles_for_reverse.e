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

	get_handles(cl : LINKABLE_DATA ) : LINKED_LIST [ HANDLE_DATA ] is
		local
			hand : HANDLE_DATA
		do
			!! Result.make
			if list/= Void and then list.count>0 then
				from
					list.start
				until
					list.after
				loop
					!! hand
					hand.set_x ( list.item.x)
					hand.set_y ( list.item.y)
					hand.set_from ( cl )
					Result.extend (hand)
					list.forth
				end
			end
		end
	

feature -- attributes

	list : LINKED_LIST [ S_HANDLE_REVERSE ]

end -- class S_HANDLES_FOR_REVERSE
