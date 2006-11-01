indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EXAMPLE

inherit

	MATISSE_CONST

	MT_EXTERNAL

create 
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
		-- Get friends of object #659 = 1625
		create one_object.make(1625)
		create one_selection.make
		create query.make(Ooas) -- Use Oors and Ooirs for ObjectRelStream and ObjectIRelStream
		one_selection.set_map_name(one_object,Object_map)
		query.execute(one_selection)
		create one_container.make one_selection.set_container(one_container)
		one_selection.load_result
		from
			one_container.start
		until
			one_container.off
		loop
			one_attribute ?= one_container.item.data -- Use one_relationship for Oors and Ooirs
			io.putstring(one_attribute.name) io.new_line
			one_container.forth
		end
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
	one_relationship : MT_RELATIONSHIP;

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


end -- class EXAMPLE


