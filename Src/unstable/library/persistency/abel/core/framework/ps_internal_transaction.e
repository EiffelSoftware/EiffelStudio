note
	description: "Class to group different database operations into a single unit. Also responsible to propagate errors."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_INTERNAL_TRANSACTION

inherit

	PS_ABEL_EXPORT

create
	make

create {PS_ABEL_EXPORT}
	make_readonly

feature {NONE} -- Initialization

	make (a_repository: PS_REPOSITORY)
			-- Initialize `Current'.
		do
			repository := a_repository
			create {PS_NO_ERROR} error
			create root_flags.make (100)
			is_readonly := False
			is_active := True
		end

	make_readonly (a_repository: PS_REPOSITORY)
			-- Initialize `Current', mark transaction as readonly.
		do
			repository := a_repository
			create {PS_NO_ERROR} error
			create root_flags.make (100)
			is_readonly := True
			is_active := True
		end

feature {PS_ABEL_EXPORT} -- Access

	error: PS_ERROR
			-- Error description of the last error.

	repository: PS_REPOSITORY
			-- The repository this `Current' is bound to.

	root_flags: HASH_TABLE[BOOLEAN, INTEGER]
			-- Mapping for ABEL identifier -> root status of every object.

feature {PS_ABEL_EXPORT} -- Status report

	is_active: BOOLEAN
			-- Is the current transaction still active, or has it been commited or rolled back at some point?

	is_successful_commit: BOOLEAN
			-- Was the last commit operation successful?
		require
			not_active: not is_active
		attribute
		end

	has_error: BOOLEAN
			-- Has there been an error in any of the operations or the final commit?
		do
			Result := not attached {PS_NO_ERROR} error
		end

	is_readonly: BOOLEAN
			-- Is this a readonly transaction?

feature {PS_ABEL_EXPORT} -- Basic operations

	commit
			-- Try to commit the transaction.
			--The result of the commit operation is set in the `is_successful_commit' attribute.
		do
			if is_active then
				repository.commit_transaction (Current)
			end
		ensure
			transaction_terminted: not is_active
		rescue
				-- Catch any exception if the commit failed
			check
				ensure_correct_rollback: not is_active and not is_successful_commit
			end
			retry -- Do nothing, but terminate normally.
		end

	rollback
			-- Rollback all operations within this transaction.
		require
			transaction_alive: is_active
		do
			repository.rollback_transaction (Current, True)
		ensure
			transaction_terminated: not is_active
			no_success: not is_successful_commit
		end

feature {PS_ABEL_EXPORT} -- Internals

	set_error (an_error: PS_ERROR)
			-- Set the error field if an error occurred.
		do
			error := an_error
		ensure
			error_set: error = an_error
		end

	declare_as_aborted
			-- Declare `Current' as aborted.
		do
			is_active := False
			is_successful_commit := False
		end

	declare_as_successful
			-- Declare `Current' as successfully committed.
		do
			is_active := False
			is_successful_commit := True
		end

invariant
	error_implies_no_success: not is_active and has_error implies not is_successful_commit

end
