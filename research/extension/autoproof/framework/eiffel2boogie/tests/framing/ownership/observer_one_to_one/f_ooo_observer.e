class F_OOO_OBSERVER

create
	make

feature {NONE} -- Initialization

	make (s: F_OOO_SUBJECT)
		note
			status: creator
		require
			s.observer = Void
			modify (Current)
			modify_field (["observer", "observers", "closed"], s)
		do
			subject := s
			s.register (Current)
			check s.inv end
			cache := s.value
		ensure
			subject = s
		end

feature -- Access

	cache: INTEGER
			-- Cached value of subject.

	subject: F_OOO_SUBJECT
			-- Subject of this observer.

feature {F_OOO_SUBJECT} -- Element change

	notify
		require
			open: is_open
			almost_holds: inv_without ("cache_synchronized")

			modify_field ("cache", Current)
		do
			cache := subject.value
		ensure
			invariant_holds: inv
		end

invariant
	subject_exists: attached subject
	subjects_structure: subjects = [subject]
	subject_aware: subject.observer = Current
	cache_synchronized: cache = subject.value

end
