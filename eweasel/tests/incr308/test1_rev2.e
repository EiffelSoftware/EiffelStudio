
deferred class TEST1 [G -> STRING create make end]

feature
	s: STRING
	   deferred
	   end

	-- After initial compilation (void-safe), change to ?G and comment
	-- out body of `t'

	t: G
	   do
		-- create Result.make (3)
	   end

end
