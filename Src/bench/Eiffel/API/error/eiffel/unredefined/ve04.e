-- Error for unvalid parent type:
--	1. Anchor in generical parameters
--	2. NONE cannot be a parent

class VE04 obsolete "NOT DEFINED IN THE BOOK"

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature

	parent_type: TYPE_A;
			-- Parent type einvolved in the error

	set_parent_type (p: TYPE_A) is
			-- Assign `o' to `parent_type'.
		do
			parent_type := p;
		end;

	code: STRING is "VHPR";
			-- Error code

	subcode: INTEGER is 3

end
