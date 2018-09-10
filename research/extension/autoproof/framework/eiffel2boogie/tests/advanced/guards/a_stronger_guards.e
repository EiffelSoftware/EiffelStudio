note
	false_guards: true
	explicit: owns, subjects, observers

class
	A_STRONGER_GUARDS

inherit
	A_GUARDS
		redefine
			y, z
		end

feature
	y: INTEGER
			-- Same guard.

	z: INTEGER
			-- Stronger guard.
			-- Now asignment to `z' fails in test.
		note
			guard: not_too_large
		attribute
		end

	not_too_large (new_val: INTEGER; o: ANY): BOOLEAN
		note
			status: functional
		do
			Result := new_val < 100
		end
end
