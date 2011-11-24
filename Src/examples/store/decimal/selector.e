note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: 85184 $"

class SELECTOR

inherit
	ACTION
		redefine
			execute
		end

	RDB_HANDLE

	GLOBAL_SETTINGS

	SYSTEM_ENCODINGS

	LOCALIZED_PRINTER

	DCM_MA_DECIMAL_PARSER
		rename
			make as make_parser,
			error as error_parser,
			parse as parse_parser
		end

create
	make

feature {NONE}

	base_selection: DB_SELECTION

	base_update: DB_CHANGE

	repository: detachable DB_REPOSITORY

	session_control: DB_CONTROL

	db_store: DB_STORE

	decimal_info: DECIMAL_INFO

feature

	make
		local
			l_repository: like repository
		do
			set_use_extended_types (True)
			set_is_decimal_used (True)
			set_decimal_functions (agent create_decimal, agent is_decimal, agent decimal_factors, agent decimal_output)
			set_default_decimal_scale (2)

			io.putstring ("Database user authentication:%N")
			perform_login

				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- connection to the Relational database
			set_base

				-- An Eiffel object is created. It will be stored in the DB,
				-- through the repository
			create decimal_info.make

				-- Create usefull classes
				-- 'session_control' provides informations control access and
				--  the status of the database.
				-- 'base_selection' provides a SELECT query mechanism.
			create session_control.make
			create base_selection.make
			create base_update.make
			create db_store.make

				-- Start session: establishes connection to database
			session_control.connect
			if not session_control.is_connected then
				session_control.raise_error
					-- Something went wrong, and the connection failed
				io.putstring ("%NCan't connect to database.%N")
			else
				create l_repository.make (Table_name)
				repository := l_repository

					--  The Eiffel program is now connected to the database
					-- Try to load table from the DB
				l_repository.load
				if not l_repository.exists then
						-- There is no existing objects in the DB
					io.putstring ("Loading and updating database ...%N")
						-- create the table in the database.
					l_repository.allocate (decimal_info)
					l_repository.load
					load_data (l_repository)
				end
					-- Ask the user for a SELECT statement, and execute it
				make_selection
					-- Terminate session
				session_control.disconnect
			end
		end

feature {NONE}

	perform_login
		local
			tmp_string: STRING
			l_laststring: detachable STRING
		do
			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				io.putstring ("Data Source Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_data_source(l_laststring.twin)
			end

			if db_spec.database_handle_name.is_case_insensitive_equal ("mysql") then
				io.putstring ("Schema Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_application(l_laststring.twin)
			end

				-- Ask for user's name and password
			io.putstring ("Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			tmp_string := l_laststring.twin
			io.putstring ("Password: ")
			io.readline

				-- Set user's name and password
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			login (tmp_string, l_laststring)
		end

	load_data (repo: DB_REPOSITORY)
			-- Create table in database with same structure as 'decimal_info'
			-- and load data from file 'data.sql'.
		require
			repository_attached: attached repository as l_rep and then l_rep.loaded
		local
			l_store: DB_STORE
		do
			session_control.begin

			l_store := db_store
			l_store.set_repository (repo)
			decimal_info.set_int_16 (1)
			decimal_info.set_int_32 (10000)
			decimal_info.set_int_64 (100000000)
			decimal_info.set_real_32_t (7898.34)
			decimal_info.set_real_64_t (999999.999999)
			decimal_info.set_numeric_t (create {DECIMAL}.make_from_string ("-123456789012.00"))
			l_store.put (decimal_info)

				-- Commit work
			session_control.commit
		end

	make_selection
			-- Select to list all data from the database.
		do
			is_object := False
			io.putstring ("Print data directly from database: ")
			io.new_line

				-- Set action to be executed after each 'load_result' iteration step.
				-- 'init' and 'execute' method of the current class are to be used.
			base_selection.set_action (Current)

				-- Query database.
			base_selection.query (Select_all)
				-- Iterate through resulting data, and display them
			base_selection.load_result

			base_selection.terminate

			io.new_line

			is_object := True
			io.putstring ("Print data through Eiffel object: ")
			io.new_line

				-- Set action to be executed after each 'load_result' iteration step.
				-- 'init' and 'execute' method of the current class are to be used.
			base_selection.set_action (Current)

				-- Query database.
			base_selection.query (Select_all)
				-- Iterate through resulting data, and display them
			base_selection.load_result

			base_selection.terminate

			io.new_line

		end

	execute
			-- This method is also  used by the class RDB_SELECTION, and is executed after each
			-- iteration step of 'load_result', it provides some facilities to control, manage, and/or
			-- display data resulting of a query.
		local
			i: INTEGER
			tuple: DB_TUPLE
			r_any: detachable ANY
			l_cursor: detachable DB_RESULT
		do
			if is_object then
					-- Converts a tuple in an eiffel object of type 'decimal_type' and
					-- display it using a method of its own class.
				base_selection.object_convert (decimal_info)
				base_selection.cursor_to_object
				localized_print (decimal_info.out_32)
				io.new_line
			else
					-- Simply prompts column name on standard output.
					-- Prompt column values on standard output.
				from
					i := 1
					l_cursor := base_selection.cursor
					check l_cursor /= Void end -- FIXME: implied by ...?
					create tuple.copy (l_cursor)
				until
					i > tuple.count
				loop
					r_any := tuple.item (i)
					if r_any /= Void then
						if attached {INTEGER_REF} r_any as l_r_int then
							io.putint (l_r_int.item)
						elseif attached {INTEGER_16_REF} r_any as l_r_int16 then
							io.put_integer_16 (l_r_int16.item)
						elseif attached {INTEGER_64_REF} r_any as l_r_int64 then
							io.put_integer_64 (l_r_int64.item)
						elseif attached {REAL_REF} r_any as l_r_real then
							io.putreal (l_r_real.item)
						elseif attached {DOUBLE_REF} r_any as l_r_double then
							io.putdouble (l_r_double.item)
						elseif attached {STRING_GENERAL}r_any as l_r_str then
							localized_print (l_r_str)
						elseif attached {DECIMAL}r_any as l_de then
							io.put_string (l_de.to_engineering_string)
						else
							io.putstring (r_any.out)
						end
					else
						io.putstring("*void*")
					end
					io.putstring (" %T")
					i := i + 1
				end
				io.new_line
			end
		end

feature -- Decimal Callbacks

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

feature {NONE}

	is_object: BOOLEAN

	Select_all: STRING =
		"select * from DB_DECIMAL"

	Table_name: STRING =
		"DB_DECIMAL"


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

end -- class SELECTOR
