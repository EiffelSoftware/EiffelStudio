Class STORE_OBJECTS 
inherit

	MATISSE_CONST

Creation {ANY} -- Creation procedure

	make

feature {NONE} -- Initialization

	make is
		-- Prints various information
	do
		-- 1/ Choose host name and database name. Adjust wait and priority so that it suits your needs.
		!!appl.login("TOKYO","testdb",0,0)

		-- 2/ Choose working mode. See documentation for that.
		appl.set_mode(OPENED_TRANSACTION,Void)

		-- 3/ Connect Matisse handle to EiffelStore.
		appl.set_base

		-- 4/ Create a Matisse session.
		!!session.make
		
		-- 5/ Connect to database with the appropriate mode (given above).
		session.connect

		-- 6/ Insert your actions here.
		-- ...
		actions

		--7/ Disconnect from database.
		session.disconnect
		
	end -- make


	actions is
		--
	local
		mode,tid : INTEGER
	--	a_storer: DATABASE_STORER
	do
	--	!! a_storer
		!!r1 r1.set(1945) !!r2 r2.set(89+1) r2.set_ref(r1) r1.set_ref(r2) 
		io.putstring("mode (1) Store (2) Retrieve (3) Store & Retrieve ? ")
		io.readint mode := io.lastint io.new_line
		inspect mode
		when 1 then
			cany.remove_all_instances
			cidf_table.remove_all_instances
		--	session.commit
			session.begin
			r2.set_matisse_storer
			r2.sol_store
			session.commit
		when 2 then
			r1 := Void r2.set2
			r2.set_matisse_retriever
			r2 ?= r2.retrieve(4657)
		when 3 then
        	cany.remove_all_instances
            cidf_table.remove_all_instances
        --    session.commit
            session.begin
          r2.set_matisse_storer
            r2.sol_store
			tid := r2.table_id
            r1 := Void r2.set2
			session.commit
          r2.set_matisse_retriever
            r2 ?= r2.retrieve(tid)
		end 
		stop_point
	end -- make

	stop_point is 
	do
	end

	cany : MT_CLASS is once !!Result.make("ANY") end -- cany

	cidf_table : MT_CLASS is once !!Result.make("IDF_TABLE") end -- cany

feature {NONE} -- Implementation

	r1,r2 : REFERENCE
	f: RAW_FILE
	appl : MATISSE_APPL
	session : DB_CONTROL


end -- class STORE_OBJECTS
