note
	description: "Summary description for {D}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	D
inherit
	C
	  redefine
	  		make
	  end

create
	make

feature -- Initialization

	make
		once
			Precursor
			create other.make_from_string ("Added other")
		end

feature -- Access

	other: STRING

end
