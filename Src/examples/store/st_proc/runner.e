class RUNNER

inherit

	ACTION
		redefine 
			execute
		end

	RDB_HANDLE

create

	make

feature {NONE}

	base_selection: DB_SELECTION

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
			create base_selection.make

			create book.make

			session_control.connect

			if not session_control.is_connected then
				session_control.raise_error
				io.putstring ("Can't connect to database.%N")
			else
				repository.load
				if repository.exists then
					make_selection
					session_control.disconnect
				else
					io.putstring ("Table not found!");
				end
			end
		end

feature {NONE}

	make_selection is
		local
			author: STRING
			price: REAL
			pub_date: DATE_TIME
		do
			create author.make (10)
			price := 51
			create pub_date.make (1984, 01, 01, 00, 00, 00)
			create proc.make (Proc_name)
			proc.load
			proc.set_arguments (<<"author", "price", "pub_date">>,
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
				base_selection.set_action (Current)
			until
				io.laststring.is_equal ("exit")
			loop
				author := clone (io.laststring)
				io.putstring ("Seeking for books whose author's name match: ")
				io.putstring (author)
				io.new_line
				io.new_line

				base_selection.set_map_name (author, "author")
				base_selection.set_map_name (price, "price")
				base_selection.set_map_name (pub_date, "pub_date")

				proc.execute (base_selection)

				base_selection.load_result

				base_selection.unset_map_name ("author")
				base_selection.unset_map_name ("price")
				base_selection.unset_map_name ("pub_date")

				io.new_line
				io.putstring ("Author? ('exit' to terminate):")
				io.readline
			end
		end
	
	execute is
		do
			base_selection.object_convert (book)
			base_selection.cursor_to_object
			print (book)
			io.new_line
		end

feature {NONE}

	Select_text: STRING is
		"select * from DB_BOOK where author = :author %
		 %or price = :price or year = :pub_date"

	Table_name: STRING is
		"DB_BOOK"

	Proc_name: STRING is "db_book_proc"

end -- class RUNNER


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
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
