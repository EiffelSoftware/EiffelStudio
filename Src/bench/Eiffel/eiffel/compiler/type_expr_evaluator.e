indexing
	description: "Evaluator for type expression"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_EXPR_EVALUATOR 

inherit
	TYPE_EVALUATOR
	
feature

	new_error: VTAT1 is
			-- New error message
		do
			create Result
		end

	update (error_msg: VTAT1) is
		do
		end

end
