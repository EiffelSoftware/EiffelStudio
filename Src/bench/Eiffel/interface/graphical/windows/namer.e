indexing

	description:	
		"To name automatically each new widget.";
	date: "$Date$";
	revision: "$Revision: "

class NAMER

feature {NONE} -- Properties

	new_name: STRING is
			-- Original name for tool identification
		do
			counter.put (counter.item + 1);
			Result := counter.item.out
		end;

	counter: CELL [INTEGER] is
			-- Shared container of tool identification numbers
		once
			!!Result.put (0)
		end

end -- class NAMER
