note
	description: "Test if a precondition violation is correctly handled."
	author: "Florian Besser"
	date: "$Date$"
	revision: "$Revision$"

class
	C

feature

	self: C
		do
			Result := Current
		end

	always_false: BOOLEAN
		do
			Result := False
		end
end
