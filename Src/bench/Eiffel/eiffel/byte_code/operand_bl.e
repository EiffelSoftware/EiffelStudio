-- Enlarged open operand

class OPERAND_BL 

inherit

	OPERAND_B
		redefine
			parent, generate, set_parent, used,
			analyze, free_register, propagate
		end
	
feature 

	parent: NESTED_BL
			-- Parent of access
	
	set_parent (p: NESTED_BL) is
			-- Assign `p' to `parent'
		do
			parent := p
		end

	propagate (r: REGISTRABLE) is
		do
			-- Do nothing
		end

	used (r: REGISTRABLE): BOOLEAN is
		do
			-- Do nothing
		end

	generate is
		do
			-- Do nothing
		end

	analyze is
		do
			-- Do nothing
		end

	free_register is
		do
			-- Do nothing
		end

end -- class OPERAND_BL
