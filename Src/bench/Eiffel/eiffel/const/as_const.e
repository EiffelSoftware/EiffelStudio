-- Assertion level byte code constant.
-- These values have to match with those in run-time file constant.h

class AS_CONST

feature {NONE}

	As_no:			CHARACTER is 'n';
	As_require: 	CHARACTER is 'r';
	As_ensure: 		CHARACTER is 'e';
	As_invariant: 	CHARACTER is 'i';
	As_loop:		CHARACTER is 'l';
	As_check:		CHARACTER is 'c';

end
