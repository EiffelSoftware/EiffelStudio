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

	query (count: INTEGER)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				i := i + 1
			end
		end

end
