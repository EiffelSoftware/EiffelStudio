-- Abstract description of a reverse assignment

class REVERSE_AS

inherit

	ASSIGN_AS
		redefine
			assign_symbol
		end

feature {} -- Formatter
	
	assign_symbol: TEXT_ITEM is 
		do
			Result := ti_Reverse_assign
		end;

end
