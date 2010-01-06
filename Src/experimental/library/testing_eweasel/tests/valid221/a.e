class
	A [G]

feature

	f (other: G)
		local
			b: FUNCTION [ANY, TUPLE [G], BOOLEAN]
		do
			b := pt.negation (agent g)
		end

	g (other: G): BOOLEAN
		do
		end

	pt: B [G]
		do
			create Result
		end

end
