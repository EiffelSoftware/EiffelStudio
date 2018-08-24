note
	description: "Observer that needs to maintain a cache of its subject's state."

class F_OOM_OBSERVER

create
	make

feature {NONE} -- Initialization

	make (s: F_OOM_SUBJECT)
			-- Create an observer subscribed to `s'.
		note
			status: creator
		require
			s_exists: s /= Void
			modify (s, Current)
		do
			subject := s
			s.register (Current)
			cache := s.value
		ensure
			subject_set: subject = s
			observeing_subject: s.observers = old s.observers & Current
		end

feature -- Public access

	subject: F_OOM_SUBJECT
			-- Subject.

	cache: INTEGER
			-- Copy of subject's state.

feature {F_OOM_SUBJECT} -- Internal communication

	  notify
	  		-- Update `cache' according to the state `subject'.
		require
			open: is_open
			partially_holds: inv_without ("cache_synchronized")
			modify_field ("cache", Current)
		do
			cache := subject.value
		ensure
			invariant_holds: inv
		end

invariant
	subject_exists: subject /= Void
	subjects_structure: subjects = [subject]
	subject_aware: subject.observers.has (Current)
	cache_synchronized: cache = subject.value
end
