indexing
	description: "To name automatically each new widget.";
	date: "$Date$";
	revision: "$Revision: "

class NAMER

feature {NONE} -- Properties

	new_name: STRING is
			-- Original name for tool identification
		do
			counter.set_item (counter.item + 1);
			Result := counter.item.out
		end;

	counter: INTEGER_REF is
			-- Shared container of tool identification numbers
		once
			create Result
		end

end -- class NAMER
