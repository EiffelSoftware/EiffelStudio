class EXAMPLE

inherit

	MATISSE_CONST

	MT_EXTERNAL

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
		create query.make(Ocs)
		create one_class.make("employee")
		create one_selection.make
		one_selection.set_map_name(one_class,class_map)
		query.execute(one_selection)
        create one_container.make
        one_selection.set_container(one_container)
		one_selection.load_result
		from 
			i:=1
			create one_attribute.make("Integer value")
			create one_random.make
			one_container.start  
		until 
			one_container.off
		loop
			one_object ?= one_container.item.data		
			one_attribute.set_value(one_object,Mts32,one_random.i_th(i))
			one_container.forth
			io.putchar('.')i:=i+1
		end
		io.putstring("ok%N")
	end -- actions

feature {NONE} -- Implementation

	appl : MATISSE_APPL
	session : DB_CONTROL

	one_result : DB_RESULT 
	one_selection : DB_SELECTION
	one_class : MT_CLASS
	query : DB_PROC
	one_attribute : MT_ATTRIBUTE
	one_object : MT_OBJECT
	one_random : RANDOM
	one_container : LINKED_LIST[DB_RESULT]
	one_index : MT_INDEX

end -- class EXAMPLE


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

