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

	LOCALIZED_PRINTER

create

	make

feature {NONE}

	base_selection: DB_SELECTION

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
			author: STRING
			price: REAL
			pub_date: DATE_TIME
			l_laststring: detachable STRING
			l_proc: like proc
		do
			create author.make (10)
			price := 51
			create pub_date.make (1984, 01, 01, 00, 00, 00)

			create l_proc.make (Proc_name)
			proc := l_proc
			l_proc.load
			l_proc.set_arguments_32
				({ARRAY [STRING_32]} <<"author", "price", "pub_date">>,
				<<author, price, pub_date >>)

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
				from
					io.putstring ("Author? ('exit' to terminate):")
					io.readline
					base_selection.set_action (Current)
				until
					io.laststring ~ "exit"
				loop
					l_laststring := io.laststring
					check l_laststring /= Void end
					author := l_laststring.twin
					io.putstring ("Seeking for books whose author's name match: ")
					io.putstring (author)
					io.new_line

					base_selection.set_map_name (author, "author")
					base_selection.set_map_name (price, "price")
					base_selection.set_map_name (pub_date, "pub_date")

					l_proc.execute (base_selection)
					if base_selection.is_ok then
						base_selection.load_result
					else
						io.put_string ("Error occurred ")
						io.put_string (session_control.error_message_32.as_string_8)
					end

					base_selection.unset_map_name ("author")
					base_selection.unset_map_name ("price")
					base_selection.unset_map_name ("pub_date")

					io.new_line
					io.putstring ("Author? ('exit' to terminate):")
					io.readline
				end
			end
		end

	execute
		do
			base_selection.object_convert (book)
			base_selection.cursor_to_object
			print (book)
			io.new_line
		end

feature {NONE}

	Select_text: STRING =
		"select * from DB_BOOK where author = :author or price = :price or year = :pub_date"

	Table_name: STRING =
		"DB_BOOK"

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
