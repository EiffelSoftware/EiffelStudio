indexing
	description:
		""

	status:	"See note at end of class"
	author: "Patrick Schoenbach"
	date: "$Date$"
	revision: "$Revision$"

class 
	TEST

create

	make
	
feature {NONE} -- Initialization

	make is
		local
			d: DATE
			t: TIME
		do
			create d.make_from_string ("20010101", "yyyy[0]mm[0]dd")
			create t.make_from_string ("180500", "[0]hh[0]mi[0]ss")
			create d.make_from_string ("01.01.2001", "dd.mm.yyyy")
		end

end -- class TEST

 
