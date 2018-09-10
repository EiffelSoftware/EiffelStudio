class F_OOO_SUBJECT

inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		note
			status: creator
		do
		ensure then
			observer = Void -- default: default_create
		end

feature -- Access

	value: INTEGER
		-- Subject's value.

	observer: detachable F_OOO_OBSERVER
		-- Observer of this subject.

feature -- Element change

	update (new_val: INTEGER)
		require
			observer_wrapped: observer /= Void implies observer.is_wrapped
			modify_field (["cache", "closed"], observer)
			modify_field (["value", "closed"], Current)
		do
			if attached observer then
				observer.unwrap
			end
			value := new_val
			if attached observer then
				observer.notify
				observer.wrap
			end
		ensure
			value_set: value = new_val
			observer_wrapped: observer /= Void implies observer.is_wrapped
		end

feature {F_OOO_OBSERVER} -- Element change

	register (o: F_OOO_OBSERVER)
			-- Register `o' as observer.
		require
			observer = Void
			is_wrapped
			o.is_open

			modify_field (["observer", "observers", "closed"], Current)
		do
			unwrap
			observer := o
			set_observers ([o])
			wrap
		ensure
			observer = o
			is_wrapped
		end

invariant
	observer = Void implies observers = []
	observer /= Void implies observers = [observer]
	observer /= Current

end
