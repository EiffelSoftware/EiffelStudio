class SHARED_SELECTED
	
feature {NONE}

	Selected: LINKED_LIST [STRING] is
			-- Feature actually selected by second pass: the goal is to 
			-- track useless selection
		once
			!!Result.make;
		end;

end
