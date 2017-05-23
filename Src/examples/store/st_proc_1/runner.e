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

feature

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
			l_proc: like proc
			l_db_change: DB_CHANGE
		do
			create l_proc.make (Proc_name)
			proc := l_proc
			l_proc.load

			if l_proc.exists then
				if l_proc.text_32 /= Void then
					io.putstring ("Stored procedure text: ")
					localized_print (l_proc.text_32)
					io.new_line
				end
			else
				create l_db_change.make
				l_db_change.set_query (select_text)
				l_db_change.execute_query
				if l_db_change.is_ok then
					l_proc.load
					io.putstring ("Procedure created.%N")
				else
					io.putstring ("Procedure creation failed.%N")
				end
			end

			if l_proc.exists then
				base_selection.set_action (Current)
				io.putstring ("Getting all books: ")

				l_proc.execute (base_selection)
				base_selection.load_result
				base_selection.terminate
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
		"{
				CREATE PROCEDURE [dbo].[DB_BOOK_PROC_1] 
				AS
				BEGIN
					SELECT * INTO #tempBook FROM DB_BOOK;
					
					DECLARE @SQL varchar(1000), @cnt int
					SELECT @cnt = count(*) FROM #tempBook
					
					SELECT @SQL = 'SELECT TOP(' + convert(varchar(25),@cnt) + ') * FROM #tempBook';
					EXEC (@SQL);
					
					DROP TABLE #tempBook
				END
		}"

	Table_name: STRING =
		"DB_BOOK"

	Proc_name: STRING = "DB_BOOK_PROC_1";

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


end -- class RUNNER


