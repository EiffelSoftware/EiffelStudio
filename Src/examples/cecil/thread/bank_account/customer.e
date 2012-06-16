note
	description: "Abstract representation of a customer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CUSTOMER

inherit
	THREAD
		rename
			make as thread_make
		end
	

feature	{NONE} -- Initialization
	
	make (ptr: POINTER; m: MUTEX; p: BOOLEAN_REF)
		do
			thread_make
			mutex := m
			c_account := ptr
			finished := p
			launch
		end

feature -- Execution
	
	execute
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

	make_transaction (n: INTEGER)
			deferred
		end

feature	{NONE} -- Synchronization
			
	mutex: MUTEX

feature {NONE} -- Access
	
	stop: BOOLEAN

	finished: BOOLEAN_REF

	c_account: POINTER
	
feature {NONE}	-- Status
	
	continue: BOOLEAN
		do
			Result := finished.item = False
		end

feature	{NONE} -- Externals

	c_make_transaction (m: INTEGER; ptr, tid: POINTER)
		external
			"C"
		end

feature {NONE} -- Implementation

	random: RANDOM
			-- Initialize a random number
			-- No synchronization needed as created when holding `mutex'.
		once ("PROCESS")
			create Result.make
			Result.start
		ensure
			not_void: Result /= Void
		end

	next_amount (range: INTEGER): INTEGER
			-- Random number between 1 and `range'
			-- | Side effect function.
		do
				-- No synchronization needed on `random' as computed while holding `mutex'.
			random.forth
			if range <= 0 then
				Result := 0
			else
				Result := random.item \\ range + 1
			end
		ensure
			valid_result_inf: Result > 0
		end			

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CUSTOMER

