note
	description: "Summary description for {C}."
	date: "$Date$"
	revision: "$Revision$"

class
	C

inherit

	A
		redefine
			make
		end
create
	make
	
feature {NONE}

	make
		do
			create t.make_from_string ("A<-C")
		end

end
