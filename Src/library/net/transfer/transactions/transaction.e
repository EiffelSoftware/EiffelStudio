indexing
	description:
		"Data transactions"

	status:	"See note at end of class"
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
	 
end -- class TRANSACTION


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
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

