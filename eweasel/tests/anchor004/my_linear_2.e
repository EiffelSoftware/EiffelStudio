deferred class
	MY_LINEAR_2 [G]

inherit
	MY_LINEAR [G]

feature -- Access

	infix "+" (a_other: LINEAR [G]): like Current is
		do
		end

	reversed: like Current is
		do
		end

	comparison: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]

	set_comparison (a_comparison : like comparison) is
		do
		end

	less_than (a, b: G): BOOLEAN is
		do
		end

end
