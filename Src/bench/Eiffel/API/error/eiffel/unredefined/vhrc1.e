-- Error for unvalid renaming

class VHRC1 

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature 

	parent_id: INTEGER;
			-- Id of the invloved parent

	feature_name: STRING;
			-- Feature name not present in feature table of parent
			-- class: this is an internal name so an infix notation
			-- will have the name "_infix..." (smae thing for prefixed
			-- notation.

	code: STRING is "VHRC";
			-- Error for unvalid renaming

	subcode: INTEGER is 1;

	set_parent_id (i: INTEGER) is
			-- Assgn `i' to `parent_id'.
		do
			parent_id := i;
		end;

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

end
