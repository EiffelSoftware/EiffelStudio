-- Open operand

class OPERAND_B 

inherit
	ACCESS_B
		redefine
			enlarged
		end
	
feature 

	type: REFERENCE_I is
			-- Type of operand.
		once
			!!Result
		end

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			operand_b: OPERAND_B
		do
			operand_b ?= other
			Result := operand_b /= Void
		end

	enlarged: OPERAND_B is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
			!OPERAND_BL!Result
		end

end
