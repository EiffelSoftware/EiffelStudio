note
	description: "[
		Check that there are no leftovers from the checks for `b'.
		There is no control flow graph for a? and c? features, so it should be ignored.
	]"

deferred class A

feature {NONE} -- Test

	a1: INTEGER
	a2: INTEGER = 2
	a3: INTEGER external "C inline" alias "3" end
	a4: INTEGER deferred end

	b
		local
			x: INTEGER
		do
				-- Set a variable but do not use it.
				-- Cause a violation of a rule that processes a control flow graph.
			x := a1 + a2 + a3 + a4 + c1 + c2 + c3 + c4
		end           

	c1: INTEGER
	c2: INTEGER = 2
	c3: INTEGER external "C inline" alias "3" end
	c4: INTEGER deferred end

end
