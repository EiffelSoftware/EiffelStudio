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
			-- Initialization
			-- Create some threads that run at the same time.
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
			-- Perform login
		local
			l_name: detachable STRING
		do
			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				print ("Data Source Name: ")
				io.readline
				set_data_source (io.last_string.string)
			end

			if db_spec.database_handle_name.is_case_insensitive_equal ("mysql") then
				print ("Schema Name: ")
				io.readline
				set_application (io.last_string.string)
			end

				-- Ask for user's name and password
			print ("Name: ")
			io.readline
			l_name := io.last_string.string

			print ("Password: ")
			io.readline

				-- Set user's name and password
			login (l_name, io.last_string.string)
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
