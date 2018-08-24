note
	explicit: "all"

class F_OOO_SUBJECT_D

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
			wrap -- default: creator
		ensure then
			is_wrapped -- default: creator
			observer = Void -- default: default_create
		end

feature -- Access

	value: INTEGER
		-- Subject's value.

	observer: detachable F_OOO_OBSERVER_D
		-- Observer of this subject.

feature -- Element change

	update (new_val: INTEGER)
		require
			is_wrapped	-- default: public
			across observers as oc all oc.item.is_wrapped end -- default: public

			modify_field (["cache", "closed"], observer)
			modify_field (["value", "closed"], Current)
		do
			unwrap -- default: public
			if attached observer then
				observer.unwrap
			end
			value := new_val
			if attached observer then
				observer.notify
				observer.wrap
			end
			wrap -- default: public
		ensure
			value_set: value = new_val
			is_wrapped	-- default: public
			across observers as oc all oc.item.is_wrapped end -- default: public
		end

feature {F_OOO_OBSERVER_D} -- Element change

	register (o: F_OOO_OBSERVER_D)
			-- Register `o' as observer.
		note
			explicit: contracts
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
	owns = [] -- default
	subjects = [] -- default

end
