class
	A [G]

feature

	f (other: G)
		local
			q: FUNCTION [ANY, TUPLE [G], BOOLEAN]
		do
			q := b.negation (agent g)
			q := c.negation (agent g)
		end

	g (other: G): BOOLEAN
		do
		end

	b: B [G]
		do
			create Result
		end

	c: C [G]
		do
			create Result
		end

end
