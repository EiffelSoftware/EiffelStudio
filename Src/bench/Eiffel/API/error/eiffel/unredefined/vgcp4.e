-- Error when an expanded class has a creation clause of several features
-- or a feature with arguments

class VGCP4 

inherit

	VGCP21
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 4;

end
