note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class MAPPER

inherit

	RDB_HANDLE

create

	make

feature

	make
		local
			repository: DB_REPOSITORY
			session_control: DB_CONTROL
			tmp_string: STRING
			l_laststring: detachable STRING
		do
	 			-- Ask for user's name and password
			io.putstring("Database user authentication:%N");

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
			io.readline;
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			tmp_string := l_laststring.twin
			io.putstring("Password: ");
			io.readline;

				-- Set user's name and password
			l_laststring := io.laststring
			check l_laststring /= Void end -- implied by `readline' postcondition
			login (tmp_string,l_laststring);

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
				l_laststring := io.laststring
				check l_laststring /= Void end -- implied by `readline' postcondition
				path_name := l_laststring.twin
				from
					io.putstring("%NEnter repository name (`exit' to terminate): ");
					io.readline;
					l_laststring := io.laststring
					check l_laststring /= Void end -- implied by `readline' postcondition
					create repository.make (l_laststring.twin);
				until
					io.laststring ~ "exit"
				loop
						-- Objects from the DB will be accessed through a
						-- DB_REPOSITORY whose name is read from standard input
					l_laststring := io.laststring
					check l_laststring /= Void end -- implied by `readline' postcondition
					repository.change_name(l_laststring.twin);
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

	generate_class (repository: DB_REPOSITORY)
			-- Generate class from `repository'.
		require
			path_name_attached: path_name /= Void
		local
			fi: PLAIN_TEXT_FILE
			rescued: BOOLEAN
			fn: FILE_NAME
			l_path_name: like path_name
		do
			if not rescued then
				l_path_name := path_name
				check l_path_name /= Void end -- implied by precondition `path_name_attached'
				create fn.make_from_string (l_path_name)
				fn.extend (repository.repository_name)
				fn.add_extension (Eiffelclass_extension)
				create fi.make_create_read_write (fn)
				repository.generate_class (fi)
				fi.close
			else
				io.putstring ("Cannot create file " + fn + 
					" for repository " + repository.repository_name)
			end
		rescue
			rescued := True
			retry
		end

	Eiffelclass_extension: STRING = "e"
			-- Extension for an Eiffel class.

	path_name: detachable STRING;
			-- Class generation path name.

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


end -- class MAPPER


