indexing
	description:
		"Managers that control the data transactions"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class TRANSFER_MANAGER inherit

	TRANSACTION_CONTAINER [TRANSACTION]
		rename
			item as transaction
		undefine
			copy, is_equal, force, is_inserted
		end

	ARRAYED_LIST [TRANSACTION]
		rename
			make as list_make, item as transaction, 
			go_i_th as select_transaction
		export
			{NONE} all
		end

	DATA_RESOURCE_ERROR_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end
		
create

	make

feature {NONE} -- Initialization

	make is
			-- Create manager.
		do
			list_make (1)
			stop_on_error
		end

feature -- Access

	source: DATA_RESOURCE is
			-- Selected source
		do
			Result := transaction.source
		end

	target: DATA_RESOURCE is
			-- Selected target
		do
			Result := transaction.target
		end

feature -- Measurement

	total_count: INTEGER is
			-- Total number of transactions
		local
			idx: INTEGER
			i: INTEGER
		do
			if count > 0 then
				idx := index
				from i := 1 until i = count + 1 loop
					select_transaction (i)
					Result := Result + transaction.count
					i := i + 1
				end
			end
			select_transaction (idx)
		ensure
			index_unchanged: index = old index
		end

	finished_transactions: INTEGER
			-- Number of already finished transactions
			
feature -- Status report

	error: BOOLEAN is
			-- Has an error occurred in any transaction?
		require
			not_empty: not is_empty
		do
			Result := check_query (transaction~error)
		end
		
	error_reason: STRING is
			-- Reason of most recent error
		require
			error_exists: error
		local
			idx: INTEGER
			error_found: BOOLEAN
		do
			idx := index
			from start until error_found or after loop
				if source.error then
					Result := error_text (source.error_code)
					error_found := True
				elseif target.error then
					Result := error_text (target.error_code)
					error_found := True
				end
				forth
			end
			select_transaction (idx)
		ensure
			non_empty_string: Result /= Void and then not Result.is_empty
			index_unchanged: index = old index
		end

	transactions_succeeded: BOOLEAN is
			-- Have all transactions succeeded?
		require
			not_empty: not is_empty
		do
			if transfer_finished then
				Result := check_query (transaction~succeeded)
			end
		end
		
	transfer_finished: BOOLEAN
			-- Has a transfer taken place?
	
	insertable (t: TRANSACTION): BOOLEAN is
			-- Can transaction `t' be added?
		do
			Result := True
		end
	 
feature -- Status setting

	reset_status is
			-- Reset status flags.
		do
			transfer_finished := False
			execute_command (~reset_error)
		ensure
			finished_flag_reset: not transfer_finished
			no_error: not error
		end

feature -- Removal

	remove_transaction (n: INTEGER) is
			-- Remove `n'-th transaction.
		require
			not_empty: not is_empty
			index_in_range: 1 <= n and n <= count
		local
			idx: INTEGER
		do
			idx := index
			select_transaction (n)
			remove
			if idx > count then idx := count end
			select_transaction (idx)
		ensure
			one_less_item: count = count - 1
			index_unchanged: (old index < old count) implies (index = old index)
			index_adapted: (old index = old count) implies 
					(index = old index - 1)
		end
			
feature -- Basic operations

	transfer is
			-- Transfer file.
		require
			not_empty: not is_empty
			flags_reset: not (transfer_finished and transactions_succeeded)
		do
			transfer_finished := True
			execute_command (~execute_transaction)
		ensure
			transfer_flag_set: transfer_finished
		end

	execute_transaction is
			-- Execute selected transaction.
		do
			transaction.execute
			if not transaction.error then
				finished_transactions := 
					finished_transactions + transaction.count
			end
		ensure
			counter_updated: not transaction.error implies
				finished_transactions = old finished_transactions + 
					transaction.count
		end

feature {NONE} -- Implementation

	reset_error is
			-- Reset error flags.
		do
			transaction.reset_error
		end

invariant

	finished_transaction_range: 0 <= finished_transactions and
			finished_transactions <= total_count

end -- class TRANSFER_MANAGER

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1086-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


