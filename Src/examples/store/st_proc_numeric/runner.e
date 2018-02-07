note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision :$"

class RUNNER

inherit
	RDB_HANDLE

	GLOBAL_SETTINGS

	DCM_MA_DECIMAL_PARSER
		rename
			make as make_parser,
			error as error_parser,
			parse as parse_parser
		end
	LOCALIZED_PRINTER

create
	make

feature {NONE}

	base_change: DB_CHANGE

	proc: detachable DB_PROC

	repository: detachable DB_REPOSITORY

	session_control: DB_CONTROL

	data_file: detachable PLAIN_TEXT_FILE

	numeric_info: DECIMAL_INFO

feature {NONE} -- Creation

	make
		local
			tmp_string: STRING
			l_laststring: detachable STRING
			l_repository: like repository
		do
			set_use_extended_types (True)
			set_is_decimal_used (True)
			set_decimal_functions (agent create_decimal, agent is_decimal, agent decimal_factors, agent decimal_output)
			set_default_decimal_scale (2)

			io.putstring ("Database user authentication:%N")
			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				io.putstring ("Data Source Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline'
				set_data_source(l_laststring.twin)
 			end
			io.putstring ("Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline'
			tmp_string := l_laststring.twin
			io.putstring ("Password: ")
			io.readline

			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline'
			login (tmp_string, l_laststring)
			set_base

			create session_control.make
			create base_change.make

			create numeric_info.make

			session_control.connect

			if not session_control.is_connected then
				session_control.raise_error
				io.putstring ("Can't connect to database.%N")
			else
				create l_repository.make (Table_name)
				repository := l_repository
				l_repository.load
				if l_repository.exists then
					make_selection
					session_control.commit
					session_control.disconnect
				else
					io.putstring ("Table not found!");
				end
			end
		end

feature {NONE}

	make_selection
		local
			l_proc: like proc
			l_decimal: DECIMAL
			l_int_16: INTEGER_16
			l_int_32: INTEGER_32
			l_int_64: INTEGER_64
			l_real_32: REAL_32
			l_real_64: REAL_64
		do
			create l_decimal.make_from_string ("1.00")
			l_int_16 := 9999
			l_int_32 := 999999
			l_int_64 := 9999999999999999
			l_real_32 := 888.888
			l_real_64 := 88888888.888888

			create l_proc.make (Proc_name)
			proc := l_proc
			l_proc.load
			l_proc.set_arguments_32 (
				{ARRAY [STRING_32]} <<"decimal", "int_16", "int_32", "int_64", "real_32", "real_64">>,
				<<l_decimal, l_int_16, l_int_32, l_int_64, l_real_32, l_real_64>>)

			if l_proc.exists then
				if l_proc.text_32 /= Void then
					io.putstring ("Stored procedure text: ")
					localized_print(l_proc.text_32)
					io.new_line
				end
			else
				l_proc.store (Select_text)
				if l_proc.is_ok then
					l_proc.load
					io.putstring ("Procedure created.%N")
				else
					io.putstring ("Procedure creation failed.%N")
				end
			end

			base_change.set_map_name (l_decimal, "decimal")
			base_change.set_map_name (l_int_16, "int_16")
			base_change.set_map_name (l_int_32, "int_32")
			base_change.set_map_name (l_int_64, "int_64")
			base_change.set_map_name (l_real_32, "real_32")
			base_change.set_map_name (l_real_64, "real_64")

			l_proc.execute (base_change)

			base_change.clear_all

		end

feature -- Decimal Callbacks

	create_decimal (a_digits: STRING_8; a_sign, a_precision, a_scale: INTEGER): ANY
			-- Create decimal
		local
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
					append_characters (l_s, '0', a_scale - a_digits.count)
					l_s.append (a_digits)
				end
			else
				l_s.append (a_digits)
				append_characters (l_s, '0', - a_scale)
			end
			create {DECIMAL} Result.make_from_string (l_s)
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

	Select_text: STRING = "update DB_DECIMAL set numeric_t = :decimal, int_16 = :int_16, int_32 = :int_32, int_64 = :int_64, real_32_t = :real_32, real_64_t = :real_64 where 1=1"

	Table_name: STRING =
		"DB_DECIMAL"

	Proc_name: STRING = "DB_DECIMAL_PROC";

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
