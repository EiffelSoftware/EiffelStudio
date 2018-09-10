note
	description: "Observer that maintains the parity of its subject's value."

class
	F_OI_PARITY_OBSERVER

inherit
	F_OI_OBSERVER

create
	make

feature -- Access

	is_odd: BOOLEAN
			-- Is subject's `value' odd?

	is_synchronized (value: INTEGER): BOOLEAN
			-- Is this observer synchronized with the state `value'?
		note
			status: functional
		do
			Result := is_odd = (value \\ 2 = 1)
		end

feature {F_OI_SUBJECT} -- Internal communication

	  notify
	  		-- Update `is_odd' according to the state `subject'.
		do
			is_odd := subject.value \\ 2 = 1
		end

end
