indexing
	description: "Objects that ..."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_DBG_EVALUATOR
	
feature {NONE} -- shared dbg_evaluator

	Dbg_evaluator: DBG_EVALUATOR is
			-- Object used for expression evaluation 
			-- to evaluate features and so on ..
		once
			create Result.make
		end
		
	reset_dbg_evaluator is
			-- Reset Dbg_evaluator if exists
			-- needed to be done for each new debugging session
		do
			if dbg_evaluator /= Void then
				dbg_evaluator.reset
			end
		end		

end -- class SHARED_DBG_EVALUATOR
