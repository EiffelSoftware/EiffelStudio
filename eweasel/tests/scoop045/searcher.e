note
	description: "Mock class for a search algorithm."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCHER

feature

	solution: INTEGER

	has_solution: BOOLEAN

	search (input: INTEGER)
			-- Stub feature for search algorithm.
			-- If input < 0, throws an exception.
			-- If input = 0, no solution found.
			-- If input > 0, solution found.
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			if input > 0 then
				solution := input
				has_solution := True
			else
				solution := 0
				has_solution := False
			end
			
			if input < 0 then
				create l_exception
				l_exception.raise
			end
		end

end
