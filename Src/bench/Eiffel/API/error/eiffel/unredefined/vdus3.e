-- Error when undefinition of a deferred feature

class VDUS3 

inherit

	VDUS2
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 3;

end
