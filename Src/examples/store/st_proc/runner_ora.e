class RUNNER_ORA

inherit

	RDB_HANDLE

create

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

			create repository.make (Table_name)

			create session_control.make
			create base_change.make

			create book.make

			session_control.connect

			if not session_control.is_connected then
				session_control.raise_error
				io.putstring ("Can't connect to database.%N")
			else
				repository.load
				if repository.exists then
					make_change_ing
					session_control.commit
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
			pub_date: DATE_TIME
		do
			create author.make (10)
			price := 222
			create pub_date.make_now 

			create proc.make (Proc_name)
			proc.load
			proc.set_arguments (<<"new_author", "new_price", "new_date">>,
						<<author, price, pub_date >>)

			if proc.exists then
				io.putstring ("Stored procedure text: ")
				io.putstring (proc.text)
				io.new_line
			else
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
				io.putstring ("Updating books whose author's name match: ")
				io.putstring (author)
				io.new_line
				io.new_line

				base_change.set_map_name (pub_date, "new_date")
				base_change.set_map_name (price, "new_price")
				base_change.set_map_name (author, "new_author")

				proc.execute (base_change)

				base_change.unset_map_name ("new_author")
				base_change.unset_map_name ("new_price")
				base_change.unset_map_name ("new_date")

				io.new_line
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			end
		end
	
feature {NONE}

	Select_text: STRING is
		"update DB_BOOK set %
		%price = new_price, year = new_date where author = new_author"

	Table_name: STRING is
		"DB_BOOK"

	Proc_name: STRING is "DB_BOOK_PROCEDURE"

end -- class RUNNER_ORA


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
