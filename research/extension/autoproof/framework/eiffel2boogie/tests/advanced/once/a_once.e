note
	description: "Testing (parameter-less) once functions meant for creating singletons."
	explicit: "all"

class
	A_ONCE

feature

	singleton: A_ONCE
			-- Mentioning arguments or freshness in the postcondition will create unsoundness!
		once
			create Result
		ensure
			Result /= Void
		end

	test
		local
			a, b: A_ONCE
		do
			a := singleton
			b := singleton
			check a = b end
			check a = singleton end
			check singleton = singleton end
			check singleton = a.singleton end
			check attached {A_ONCE} singleton end
		end

invariant
	subjects.is_empty
end
