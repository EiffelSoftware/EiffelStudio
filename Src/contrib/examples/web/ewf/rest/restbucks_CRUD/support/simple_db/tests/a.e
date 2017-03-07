note
	description: "Summary description for {A}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A

create
	make_with_name

feature {NONE} -- Initialization

	make_with_name (n: STRING)
		do
			name := n
			create items.make (0)
		end

feature -- Access

	name: STRING

	count: INTEGER

	items: ARRAYED_LIST [B]

feature -- Element change

	extend (b: B)
		do
			items.extend (b)
			count := items.count
		end

end

