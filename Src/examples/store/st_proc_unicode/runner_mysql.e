note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: 82805 $"

class RUNNER_MYSQL

inherit
	RDB_HANDLE

	GLOBAL_SETTINGS

	LOCALIZED_PRINTER

create
	make

feature {NONE}

	base_change: DB_CHANGE

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

			io.putstring ("Schema Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			set_application(l_laststring.twin)

			io.putstring ("Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			tmp_string := l_laststring.twin
			io.putstring ("Password: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			login (tmp_string, l_laststring)
			set_base

			create session_control.make
			create base_change.make

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
					make_change_ing
					session_control.commit
					session_control.disconnect
				else
					io.putstring ("Table not found!");
				end
			end
		end

feature {NONE}

	make_change_ing
		local
			title: STRING_32
			price: REAL
			pub_date: DATE_TIME
			l_proc: like proc
		do
			create title.make (10)
			price := 222
			create pub_date.make_now

			create l_proc.make (Proc_name)
			proc := l_proc
			l_proc.load
			l_proc.set_arguments_32 (<<{STRING_32}"new_title", {STRING_32}"new_price", {STRING_32}"new_date">>,
						<<title, price, pub_date >>)

			if l_proc.exists then
				if attached l_proc.text_32 as l_text then
					io.putstring ("Stored procedure text: ")
					localized_print (l_text)
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

				title := {STRING_32}"面向对象软件构造"
				io.putstring ("Updating for books whose title's name match: ")
				localized_print (title)
				io.new_line

				base_change.set_map_name (title, "new_title")
				base_change.set_map_name (price, "new_price")
				base_change.set_map_name (pub_date, "new_date")


				l_proc.execute (base_change)

				base_change.unset_map_name ("new_title")
				base_change.unset_map_name ("new_price")
				base_change.unset_map_name ("new_date")

				io.new_line
			end
		end

feature {NONE}

	Select_text: STRING_32 = "update DB_BOOK_EXTENDED set year = new_date, price = new_price where title = new_title"

	Table_name: STRING_32 = "DB_BOOK_EXTENDED"

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
