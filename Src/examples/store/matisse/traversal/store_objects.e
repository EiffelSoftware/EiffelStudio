Class STORE_OBJECTS 

Creation {ANY} -- Creation procedure

	make

feature {NONE} -- Initialization


	make is
		--
	do
		-- Create people and their relationships
		create p1.make("P1","Henri",255,"Employee") create p2.make("P2","Jacques",49,"Manager")
   	 create p3.make("P3","Jean",35,"Employee") create p4.make("P4","Pierre",48,"Manager")
		p1.set_friends(p2,p4) p2.set_friends(p3,p4) p3.set_friends(p1,p4) p4.set_friends(p2,p1)

		-- Store objects with standard storable
        create f.make_open_write("ise_basic_store_file")
        p1.ise_basic_store(f)
        f.close
		-- Store objects with new storable
        create f.make_open_write("sol_basic_store_file")
		p1.set_matisse_storer
        p1.sol_store(f)
        f.close

        -- Retrieve new file with standard storable
		p1 := Void  p2 := Void p3 := Void  p4 := Void
		create p1.make("Mink","Thierry",34,"Manager")		
        p1.set_matisse_storer
		p1 ?= p1.sol_retrieve_by_name("sol_basic_store_file")
	end -- make


feature {NONE} -- Implementation

    p1,p2,p3,p4 : PERSON_REF
	f: RAW_FILE

end -- class STORE_OBJECTS
