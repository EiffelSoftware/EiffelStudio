note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EXAMPLE

inherit

	MATISSE_CONST

	MT_EXTERNAL

create 
    make

feature {NONE}

	make
		-- Prints various information
	do
		-- 1/ Choose host name and database name. Adjust wait and priority so that it suits your needs.
		create appl.login("venus","COMPANY",0,0)

		-- 2/ Choose working mode. See documentation for that.
		appl.set_mode(OPENED_TRANSACTION,Void)

		-- 3/ Connect Matisse handle to EiffelStore.
		appl.set_base

		-- 4/ Create a Matisse session.
		create session.make
		
		-- 5/ Connect to database with the appropriate mode (given above).
		session.connect

		-- 6/ Insert your actions here.
		-- ...
		actions

		--7/ Disconnect from database.
		session.disconnect
		
	end -- make

feature -- Status Setting

	actions
		-- Database actions
	local 
		i,dimension : INTEGER
	do
		create repository.make("db_repository_mat test")
		repository.load
		io.putstring("Repository ") io.putstring(repository.repository_name) io.putstring(" loaded.") io.new_line
		create one_tester.make
		io.putbool(repository.conforms(one_tester)) io.new_line
		repository.generate_class
		
		create one_tester.make
		create one_storer.make
		one_storer.set_repository(repository)
		one_storer.put(one_tester)

	end -- actions

feature {NONE} -- Implementation

	appl : MATISSE_APPL
	session : DB_CONTROL

	repository : DB_REPOSITORY
	one_tester : DB_REPOSITORY_TESTER
	one_storer : DB_STORE;

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


end -- class EXAMPLE

