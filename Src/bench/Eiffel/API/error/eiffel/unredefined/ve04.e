indexing

	description: 
		"Error for invalid parent type: %
			%1. Anchor in generical parameters %
			%2. NONE cannot be a parent.";
	date: "$Date$";
	revision: "$Revision $"

class VE04 obsolete "NOT DEFINED IN THE BOOK"

inherit

	EIFFEL_ERROR
		redefine
			subcode
		end;

feature -- Properties

	parent_type: CLASS_TYPE_AS;
			-- Parent type involved in the error

	code: STRING is "VHPR";
			-- Error code

	subcode: INTEGER is 3

feature {COMPILER_EXPORTER} -- Setting

	set_parent_type (p: like parent_type) is
			-- Assign `o' to `parent_type'.
		do
			parent_type := p;
		end;

end -- class VE04
