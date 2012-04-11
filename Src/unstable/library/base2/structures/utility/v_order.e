note
	description: "[
		Internal < order of a COMPARABLE as a two-argument function.
		Void is taken to be the minimal value.
		]"
	author: "Nadia Polikarpova"

class
	V_ORDER [G -> COMPARABLE]

feature -- Basic operations

	less (x, y: G): BOOLEAN
			-- Is `x' < `y'?.
		do
			if x /= Void and y /= Void then
				Result := x < y
			else
				Result := x = Void and y /= Void
			end
		ensure
			definition_non_void: x /= Void and y /= Void implies Result = (x < y)
			definition_void: x = Void or y = Void implies Result = (x = Void and y /= Void)
		end

	less_equal (x, y: G): BOOLEAN
			-- Is `x' <= `y'?.
		do
			if x /= Void and y /= Void then
				Result := x <= y
			else
				Result := x = Void
			end
		ensure
			definition_non_void: x /= Void and y /= Void implies Result = (x <= y)
			definition_void: x = Void or y = Void implies Result = (x = Void)
		end

	greater (x, y: G): BOOLEAN
			-- Is `x' > `y'?.
		do
			if x /= Void and y /= Void then
				Result := x > y
			else
				Result := x /= Void and y = Void
			end
		ensure
			definition_non_void: x /= Void and y /= Void implies Result = (x > y)
			definition_void: x = Void or y = Void implies Result = (x /= Void and y = Void)
		end

	greater_equal (x, y: G): BOOLEAN
			-- Is `x' >= `y'?.
		do
			if x /= Void and y /= Void then
				Result := x >= y
			else
				Result := y = Void
			end
		ensure
			definition_non_void: x /= Void and y /= Void implies Result = (x >= y)
			definition_void: x = Void or y = Void implies Result = (y = Void)
		end
end
