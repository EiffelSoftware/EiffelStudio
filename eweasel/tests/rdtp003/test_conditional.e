indexing
	description: "Test for conditional expressions."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CONDITIONAL

feature

	make is
		local
			b: BOOLEAN
		do
			b := if Current = twin then Current else twin end
			b :=
				if Current = twin then
					Current
				elseif Current ~ twin then
					twin
				else
					Current
				end
		end

end
