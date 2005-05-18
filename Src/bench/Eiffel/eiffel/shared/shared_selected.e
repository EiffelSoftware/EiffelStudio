class SHARED_SELECTED
	
feature {NONE}

	Selected: LINKED_LIST [INTEGER] is
			-- Feature actually selected by second pass: the goal is to 
			-- track useless selection
		once
			create Result.make
		end

end
