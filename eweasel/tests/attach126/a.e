class A

create
	default_create,
	make

feature {NONE} -- Creation

	make (value: TEST)
			-- Raise an exception after registering `value` in a once function.
		do
			check not attached f (value) then end
		end

feature -- Access

	f (value: TEST): TEST
			-- A once function returning an incompletely initialized object
			-- if `value` was incompletely initialized at the first call.
		once
			Result := value
		end

end
