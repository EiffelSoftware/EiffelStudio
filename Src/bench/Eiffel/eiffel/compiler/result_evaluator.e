-- Evalauator of result type

class
	RESULT_EVALUATOR 

inherit
	TYPE_EVALUATOR
	
feature

	new_error: VTAT1R is
			-- New error message
		do
			create Result
		end

	update (error_msg: VTAT1) is
		do
		end

end
