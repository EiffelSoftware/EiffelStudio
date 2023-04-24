note
	description: "Summary description for {APPLICATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	APP

create
	make

feature {NONE} -- Implementation

	make
		do
			print ("cli_writer is only for Windows%N")
		end
end
