note
	description: "Summary description for {B}."
	date: "$Date$"
	revision: "$Revision$"

class
	B

inherit

	A
		redefine
			make
		end

create
	make
	
feature {NONE}

	make
		once
			create t.make_from_string ("A<-B")
		end

end
