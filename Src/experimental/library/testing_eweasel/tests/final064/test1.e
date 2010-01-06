deferred class
	TEST1

feature

	f
		local
			v: INTEGER
		do
			g
			v := bad.item ([5.3])
		end

feature {NONE} -- Implementation

	bad: FUNCTION [ANY, TUPLE [REAL_64], INTEGER]
			-- Agent used to compute the hash-code


	g 
		deferred
		end

end
