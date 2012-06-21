note
	description: "Objects that represent persons"
	author: "VT"

class
	PERSON

create
	make

feature {NONE} -- Initialization

	make (n: STRING; a: INTEGER)
			-- Initialize `Current'.
		do
			name := n
			age := a
		end

feature
	
	name: STRING
	age: INTEGER

end -- class PERSON
