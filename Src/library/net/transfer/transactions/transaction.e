indexing
	description:
		"Data transactions"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	TRANSACTION

feature -- Access

	source: DATA_RESOURCE is
			-- Current source
		deferred
		end
	
	target: DATA_RESOURCE is
			-- Current target
		deferred
		end
	
feature -- Measurement

	count: INTEGER is
			-- Number of transactions
		deferred
		end
	 
feature -- Status report

	is_correct: BOOLEAN is
			-- Is transaction set up correctly?
		deferred
		end
	 
	error: BOOLEAN is
			-- Has an error occurred in current transaction?
		do
			Result := source.error or target.error
		end

	succeeded: BOOLEAN is
			-- Has the transaction succeeded?
		deferred
		end
	 
feature -- Status setting

	reset_error is
			-- Reset error flag.
		deferred
		end
	 
feature -- Basic operations

	execute is
			-- Execute transaction.
		require
			correct_transaction: is_correct
		deferred
		end
	 
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TRANSACTION

