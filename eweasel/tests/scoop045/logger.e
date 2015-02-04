note
	description: "Mock class for a result logger."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGGER

feature

	solution: INTEGER
			-- The last solution found in one of the searchers.

	log (a_first_searcher, a_second_searcher: separate SEARCHER)
			-- Try to log the solution of the first searcher, and if that fails, 
			-- log from the second searcher.
		local
			retried: BOOLEAN
		do
			if not retried then
				if a_first_searcher.has_solution then
					print ("In {LOGGER}.log: Using first solution.%N")
					solution := a_first_searcher.solution
				else
					print ("In {LOGGER}.log: Using second solution.%N")
					solution := a_second_searcher.solution
				end
			end
		rescue
			print ("In rescue of {LOGGER}.log.%N")
			retried := True
			retry
		end

end
