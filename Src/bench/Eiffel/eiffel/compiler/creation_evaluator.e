-- Evaluator for creation type

class
	CREATION_EVALUATOR 

inherit
	TYPE_EVALUATOR
	
feature

	new_error: VTAT1C is
			-- New error message
		do
			!! Result
		end

	update (error_msg: VTAT1C) is
			-- Update error message
		do
			-- Nothing to do
		end

end -- class CREATION_EVALUATOR
