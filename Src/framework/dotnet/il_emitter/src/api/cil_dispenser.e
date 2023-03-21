note
	description: "Summary description for {CIL_DISPENSER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_DISPENSER

create
	make

feature {NONE}

	make
		do
		end

feature -- Access

	emit: CIL_EMIT
		do
			create Result.make (Current)
		end
end
