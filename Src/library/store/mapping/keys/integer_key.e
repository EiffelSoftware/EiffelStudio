indexing
	description: ""
	author: "David Solal"
	date: "$ Date: "
	revision: "$ Revision: "

class
	INTEGER_KEY

inherit
	BASIC_KEY
		redefine
			item
		end

create
	make

feature -- Access

	item : INTEGER_REF

end -- class INTEGER_KEY
