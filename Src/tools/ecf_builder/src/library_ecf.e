note
	description: "Summary description for {LIBRARY_ECF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_ECF

inherit
	ECF
		redefine
			make,
			process
		end

create
	make

feature {NONE} -- Implementation

	make (a_name: STRING)
		do
			Precursor (a_name)
		end

feature -- Visitor

	process (v: ECF_VISITOR)
		do
			v.process_library_ecf (Current)
		end

end
