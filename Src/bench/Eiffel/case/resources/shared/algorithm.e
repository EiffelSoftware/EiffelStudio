indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
  evision: "$Revision$"

class
	ALGORITHM [G]

feature -- Conversion
		
	linked_list_to_array (l : LINKED_LIST [G]): ARRAY [G] is
		local
			i: INTEGER
		do
			if l /= Void then
				!! Result.make (0, l.count - 1)

				from
					l.start
					i := 0
				until
					l.after
				loop
					Result.put (l.item, i)
					
					l.forth
					i := i + 1
				end
			end
		end

end -- class ALGORITHM
