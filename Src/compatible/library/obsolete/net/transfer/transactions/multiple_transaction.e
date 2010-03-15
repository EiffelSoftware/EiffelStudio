note
	description:
		"Transactions consisting of multiple transfers"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	 MULTIPLE_TRANSACTION

inherit
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
			copy, is_equal, force, is_inserted, search, append, fill,
			do_all, do_if, there_exists, for_all
		end

	ARRAYED_LIST[TRANSACTION]
		rename
			make as list_make, go_i_th as select_transaction,
			item as transaction
		export
			{ANY} valid_index, valid_cursor_index
			{MULTIPLE_TRANSACTION} cursor, go_to, area, subcopy, i_th, upper,
				valid_cursor, subarray, lower
			{NONE} all
		end

create
	make

create {MULTIPLE_TRANSACTION}
	make_filled

feature {NONE} -- Initialization

	make
			-- Create transaction list.
		do
			list_make (1)
			stop_on_error
		end

feature -- Access

	source: DATA_RESOURCE
			-- Current source
		do
			Result := transaction.source
		end

	target: DATA_RESOURCE
			-- Current target
		do
			Result := transaction.target
		end

feature -- Status report

	is_correct: BOOLEAN
			-- Is transaction set up correctly?
		do
			Result := check_query (agent transaction.is_correct)
		end

	error: BOOLEAN
			-- Has an error occurred in current transaction?
		do
			Result := check_query (agent transaction.error)
		end

	succeeded: BOOLEAN
			-- Has the transaction succeeded?
		do
			Result := check_query (agent transaction.succeeded)
		end

	insertable (t: TRANSACTION): BOOLEAN
	 		-- Can transaction `t' be inserted in container?
		do
			Result := t.source.supports_multiple_transactions and then
				(not is_empty implies equal (transaction.source, t.source))
		end

feature -- Status setting

	reset_error
			-- Reset error flags.
		do
			execute_command (agent reset_error_flags)
		end

feature -- Basic operations

	execute
			-- Execute transaction.
		do
			start
			debug Io.error.put_string ("- OPEN SOURCE -%N") end
			source.open
			first_source := source
			if not transaction.error then
				execute_command (agent do_transaction)
			end
			debug Io.error.put_string ("- CLOSE SOURCE -%N") end
			source.close
		end

feature {NONE} -- Implementation

	first_source: DATA_RESOURCE
			-- Handle to first source in collection

	reset_error_flags
			-- Reset error flags for selected transaction.
		require
			not_empty: not is_empty
		do
			source.reset_error
			target.reset_error
		end

	do_transaction
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




end -- class MULTIPLE_TRANSACTION

