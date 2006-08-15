indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class RUNNER_SEL

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
			io.putstring("Data Source Name: ")
			io.readline
			set_data_source(io.laststring)

			io.putstring ("Name: ")
			io.readline
			tmp_string := io.laststring.twin
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
					session_control.commit
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
		do
			create author.make (10)

			create proc.make (Proc_name)
			proc.load
			proc.set_arguments (<<"author">>,
						<<author>>)
			if proc.exists then
				io.putstring ("Stored procedure text: ")
				io.putstring (proc.text)
				io.new_line
			else
				proc.store (Select_text)
				proc.load
			end
			if proc.exists then
				from
					io.putstring ("Procedure created.%N")
					io.putstring ("Author? ('exit' to terminate):")
					io.readline
					base_selection.set_action (Current)
				until
					io.laststring.is_equal ("exit")
				loop
					author := io.laststring.twin
					io.putstring ("Seeking books whose author's name match: ")
					io.putstring (author)
					io.new_line

				--	base_selection.set_map_name (author, "author")
					base_selection.set_map_name (author, "?")
					proc.execute (base_selection)
					base_selection.load_result
					base_selection.unset_map_name ("?")
					io.new_line
 					io.putstring ("Author? ('exit' to terminate):")
					io.readline
				end
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
		" select * from DB_BOOK where author = :author "

	Table_name: STRING is
		"DB_BOOK"

	Proc_name: STRING is "sel_proc";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class RUNNER_SEL


