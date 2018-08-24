note
	description: "Observer that needs to maintain a cache of its subject's state."
	explicit: "all"

class F_OOM_OBSERVER_D

create
	make

feature {NONE} -- Initialization

	make (s: F_OOM_SUBJECT_D)
			-- Create an observer subscribed to `s'.
		note
			status: creator
		require
			s_exists: s /= Void
			default_arg_wrapped: s.is_wrapped
			modify (s, Current)
		do
			subject := s
			s.register (Current)
			cache := s.value
			set_subjects ([subject])
			wrap
		ensure
			subject_set: subject = s
			observeing_subject: s.observers = old s.observers & Current
			default_wrapped: is_wrapped
			default_arg_wrapped: s.is_wrapped
		end

feature -- Public access

	subject: F_OOM_SUBJECT_D
			-- Subject.

	cache: INTEGER
			-- Copy of subject's state.

feature {F_OOM_SUBJECT_D} -- Internal communication

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
	default: owns = []
	default: observers = []
end
