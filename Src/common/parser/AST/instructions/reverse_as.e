indexing

	description: 
		"AST representation of a reverse assignment";
	date: "$Date$";
	revision: "$Revision$"

class REVERSE_AS

inherit

	ASSIGN_AS
		redefine
			assign_symbol
		end

feature {NONE} -- Formatter
	
	assign_symbol: TEXT_ITEM is 
		once
			Result := ti_Reverse_assign
		end

end -- class REVERSE_AS
