note
	explicit: "all"

class F_OOO_OBSERVER_D

create
	make

feature

	make (s: F_OOO_SUBJECT_D)
		note
			status: creator
		require
			s.observer = Void
			s.is_wrapped -- default: public

			modify (s)
			modify (Current) -- default: creator
		do
			subject := s
			s.register (Current)
			check s.inv end
			cache := s.value

			set_subjects ([subject])
			wrap -- default: public/creator
		ensure
			subject = s
			is_wrapped -- default: public/creator
			s.is_wrapped -- default: public
		end

feature -- Access

	cache: INTEGER
			-- Cached value of subject.

	subject: F_OOO_SUBJECT_D
			-- Subject of this observer.

feature {F_OOO_SUBJECT_D} -- Element change

	notify
		require
			is_open
			inv_without ("cache_synchronized")

			modify_field ("cache", Current)
		do
			cache := subject.value
		ensure
			inv
		end

invariant
	attached subject
	subjects = [subject]
	subject.observer = Current
	cache_synchronized: cache = subject.value
	across subjects as sc all sc.item.observers.has (Current) end -- default
	owns = [] -- default
	observers = [] -- default

end
