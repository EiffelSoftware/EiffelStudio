indexing
	description:
		"Container for transactions"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class TRANSACTION_CONTAINER [G -> TRANSACTION] inherit

	SEQUENCE[G]
		undefine
			has, index_of, occurrences, off, put, prune, prune_all, readable
		end

feature -- Access

	transaction: G is
			-- Current transaction
		deferred
		end
	 
	index: INTEGER is
			-- Current index
		deferred
		end
	
feature -- Measurement

	count: INTEGER is
			-- Number of transactions
		deferred
		end

feature -- Status report

	insertable (t: G): BOOLEAN is
	 		-- Can transaction `t' be inserted in container?
		require
			transaction_exists: t /= Void
		deferred
		end
	 
	 error_stops: BOOLEAN
	 		-- Is transfer stopped on error?
			
feature -- Status setting

	select_transaction (n: INTEGER) is
			-- Select `n'-th transaction.
		require
			not_empty: not empty
			index_in_range: 1 <= n and n <= count
		deferred
		ensure
			selected: index = n
		end

	stop_on_error is
			-- Error stops action.
		do
			error_stops := True
		ensure
			stop: error_stops
		end

	continue_on_error is
			-- Error does not stop action.
		do
			error_stops := False
		ensure
			does_not_stop: not error_stops
		end

feature -- Element change

	add_transaction (t: G) is
			-- Add transaction.
		require
			transaction_exists: t /= Void
			transaction_correct: t.is_correct
		local
			e: BOOLEAN
		do
			e := empty
			extend (t)
			if e then select_transaction (1) end
		ensure
			one_more_item: count = old count + 1
			index_unchanged: not old empty implies index = old index
		end

feature {NONE} -- Implementation

	check_query (q: FUNCTION[TRANSACTION, TUPLE, BOOLEAN]): BOOLEAN is
			-- Is query `q' true for all transactions?
		require
			query_exists: q /= Void
		local
			idx: INTEGER
			i: INTEGER
		do
			idx := index
			from
				i := 1
				Result := True
			until
				not Result or i = count + 1
			loop
				select_transaction (i)
				q.call ([])
				Result := Result and q.last_result
				i := i + 1
			end
			select_transaction (idx)
		ensure
			index_unchanged: index = old index
		end
	 
	execute_command (cmd: PROCEDURE[TRANSACTION_CONTAINER[G], TUPLE]) is
			-- Execute command `cmd' for all transactions.
		require
			command_exists: cmd /= Void
		local
			idx: INTEGER
			i: INTEGER
		do
			idx := index
			from
				i := 1
				select_transaction (1)
			until
				i = count + 1 or (error_stops and transaction.error)
			loop
				select_transaction (i)
				cmd.call ([])
				i := i + 1
			end
			select_transaction (idx)
		ensure
			index_unchanged: index = old index
		end
	 
invariant

	empty_definition: empty = (count = 0)
	index_in_range: not empty implies (1 <= index and index <= count)

end -- class TRANSACTION_CONTAINER

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
