indexing
	description: "Objects that stores all the info needed for validity checking of a declaration%N%
			%of a generic class with its generic creation constraint part"
	author: "Emmanuel STAPF"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRAINT_CHECKING_INFO

create
	make

feature -- Initialization

	make (
			c_class: like context_class;
			p: like action) is
				-- Initialize all the fields.
		require
			c_class_not_void: c_class /= Void
			p_not_void: p /= Void
		do
			context_class := c_class
			action := p
		ensure
			context_class_set: context_class = c_class
			action_set: action = p
		end

feature -- Access

	context_class: CLASS_C
			-- Class where the occurrence of generic type to be checked appears
			
	action: PROCEDURE [ANY, TUPLE]
			-- Action launched in context of current to check validity of constraint
			
invariant
	context_class_not_void: context_class /= Void
	action_not_void: action /= Void

end -- class CONSTRAINT_CHECKING_INFO
