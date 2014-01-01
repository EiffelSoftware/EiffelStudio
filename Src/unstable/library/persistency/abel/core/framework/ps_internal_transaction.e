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
			create identifier_table.make
			create primary_key_table.make
			create root_flags.make (1)

			is_active := True
			repository := a_repository
			root_declaration_strategy := a_strategy
			transaction_identifier := id
		ensure
			read_write: not is_readonly
			active: is_active
			repository_correct: repository = a_repository
			strategy_correct: root_declaration_strategy = a_strategy
			id_correct: transaction_identifier = id
		end

	make_readonly (a_repository: PS_REPOSITORY; id: INTEGER)
			-- Initialize `Current', mark transaction as readonly.
		do
			make (a_repository, create {PS_ROOT_OBJECT_STRATEGY}.make_preserve, id)
			is_readonly := True
		ensure
			readonly: is_readonly
			active: is_active
			repository_correct: repository = a_repository
			id_correct: transaction_identifier = id
		end

feature {PS_ABEL_EXPORT} -- Access

	repository: PS_REPOSITORY
			-- The repository this `Current' is bound to.

	root_declaration_strategy: PS_ROOT_OBJECT_STRATEGY
			-- The root object strategy for the current transaction.

	error: detachable PS_ERROR
			-- Error description of the last error.

	transaction_identifier: INTEGER
			-- A unique transaction identifier.

	hash_code: INTEGER
			-- Hash code value.
		do
			Result := transaction_identifier
		end

feature {PS_ABEL_EXPORT} -- Access: Transaction context

	root_flags: HASH_TABLE [BOOLEAN, NATURAL_64]
			-- Mapping for ABEL identifier -> root status of every object.

	identifier_table: PS_IDENTIFIER_TABLE
			-- An object -> identifier lookup table.

	primary_key_table: PS_PRIMARY_KEY_TABLE
			-- An identifier -> primary key lookup table.

feature {PS_ABEL_EXPORT} -- Status report

	is_active: BOOLEAN
			-- Is the current transaction still active, or has it been commited or rolled back at some point?

	has_error: BOOLEAN
			-- Has there been an error in any of the operations or the final commit?
		do
			Result := attached error
		end

	is_readonly: BOOLEAN
			-- Is this a readonly transaction?

	is_retry_allowed: BOOLEAN
			-- Should there be a retry?
			-- Default yes, except for contract violations or other errors
			-- which happen only during development.
		require
			has_error: attached error
		do
			check from_precondition: attached error as l_error then
				Result := not attached {ASSERTION_VIOLATION} l_error.backend_error
					and not attached {LANGUAGE_EXCEPTION} l_error.backend_error
					and not attached {OLD_VIOLATION} l_error.backend_error
			end
		end


feature {PS_ABEL_EXPORT} -- Element change

	set_root_declaration_strategy (a_strategy: like root_declaration_strategy)
			-- Set `root_declaration_strategy' to `a_strategy'.
		do
			root_declaration_strategy := a_strategy
		end

	set_error (an_error: detachable PS_ERROR)
			-- Set the error field if an error occurred.
		do
			error := an_error
		ensure
			error_set: error = an_error
		end

	set_default_error
			-- Set the error field with a default PS_INTERNAL_ERROR.
		require
			no_error: not attached error
		local
			internal_error: PS_INTERNAL_ERROR
		do
			create internal_error
			internal_error.set_backend_error (internal_error.exception_manager.last_exception)
			set_error (internal_error)
		ensure
			has_error: attached error
		end

	close
			-- Set `is_active' to False.
		do
			is_active := False
		end

end
