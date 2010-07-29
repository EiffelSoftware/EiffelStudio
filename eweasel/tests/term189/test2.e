class TEST2 [G]
inherit
	TEST1 [G]
		redefine
			integer_value_at
		end

feature

	integer_value_at (a_target : G; a_agent : like access_agent_template) : INTEGER
		do

		end
end

