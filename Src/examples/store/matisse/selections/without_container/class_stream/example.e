class EXAMPLE

inherit

	MATISSE_CONST

	MT_EXTERNAL

	DB_STATUS_USE

	SHARED_CURSOR

Creation 
    make

feature {NONE}

	make is
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

	actions is
		-- Database actions
	local 
		i: INTEGER
	do
		create one_selection.make
		create query.make(Ocs)
		create one_class.make("Employee")

        one_selection.set_map_name(one_class,Class_map)
		query.execute(one_selection)
		create one_action  one_selection.set_action(one_action) one_selection.reset_cursor(one_cursor) 
		if one_selection.is_ok then
			        one_selection.load_result
		end
	end -- actions

feature {NONE} -- Implementation

	appl : MATISSE_APPL
	session : DB_CONTROL

	one_selection : DB_SELECTION
	one_class : MT_CLASS
	query : DB_PROC
	one_action : CONTROL_ACTION

end -- class EXAMPLE

