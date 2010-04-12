note

	description: "Nested queries example."
	legal: "See notice at end of class."
	production: "EiffelStore"
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST inherit

	RDB_HANDLE

feature

	session: DB_CONTROL

	selection: detachable DB_SELECTION

	make
		local
			tmp_string: STRING
			my_action: ACTION_1_I
			l_laststring: detachable STRING
			l_database: like session_database
			l_selection: like selection
		do
				-- Ask for user's name and password
			io.putstring ("Database user authentication:%N")

			if db_spec.database_handle_name.is_case_insensitive_equal ("odbc") then
				io.putstring ("Data Source Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_data_source(l_laststring.twin)
 			end

			if db_spec.database_handle_name.is_case_insensitive_equal ("mysql") then
				io.putstring ("Schema Name: ")
				io.readline
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				set_application(l_laststring.twin)
			end

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
			create session.make
			session.connect
			if session.is_connected then
				io.putstring ("Database used: ")
				l_database := session_database
				check l_database /= Void end -- FIXME: implied by `session'.is_connected?
				io.putstring (l_database.name)
				io.new_line
				create l_selection.make
				selection := l_selection
				create my_action.make (l_selection)
				l_selection.set_action (my_action)
				l_selection.query (select_string)
				if session.is_ok then
					l_selection.load_result
				end
				l_selection.terminate
				session.disconnect
			else
				io.error.putstring ("Invalid user/password!%N")
			end
		end

	select_string: STRING
		deferred
		ensure
			result_not_void: Result /= Void
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


end -- class TEST


