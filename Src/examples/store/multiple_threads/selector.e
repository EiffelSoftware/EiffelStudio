note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: 86764 $"

class SELECTOR

inherit

	RDB_HANDLE

	THREAD_CONTROL

create
	make

feature {NONE} -- Init

	make
		local
			l_thread: DATA_LOAD_AND_SELECT_THREAD
			i: INTEGER
		do
			print ("Database user authentication:%N")
				-- Login for all threads.
			perform_login

			if attached Manager.current_session.session_login as l_login then
				from
					i := 1
				until
					i > 5
				loop
					create l_thread.make_thread (l_login)
					l_thread.launch
					i := i + 1
				end

				join_all
			end
		end

feature {NONE} -- Login

	perform_login
		local
			tmp_string: STRING
			l_laststring: detachable STRING
			l_dsn: detachable STRING
		do
			create l_dsn.make_empty
			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				print ("Data Source Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_data_source(l_laststring.twin)
				l_dsn := l_laststring.twin
			end

			if db_spec.database_handle_name.is_case_insensitive_equal ("mysql") then
				print ("Schema Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_application(l_laststring.twin)
			end

				-- Ask for user's name and password
			print ("Name: ")
			io.readline
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			tmp_string := l_laststring.twin
			print ("Password: ")
			io.readline

				-- Set user's name and password
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			login (tmp_string, l_laststring)
		end

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

end -- class SELECTOR
