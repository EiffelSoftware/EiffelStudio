
-- To name automatically each new widget

class NAMER

feature {NONE}

	new_name: STRING is
			-- Original name for tool identification
		do
			counter.put (counter.item + 1);
			Result := counter.item.out
		end;

	counter: CELL [INTEGER] is once !!Result.put (0) end
			-- Shared container of tool identification numbers

end
