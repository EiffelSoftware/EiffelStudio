class
	CAT_SELF_ASSIGNMENT
	
feature {NONE} -- Test

	self_assignment
			-- Violates the self-assignment rule.
		local
			a: INTEGER
		do
			a := 5
			a := a
			b := b
		end
		
	b: INTEGER
	
end
