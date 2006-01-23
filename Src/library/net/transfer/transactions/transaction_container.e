indexing
	description:
		"Container for transactions"
	legal: "See notice at end of class."

	status: "See notice at end of class."
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
			not_empty: not is_empty
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
			e := is_empty
			extend (t)
			if e then select_transaction (1) end
		ensure
			one_more_item: count = old count + 1
			index_unchanged: not old is_empty implies index = old index
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
				Result := Result and q.item (Void)
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
				cmd.call (Void)
				i := i + 1
			end
			select_transaction (idx)
		ensure
			index_unchanged: index = old index
		end
	 
invariant

	empty_definition: is_empty = (count = 0)
	index_in_range: not is_empty implies (1 <= index and index <= count)

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




end -- class TRANSACTION_CONTAINER

