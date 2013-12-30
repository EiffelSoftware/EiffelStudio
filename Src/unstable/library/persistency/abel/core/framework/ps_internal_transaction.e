note
	description: "Class to group different database operations into a single unit. Also responsible to propagate errors."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_INTERNAL_TRANSACTION

inherit
	PS_ABEL_EXPORT

	HASHABLE

create {PS_ABEL_EXPORT}
	make, make_readonly

feature {NONE} -- Initialization

	make (a_repository: PS_REPOSITORY; a_strategy: PS_ROOT_OBJECT_STRATEGY; id: INTEGER)
			-- Initialize `Current'.
		do
			repository := a_repository
			create root_flags.make (1)
			create identifier_set.make
			is_readonly := False
			is_active := True
			root_declaration_strategy := a_strategy
			transaction_identifier := id
			create identifier_table

			repository.id_manager.register_transaction (Current)
		end

	make_readonly (a_repository: PS_REPOSITORY; id: INTEGER)
			-- Initialize `Current', mark transaction as readonly.
		do
			repository := a_repository
			create root_flags.make (1)
			create identifier_set.make
			is_readonly := True
			is_active := True
			create root_declaration_strategy.make_preserve
			transaction_identifier := id
			create identifier_table

			repository.id_manager.register_transaction (Current)
		end

feature {PS_ABEL_EXPORT} -- Access

	transaction_identifier: INTEGER
			-- A unique transaction identifier.

	error: detachable PS_ERROR
			-- Error description of the last error.

	repository: PS_REPOSITORY
			-- The repository this `Current' is bound to.

	root_flags: HASH_TABLE [BOOLEAN, NATURAL_64]
			-- Mapping for ABEL identifier -> root status of every object.

	identifier_set: PS_IDENTIFIER_SET


	identifier_table: PS_IDENTIFIER_TABLE

	root_declaration_strategy: PS_ROOT_OBJECT_STRATEGY
			-- The root object strategy for the current transaction.

	hash_code: INTEGER
			-- Hash code value
		do
			Result := transaction_identifier
		end


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
			Result := attached error
		end

	is_readonly: BOOLEAN
			-- Is this a readonly transaction?

feature {PS_ABEL_EXPORT} -- Element change

	set_root_declaration_strategy (a_strategy: like root_declaration_strategy)
			-- Set `root_declaration_strategy' to `a_strategy'.
		do
			root_declaration_strategy := a_strategy
		end

feature {PS_ABEL_EXPORT} -- Internals

	set_error (an_error: detachable PS_ERROR)
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
