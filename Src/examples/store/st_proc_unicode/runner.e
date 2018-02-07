note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision :$"

class RUNNER

inherit

	ACTION
		redefine
			execute
		end

	RDB_HANDLE

	GLOBAL_SETTINGS

	LOCALIZED_PRINTER

create

	make

feature {NONE}

	base_selection: DB_SELECTION

	proc: detachable DB_PROC

	repository: detachable DB_REPOSITORY

	session_control: DB_CONTROL

	data_file: detachable PLAIN_TEXT_FILE

	book: BOOK3

feature {NONE} -- Creation

	make
		local
			tmp_string: STRING
			l_laststring: detachable STRING
			l_repository: like repository
		do
					-- Use extended types, so that Unicode is supported.
			set_use_extended_types (True)

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
			create base_selection.make

			create book.make

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
			title: STRING_32
			price: REAL
			pub_date: DATE_TIME
			l_proc: like proc
		do
			create title.make (10)
			price := 51
			create pub_date.make (1984, 01, 01, 00, 00, 00)

			create l_proc.make (Proc_name)
			proc := l_proc
			l_proc.load
			l_proc.set_arguments_32
				({ARRAY [STRING_32]} <<"title", "price", "pub_date">>,
				<<title, price, pub_date >>)

			if l_proc.exists then
				if attached l_proc.text_32 as t then
					io.putstring ("Stored procedure text: ")
					localized_print (t)
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

			if l_proc.exists then
				base_selection.set_action (Current)

				title := {STRING_32}"面向对象软件构造"
				io.putstring ("Seeking for books whose title's name match: ")
				localized_print (title)
				io.new_line

				base_selection.set_map_name (title, "title")
				base_selection.set_map_name (price, "price")
				base_selection.set_map_name (pub_date, "pub_date")

				l_proc.execute (base_selection)
				base_selection.load_result

				base_selection.unset_map_name ("title")
				base_selection.unset_map_name ("price")
				base_selection.unset_map_name ("pub_date")

				io.new_line
			end
		end

	execute
		do
			base_selection.object_convert (book)
			base_selection.cursor_to_object
			localized_print (book.out_32)
			io.new_line
		end

feature {NONE}

	Select_text: STRING_32 =
		"select * from DB_BOOK_EXTENDED where title = :title or price = :price or year = :pub_date"

	Table_name: STRING_32 =
		"DB_BOOK_EXTENDED"

	Proc_name: STRING_32 = "DB_BOOK_PROC_2";

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
