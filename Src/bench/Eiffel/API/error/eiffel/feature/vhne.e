-- There is no exported feature to NONE

class VHNE obsolete "NOT IN THE BOOK"

inherit

	FEATURE_ERROR
		redefine
			subcode
		end;

feature

	code: STRING is "VUEX";
			-- Error code

	subcode: INTEGER is 2;

end
