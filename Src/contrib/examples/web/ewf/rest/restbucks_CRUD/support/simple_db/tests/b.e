note
	description: "Summary description for {B}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	B

create
	make

feature

	make (k: STRING; b: BOOLEAN; v: STRING)
		do
			key := k
			value := v
			state := b
		end

feature -- Access

	key: STRING

	value: STRING

	state: BOOLEAN

end
