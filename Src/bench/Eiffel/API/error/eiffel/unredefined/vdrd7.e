-- Error when an non-deferred feature is redefined into a deferred one

class VDRD7 

inherit

	VDRD5
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 7;

end
