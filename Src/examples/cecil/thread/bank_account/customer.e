indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CUSTOMER

inherit
	THREAD
	

feature	-- Initialization
	
	make (ptr: POINTER; m: MUTEX; p: PROXY [BOOLEAN_REF]) is
		do
			mutex := m
			c_account := ptr
			finished := p
			launch
		end

feature -- Execution
	
	execute is
		do
			from 
			until
				stop	
			loop
				mutex.lock
				if continue then
					make_transaction (next_amount (1000))
				else
					stop := True
				end
				mutex.unlock
			end
		end

feature -- Deferred

	make_transaction (n: INTEGER) is
			deferred
		end

feature	{NONE} -- Synchronization
			
	mutex: MUTEX

feature {NONE} -- Access
	
	stop: BOOLEAN

	finished: PROXY [BOOLEAN_REF]

	c_account: POINTER
	
feature {NONE}	-- Status
	
	continue: BOOLEAN is
		do
			Result := finished.item.item = False
		end
feature	{NONE} -- Externals


	c_make_transaction (m: INTEGER; ptr: POINTER) is
		external
			"C"
		end

feature {NONE} -- Implementation

	random: RANDOM is
			-- Initialize a random number
		once
			create Result.make
			random.start
		ensure
			not_void: Result /= Void
		end


	next_amount (range: INTEGER): INTEGER is
			-- Random number between 1 and `range'
			-- | Side effect function.
		do
			random.forth
			if range <= 0 then
				Result := 0
			else
				Result := random.item \\ range + 1
			end
		ensure
			valid_result_inf: Result > 0
		end			

end -- class CUSTOMER

--|----------------------------------------------------------------
--| CECIL: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

