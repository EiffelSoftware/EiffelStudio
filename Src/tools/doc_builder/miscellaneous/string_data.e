indexing
	description: "String with arbitrary data."
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_STRING

inherit
	STRING

create
	make_from_string

feature -- Access

	data: ANY
			-- Data
		
feature -- Status Setting

	set_data (a_data: ANY) is
			-- Set `dats'
		do
			data := a_data
		ensure
			data_set: data = a_data
		end		

end -- class ARBITRARY_DATA
