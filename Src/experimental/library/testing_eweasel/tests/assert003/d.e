note
	description: "Summary description for {D}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	D

feature
	my_routine
		require
			may_not_be_called: False
		do
			print ("my_routine")
		end

end
