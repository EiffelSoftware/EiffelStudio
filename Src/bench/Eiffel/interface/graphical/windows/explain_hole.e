indexing

	description:	
		"Hole for explain element.";
	date: "$Date$";
	revision: "$Revision$"

class EXPLAIN_HOLE 

inherit

	EB_BUTTON_HOLE
		redefine
			stone_type
		end

creation

	make
	
feature  -- Properties

	stone_type: INTEGER is
			-- Type of compatible stone.
		do
			Result := Explain_type
		end

end -- class EXPLAIN_HOLE
