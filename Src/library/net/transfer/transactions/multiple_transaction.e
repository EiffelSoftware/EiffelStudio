indexing
	description:
		"Transactions consisting of multiple transfers"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class MULTIPLE_TRANSACTION inherit

	TRANSACTION
		undefine
			copy, is_equal
		redefine
			error
		end

	TRANSACTION_CONTAINER [TRANSACTION]
		rename
			item as transaction
		undefine
			copy, is_equal, force, is_inserted
		end
	
	ARRAYED_LIST[TRANSACTION]
		rename
			make as list_make, go_i_th as select_transaction, 
			item as transaction
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Create transaction list.
		do
			list_make (1)
			stop_on_error
		end

feature -- Access

	source: DATA_RESOURCE is
			-- Current source
		do
			Result := transaction.source
		end
	
	target: DATA_RESOURCE is
			-- Current target
		do
			Result := transaction.target
		end
	
feature -- Status report

	is_correct: BOOLEAN is
			-- Is transaction set up correctly?
		do
			Result := check_query (transaction~is_correct)
		end
	 
	error: BOOLEAN is
			-- Has an error occurred in current transaction?
		do
			Result := check_query (transaction~error)
		end

	succeeded: BOOLEAN is
			-- Has the transaction succeeded?
		do
			Result := check_query (transaction~succeeded)
		end
	 
	insertable (t: TRANSACTION): BOOLEAN is
	 		-- Can transaction `t' be inserted in container?
		do
			Result := t.source.supports_multiple_transactions and then
				(not is_empty implies equal (transaction.source, t.source))
		end
	 
feature -- Status setting

	reset_error is
			-- Reset error flags.
		do
			execute_command (~reset_error_flags)
		end

feature -- Basic operations

	execute is
			-- Execute transaction.
		do
			start
			debug Io.error.put_string ("- OPEN SOURCE -%N") end
			source.open
			first_source := source
			if not transaction.error then
				execute_command (~do_transaction)
			end
			debug Io.error.put_string ("- CLOSE SOURCE -%N") end
			source.close
		end

feature {NONE} -- Implementation

	first_source: DATA_RESOURCE
			-- Handle to first source in collection
			
	reset_error_flags is
			-- Reset error flags for selected transaction.
		require
			not_empty: not is_empty
		do
			source.reset_error
			target.reset_error
		end

	do_transaction is
			-- Execute selected transaction.
		require
			not_empty: not is_empty
			first_source_set: first_source /= Void
		do
			if index > 1 then 
				transaction.source.reuse_connection (first_source)
			end
			debug Io.error.put_string ("- OPEN TARGET -%N") end
			target.open
			debug Io.error.put_string ("- INITIATE -%N") end
			if not transaction.error then
				source.initiate_transfer
				target.initiate_transfer
				if not transaction.error then
					debug Io.error.put_string ("- TRANSFER -%N") end
					target.put (source)
				end
			end
			debug Io.error.put_string ("- CLOSE TARGET -%N") end
			target.close
		end
		
end -- class MULTIPLE_TRANSACTION


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

