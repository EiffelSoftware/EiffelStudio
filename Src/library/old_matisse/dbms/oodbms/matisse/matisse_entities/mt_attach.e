class MT_ATTACH 


feature -- Action

	execute is
		-- Execute routine
	do
		body.execute
	end

feature -- State

	body: MT_ROUTINE -- routine

feature -- Change of state

	set_behavior (r: MT_ROUTINE) is
		-- Set routine with 'r'
	local
		c_name : ANY
		c_args : ARRAY[ANY]
	once
		body := r
		c_name := r.name.to_c
		c_args := r.arguments
		clip ($execute, $c_name, $c_args)
	end -- set_behaviour

	
feature {NONE} -- External routine

	clip (routine: POINTER; routine_name: POINTER; arguments: POINTER) is
		external 
			"C"
		end

end
