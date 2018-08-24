note
	description: "Subject that keeps a list of subscribers and nofifies then of its state changes."
	explicit: "all"

class F_OOM_SUBJECT_D

create
	make

feature {NONE} -- Initialization

	make (v: INTEGER)
			-- Create a subject with state `v' and no subscribers.
		note
			status: creator
		require
			modify (Current)
		do
			value := v
			create subscribers.make
			set_owns ([subscribers])
			wrap
		ensure
			value_set: value = v
			no_subscribers: subscribers.is_empty
			default_wrapped: is_wrapped
			default_observers_wrapped: across observers as o all o.item.is_wrapped end
		end

feature -- Public access

	value: INTEGER
			-- State.

	subscribers: F_OOM_LIST [F_OOM_OBSERVER_D]
			-- List of observers subscribed to the state updates.

feature -- State update

	update (v: INTEGER)
			-- Update state to `v'.
		require
			default_wrapped: is_wrapped
			default_observers_wrapped: across observers as o all o.item.is_wrapped end
			modify_field (["value", "closed"], Current)
			modify_field (["cache", "closed"], subscribers.sequence)
		local
			i: INTEGER
		do
			unwrap
			unwrap_all (observers)
			value := v

			from
				i := 1
			invariant
				across 1 |..| (i - 1) as j all subscribers.sequence [j.item].inv end
				modify_field (["cache"], subscribers.sequence)
			until
				i > subscribers.count
			loop
				subscribers [i].notify
				i := i + 1
			end

			wrap_all (observers)
			wrap
		ensure
			value_set: value = v
			default_wrapped: is_wrapped
			default_observers_wrapped: across observers as o all o.item.is_wrapped end
		end

feature {F_OOM_OBSERVER_D} -- Internal communication

	register (o: F_OOM_OBSERVER_D)
			-- Add `o' to `subscribers'.
		require
			wrapped: is_wrapped
			o_open: o.is_open
			modify ([Current])
		do
			unwrap
			subscribers.extend_back (o)
			set_observers (observers + [o])
			wrap
		ensure
			observers_extended: observers = old observers & o
			wrapped: is_wrapped
		end

invariant
	subscribers_exists: subscribers /= Void
	owns_structure: owns = [subscribers]
	all_subscribers_exist: across subscribers.sequence.domain as i all attached subscribers.sequence [i.item] end
	observers_structure: observers = subscribers.sequence.range
	subjects_structure: subjects = []

end
