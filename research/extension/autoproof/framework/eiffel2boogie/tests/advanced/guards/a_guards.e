note
	false_guards: true
	explicit: owns, subjects, observers

class
	A_GUARDS

inherit
	ANY
		redefine
			owns
		end

feature

	x: INTEGER
			-- Default guard (false)

	y: INTEGER
		note
			guard: greater
		attribute
		end

	z: INTEGER
		note
			guard: greater
		attribute
		end

	greater (new_val: INTEGER; o: ANY): BOOLEAN
		note
			status: functional
		do
			Result := new_val > y
		end

	owns: MML_SET [ANY] assign set_owns
		note
			status: ghost
			guard: false -- Redefined from true to false
		attribute
		end

	test
		do
			y := y + 1 									-- OK: conforms to guard
			z := y + 1									-- OK: conforms to guard
			Current.subjects := subjects & Current 		-- OK: guard true defined in ANY
			Current.observers := observers & Current 	-- OK: adding observers is allowed according to guard defined in ANY
			x := x + 1 									-- Bad: default guard false
		end

	test1
		do
			set_owns (owns & (create {ANY}))			-- Bad: redefined to false
		end

	test2
		note
			status: nonvariant
			explicit: contracts, wrapping
		require
			is_open
		do
			y := y + 1									-- Bad: nonvariant, so precise guard is not known
		end

end
