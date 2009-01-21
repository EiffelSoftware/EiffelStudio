note
	description: "Summary description for {A}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A

feature
	my_routine
		require
			may_be_called: True
		do
			print ("Not Ok")
		end

end
