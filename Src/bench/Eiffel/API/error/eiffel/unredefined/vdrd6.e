-- Error when an attribute is redefined in something else that an attribute

class VDRD6 

inherit

	VDRD5
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 6;

end 
