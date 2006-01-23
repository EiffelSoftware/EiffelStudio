indexing

	description: "Nested queries example."
	legal: "See notice at end of class."
	production: "EiffelStore"
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class TEST_ODBC inherit

	RDB_HANDLE

feature

	session: DB_CONTROL

	selection: DB_SELECTION
        
	make is
		local
			tmp_string: STRING
			my_action: ACTION_1_I
		do
				-- Ask for user's name and password
			io.putstring ("Database user authentication:%N")
			io.putstring("Data Source Name: ");
			io.readline;
			set_data_source (io.laststring);
			io.putstring ("Name: ")
			io.readline
			tmp_string := clone (io.laststring)
			io.putstring ("Password: ")
			io.readline
			login (tmp_string, io.laststring)
			set_base
			create session.make
			session.connect
			if session.is_connected then
				io.putstring ("Database used: ")
				io.putstring (session_database.name)
				io.new_line
				create selection.make
				create my_action.make (selection)
				selection.set_action (my_action)
				selection.query (select_string)
				if session.is_ok then
					selection.load_result
				end
				selection.terminate
				session.disconnect
			else
				io.error.putstring ("Invalid user/password!%N")
			end
			io.readline
		end

	select_string: STRING is
		deferred
		ensure
			result_not_void: Result /= Void
		end

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


end -- class TEST


