note
	description: "Test if a precondition violation is correctly handled."
	author: "Florian Besser"
	date: "$Date$"
	revision: "$Revision$"

class
	B

feature

	g (c1, c2: separate C)
		require
			trigger_violation: c1.self.always_false and c2.self.always_false
		once
			print ("ERROR: In body of {B}.g %N")
		rescue
			print("ERROR: In rescue of {B}.g %N")
		end

end
