note
	description: "Observer that maintains the sign of its subject's value."

class
	F_OI_SIGN_OBSERVER

inherit
	F_OI_OBSERVER

create
	make

feature -- Access

	sign: INTEGER
			-- Signum of subject's `value'.

	is_synchronized (value: INTEGER): BOOLEAN
			-- Is this observer synchronized with the state `value'?
		note
			status: functional
		do
			Result := sign * value >= 0
		end

feature {F_OI_SUBJECT} -- Internal communication

	  notify
	  		-- Update `sign' according to the state `subject'.
		do
			sign := if subject.value >= 0 then 1 else -1 end
		end

end
