class MAPPER

inherit

	RDB_HANDLE

create

	make

feature 

	make is
		local
			repository: DB_REPOSITORY
			session_control: DB_CONTROL
			tmp_string: STRING
		do
	 			-- Ask for user's name and password
			io.putstring("Database user authentication:%N");
			io.putstring ("Name: ")
			io.readline;
			tmp_string := clone (io.laststring)
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
				
				io.putstring ("%NEnter path of directory where files will be generated: ")
				io.readline
				path_name := clone (io.laststring)
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
						generate_class (repository)
					end;
					io.putstring("%NEnter repository name (`exit' to terminate): ");
					io.readline
				end;

					-- Terminate session
				session_control.disconnect
			end
		end -- make

	generate_class (repository: DB_REPOSITORY) is
			-- Generate class from `repository'.
		local
			fi: PLAIN_TEXT_FILE
			rescued: BOOLEAN
			fn: FILE_NAME
		do
			if not rescued then
				create fn.make_from_string (path_name)
				fn.extend (repository.repository_name)
				fn.add_extension (Eiffelclass_extension)
				create fi.make_create_read_write (fn)
				repository.generate_class (fi)
				fi.close
			else
				io.putstring ("Cannot create file " + repository.repository_name)
			end
		rescue
			rescued := True
			retry
		end

	Eiffelclass_extension: STRING is "e"
			-- Extension for an Eiffel class.

	path_name: STRING
			-- Class generation path name.

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
