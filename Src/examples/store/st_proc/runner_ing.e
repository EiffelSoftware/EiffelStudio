class RUNNER_ING

inherit

	RDB_HANDLE

creation

	make

feature {NONE}

	base_change: DB_CHANGE

	proc: DB_PROC

	repository: DB_REPOSITORY
			
	session_control: DB_CONTROL

	data_file: PLAIN_TEXT_FILE

	book: BOOK2
	
feature 

	make is
		local
			tmp_string: STRING
		do
			io.putstring ("Database user authentication:%N")
			io.putstring ("Name: ")
			io.readline
			tmp_string := clone (io.laststring)
			io.putstring ("Password: ")
			io.readline
			login (tmp_string, io.laststring)
			set_base

			!! repository.make (Table_name)

			!! session_control.make
			!! base_change.make

			!! book.make

			session_control.connect

			if not session_control.is_connected then
				session_control.raise_error
				io.putstring ("Can't connect to database.%N")
			else
				repository.load
				if repository.exists then
					make_change_ing
					session_control.disconnect
				else
					io.putstring ("Table not found!");
				end
			end
		end

feature {NONE}

	make_change_ing is
		local
			author: STRING
			price: REAL
			pub_date: ABSOLUTE_DATE
		do
			!! author.make (10)
			price := 51
			!! pub_date.make
			pub_date.change_date (01, 01, 1984)
			pub_date.change_time (00, 00, 00)

			!! proc.make (Proc_name)
			proc.load

			if proc.exists then
				io.putstring ("Stored procedure text: ")
				io.putstring (proc.text)
				io.new_line
			else
				proc.set_arguments (<<"author", "price", "pub_date">>,
							<<author, price, pub_date >>)
				proc.store (Select_text)
				io.putstring ("Procedure created.%N")
				proc.load
			end

			from
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			until
				io.laststring.is_equal ("exit")
			loop
				author := clone (io.laststring)
				io.putstring ("Seeking for books whose author's name match: ")
				io.putstring (author)
				io.new_line
				io.new_line

				base_change.set_map_name (author, "author")
				base_change.set_map_name (price, "price")
				base_change.set_map_name (pub_date, "pub_date")

				proc.execute (base_change)

				base_change.unset_map_name ("author")
				base_change.unset_map_name ("price")
				base_change.unset_map_name ("pub_date")

				io.new_line
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			end
		end
	
feature {NONE}

	Select_text: STRING is
		" update                                    db_book                                     set %
         %quantity =                                 quantity + 10 ,       author =     author    , %
         %price   =                price,            year                          =          year, %
		 %                                                                                          %
         %title           =          title                                   where author = :author %
		 %or price = :price or year = :pub_date"

	Table_name: STRING is
		"DB_BOOK"

	Proc_name: STRING is "db_book_proc"

end -- class RUNNER_ING


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
