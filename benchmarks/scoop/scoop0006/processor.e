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

	query
		do
		end


	query1 (p: separate PROCESSOR)
		do
			p.query
		end

end
