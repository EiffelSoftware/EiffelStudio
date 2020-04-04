note
	description: "Utility class that handles preparation work for a basic database test"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_BASIC_DATABASE

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

	TESTING_HELPER
		undefine
			default_create
		end

	RDB_HANDLE
		undefine
			default_create
		end

	TEST_DATABASE_MANAGER
		undefine
			default_create
		end

	DCM_MA_DECIMAL_PARSER
		rename
			make as make_parser,
			error as error_parser,
			parse as parse_parser
		undefine
			default_create
		end

	GLOBAL_SETTINGS
		undefine
			default_create
		end

feature {NONE} -- Prepare

	on_prepare
			-- On prepare
		do
			create base_stores.make (5)
			create repositories.make (5)
			if is_odbc then
				if is_trusted then
					set_connection_string_information ("Driver={SQL Server Native Client 10.0};Server=" + host + ";Database=" + database_name + ";Trusted_Connection=Yes;")
				else
					set_connection_string_information ("Driver={SQL Server Native Client 10.0};Server=" + host + ";Database=" + database_name + ";Uid=" + user_login + ";Pwd=" + user_password)
				end
			else
				set_connection_information (user_login, user_password, database_name)
			end
			if attached Manager.current_session.session_login as l_login then
				l_login.set_application (database_name)	-- For MySQL
			end
				-- Default to non extended type, change in descendants if needed.
			(create {GLOBAL_SETTINGS}).set_use_extended_types (False)
		end

	reset_database
			-- Reset connection and errors if possible
		local
			l_session_control: DB_CONTROL
		do
			if is_database_set then
					-- To handle unset connection and errors in previous failing test,
					-- since the tests are possibly run in the same thread.
				create l_session_control.make
				if l_session_control.is_connected then
					l_session_control.disconnect
				end
				db_change.reset
			end
		end

feature {NONE} -- Implementation

	base_stores: HASH_TABLE [DB_STORE, STRING]
			-- Stores
			-- [store, table_name]

	repositories: HASH_TABLE [DB_REPOSITORY, STRING]
			-- Repositories
			-- [repository, table_name]

	data_objects: HASH_TABLE [ANY, STRING]
			-- Data objects
			-- [object, table_name]
		deferred
		end

feature {NONE}

	prepare_repository (a_table_name: STRING)
			-- Prepare repository
		local
			l_repository: DB_REPOSITORY
			l_db_store: DB_STORE
		do
				-- Drop the table first
			drop_repository (a_table_name)

				-- Create the table for data object relavant to the table name
			if attached data_objects.item (a_table_name) as l_data then
				create l_repository.make (a_table_name)
				l_repository.allocate (l_data)
				l_repository.load
				repositories.force (l_repository, a_table_name)

				create l_db_store.make
				l_db_store.set_repository (l_repository)
				base_stores.force (l_db_store, a_table_name)
			else
				assert ("No object found for table " + a_table_name, False)
			end
		end

	drop_repository (a_table_name: STRING)
			-- Drop repository
		local
			l_repository: DB_REPOSITORY
		do
			create l_repository.make (a_table_name)
			l_repository.load

			if l_repository.exists then
				reset_data (a_table_name)
			end
		end

	reset_data (a_table_name: STRING)
		do
			db_change.modify ("DROP TABLE " + sql_table_name (a_table_name))
			assert ({STRING_32} "Reset data failed: " + db_change.error_message_32, db_change.is_ok)
		end

feature -- Spec helper

	sql_from_datetime (a_dt: DATE_TIME): STRING
			-- Specific SQL from DATE_TIME
		do
			Result := db_spec.date_to_str (a_dt)
		end

	sql_table_name (a_name: STRING): STRING
			-- SQL table name quoted if needed
		local
			s: STRING
		do
			create Result.make_from_string (a_name)
			if attached db_spec.identifier_quoter as l_sep then
				if l_sep.is_valid_as_string_8 then
					s := l_sep.to_string_8
				else
					s := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_sep)
				end
				Result.prepend (s)
				Result.append (s)
			end
		end

feature {NONE} -- Decimal callbacks

	create_decimal (a_digits: STRING_8; a_sign, a_precision, a_scale: INTEGER): ANY
			-- Create decimal
		local
			l_d: DECIMAL
			l_s: STRING_8
		do
			create l_s.make (a_precision + 2)
			if a_sign = 0 then
				l_s.append_character ('-')
			end

			if a_scale = 0 then
				l_s.append (a_digits)
			elseif a_scale > 0 then
				if a_scale < a_digits.count then
						-- 1.234
					l_s.append (a_digits.substring (1, a_digits.count - a_scale))
					l_s.append_character ('.')
					l_s.append (a_digits.substring (a_digits.count - a_scale + 1, a_digits.count))
				else
						-- 0.1234
					l_s.append ("0.")
					append_characters (l_s, '0', (a_scale - a_digits.count))
					l_s.append (a_digits)
				end
			else
				l_s.append (a_digits)
				append_characters (l_s, '0', (-a_scale))
			end
			create l_d.make_from_string (l_s)
			Result := l_d
		end

	append_characters (a_str: STRING_8; a_c: CHARACTER; a_n: INTEGER)
			-- Append `a_n' `a_c' into `a_str'.
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i = a_n
			loop
				a_str.append_character (a_c)
				i := i + 1
			end
		end

	is_decimal (a_obj: ANY): BOOLEAN
			-- Is decimal?
		do
			Result := attached {DECIMAL} a_obj
		end

	decimal_factors (a_obj: ANY): TUPLE [digits: STRING_8; sign, precision, scale: INTEGER]
			-- Decimal factors
		local
			l_sign: INTEGER
		do
			if attached {DECIMAL}a_obj as l_d then
				if l_d.is_negative then
					l_sign := 0
				else
					l_sign := 1
				end
				Result := [l_d.coefficient.out, l_sign, l_d.count, -l_d.exponent]
			else
				Result := ["0", 1, 1, 0]
			end
		end

	decimal_output (a_obj: ANY): STRING_8
			-- Decimal output
		do
			if attached {DECIMAL} a_obj as l_d then
				Result := l_d.to_engineering_string
			else
				Result := "0"
			end
		end

	error_parser: BOOLEAN
			-- Hack to use coefficient
		do
		end

	parse_parser (a_string: STRING)
			-- Hack to use coefficient
		do
		end

end
