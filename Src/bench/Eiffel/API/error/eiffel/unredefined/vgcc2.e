-- Error for a creation of an instance of a deferred class

class VGCC2 

inherit

	VGCC
		redefine
			subcode
		end

feature

	subcode: INTEGER is 2

end
