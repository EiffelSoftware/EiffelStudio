note
	description: "Observer that maintains some derivative of its subject's state."

deferred class F_OI_OBSERVER

feature {NONE} -- Initialization

	make (s: F_OI_SUBJECT)
			-- Create an observer subscribed to `s'.
		note
			status: creator
		require
			s_exists: s /= Void
			modify (s, Current)
		do
			subject := s
			s.register (Current)
			set_subjects ([s])
			notify
		ensure
			subject_set: subject = s
			observeing_subject: s.observers = old s.observers & Current
		end

feature -- Public access

	subject: F_OI_SUBJECT
			-- Subject.

	is_synchronized (value: INTEGER): BOOLEAN
			-- Is this observer synchronized with the state `value'?
		note
			explicit: contracts
		require
			reads (Current)
		deferred
		end

feature {F_OI_SUBJECT} -- Internal communication

	  notify
	  		-- Update `cache' according to the state `subject'.
		require
			open: is_open
			partially_holds: inv_without ("synchronized")
		deferred
		ensure
			open: is_open
			same_subject: subject = old subject
			same_owns: owns = old owns
			invariant_holds: inv
		end

invariant
	subject_exists: subject /= Void
	subjects_structure: subjects = [subject]
	subject_aware: subject.observers.has (Current)
	synchronized: is_synchronized (subject.value)
	observers_structure: observers.is_empty
	owns_empty: owns = []
end
