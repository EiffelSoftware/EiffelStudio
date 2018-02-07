note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class RUNNER_MYSQL

inherit
	RDB_HANDLE

	LOCALIZED_PRINTER

create
	make

feature {NONE}

	base_change: DB_CHANGE

	proc: detachable DB_PROC

	repository: detachable DB_REPOSITORY

	session_control: DB_CONTROL

	data_file: detachable PLAIN_TEXT_FILE

	book: BOOK2

feature {NONE} -- Creation

	make
		local
			tmp_string: STRING
			l_laststring: detachable STRING
			l_repository: like repository
		do
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
					io.putstring ("Table not found!")
				end
			end
		end

feature {NONE}

	make_change_ing
		local
			author: STRING
			price: REAL
			pub_date: DATE_TIME
			l_proc: like proc
			l_laststring: detachable STRING
		do
			create author.make (10)
			price := 222
			create pub_date.make_now

			create l_proc.make (Proc_name)
			proc := l_proc
			l_proc.load
			l_proc.set_arguments_32 ({ARRAY [STRING_32]} <<"new_author", "new_price", "new_date">>,
						<<author, price, pub_date >>)

			if l_proc.exists then
				io.putstring ("Stored procedure text: ")
				localized_print (l_proc.text_32)
				io.new_line
			else
				l_proc.store (Select_text)
				io.putstring ("Procedure created.%N")
				l_proc.load
			end

			from
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			until
				io.laststring ~ "exit"
			loop
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				author := l_laststring.twin
				io.putstring ("Updating books whose author's name match: ")
				io.putstring (author)
				io.new_line
				io.new_line

				base_change.set_map_name (pub_date, "new_date")
				base_change.set_map_name (price, "new_price")
				base_change.set_map_name (author, "new_author")

				l_proc.execute (base_change)

				base_change.unset_map_name ("new_author")
				base_change.unset_map_name ("new_price")
				base_change.unset_map_name ("new_date")

				io.new_line
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			end
		end

feature {NONE}

	Select_text: STRING = "update DB_BOOK set price = new_price, year = new_date where author = new_author"

	Table_name: STRING = "DB_BOOK"

	Proc_name: STRING = "DB_BOOK_PROC";

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
