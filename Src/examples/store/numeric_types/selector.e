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

create
	make

feature {NONE}

	base_selection: DB_SELECTION

	base_update: DB_CHANGE

	repository: detachable DB_REPOSITORY

	session_control: DB_CONTROL

	data_file: detachable PLAIN_TEXT_FILE

	numeric_info: NUMERIC_INFO

feature

	make
		local
			l_repository: like repository
		do
			set_use_extended_types (True)

			io.putstring ("Database user authentication:%N")
			perform_login

				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- connection to the Relational database
			set_base

				-- An Eiffel object is created. It will be stored in the DB,
				-- through the repository
			create numeric_info.make

				-- Create usefull classes
				-- 'session_control' provides informations control access and
				--  the status of the database.
				-- 'base_selection' provides a SELECT query mechanism.
			create session_control.make
			create base_selection.make
			create base_update.make

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
						-- Load some from file
					load_data
					l_repository.load
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

	load_data
			-- Create table in database with same structure as 'numeric_info'
			-- and load data from file 'data.sql'.
		require
			repository_attached: repository /= Void
		local
			l_laststring: detachable STRING
			l_data_file: like data_file
			l_string: STRING_32
		do
			session_control.begin

			from
				create l_data_file.make_open_read (Data_file_name)
				data_file := l_data_file
			until
				l_data_file.end_of_file
			loop
				l_data_file.readline
				if not l_data_file.end_of_file then
					l_laststring := l_data_file.laststring
					check l_laststring /= Void end -- implied by `readline' postcondition

						-- Insert objects in the table "DB_NUMERIC"
					utf8.convert_to (utf16, l_laststring.twin)
					l_string := utf8.last_converted_string_32
					localized_print (l_string)
					io.new_line
					base_update.modify (l_string)
				end
			end
			l_data_file.close

				-- Commit work
			session_control.commit
		end

	make_selection
			-- Select to list all data from the database.
		local
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
					-- Converts a tuple in an eiffel object of type 'numeric_type' and
					-- display it using a method of its own class.
				base_selection.object_convert (numeric_info)
				base_selection.cursor_to_object
				localized_print (numeric_info.out_32)
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

feature {NONE}

	is_object: BOOLEAN

	Select_all: STRING =
		"select * from DB_NUMERIC"

	Table_name: STRING =
		"DB_NUMERIC"

	Data_file_name: STRING
		once
			create Result.make_from_string ("data.sql.")
			Result.append (db_spec.database_handle_name.as_lower)
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

end -- class SELECTOR
