note
	description: "Summary description for {PROCESSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESSOR

create
	make

feature

	make
		do

		end

	query: ITEM
		once
			create Result.make
		end

end
