-- Evalauator of result type

class RESULT_EVALUATOR 

inherit

	TYPE_EVALUATOR
		redefine
			new_error
		end
	
feature

	new_error: VTAT1R is
			-- New error message
		do
			!!Result;
		end;

end
