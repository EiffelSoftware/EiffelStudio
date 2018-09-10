note
	description : "Test harness."
	explicit: "all"

class F_OOM_CLIENT

feature -- Test

	test
			-- Use subjects and observers.
		local
			s: F_OOM_SUBJECT
			o1, o2: F_OOM_OBSERVER
		do
			create s.make (1)
			create o1.make (s)
			create o2.make (s)

			s.update (5)

			check o1_synch: o1.cache = 5 end
			check o2_synch: o2.cache = 5 end
		end

	test_d
			-- Use subjects and observers.
		local
			s: F_OOM_SUBJECT_D
			o1, o2: F_OOM_OBSERVER_D
		do
			create s.make (1)
			create o1.make (s)
			create o2.make (s)

			s.update (5)

			check o1_synch: o1.cache = 5 end
			check o2_synch: o2.cache = 5 end
		end

invariant
	default_owns: owns.is_empty
	default_subjects: subjects.is_empty
	default_observers: observers.is_empty

end
