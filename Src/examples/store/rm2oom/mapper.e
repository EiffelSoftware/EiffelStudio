class MAPPER

inherit

	RDB_HANDLE

create

	make

feature 

	make is
		local
			repository: DB_REPOSITORY;
			session_control: DB_CONTROL;
			tmp_string: STRING
		do
	 			-- Ask for user's name and password
			io.putstring("Database user authentication:%N");
			io.putstring ("Name: ");
			io.readline;
			tmp_string := clone (io.laststring);
			io.putstring("Password: ");
			io.readline;

				-- Set user's name and password
			login (tmp_string,io.laststring);

				-- Initialization of the Relational Database:
				-- This will set various informations to perform a correct
				-- connection to the Relational database
			set_base;

				-- Create an usefull class
				-- 'session_control' provides informations control access and
				--  the status of the database.
			create session_control.make;

				-- Start session: establishes connection to database
			session_control.connect;

			if not session_control.is_connected then
					-- Something went wrong, and the connection failed
				session_control.raise_error;
				io.putstring("Can't connect to the database.%N")
			else
				--  The Eiffel program is now connected to the database
				from 
					io.putstring("%NEnter repository name (`exit' to terminate): ");
					io.readline;
					create repository.make (clone (io.laststring));
				until
					io.laststring.is_equal("exit")
				loop
						-- Objects from the DB will be accessed through a 
						-- DB_REPOSITORY whose name is read from standard input
					repository.change_name(clone (io.laststring));
						-- Try to load some book objects from the DB
					repository.load;
					if not repository.exists then
 						-- There is no existing objects with
						-- such a name in the DB
						io.putstring("Table does not exist%N")
					else
						-- Generate an Eiffel class according to
						-- the object type loaded in the DB_REPOSITORY
						io.new_line;
						repository.generate_class
					end;
					io.putstring("%NEnter repository name (`exit' to terminate): ");
					io.readline
				end;

					-- Terminate session
				session_control.disconnect
			end
		end -- make

end -- class MAPPER


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
