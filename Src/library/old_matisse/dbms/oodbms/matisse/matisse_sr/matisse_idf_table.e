class MATISSE_IDF_TABLE

inherit

	MEMORY
		export {NONE} all
		redefine dispose
	end

creation

	make

feature {NONE} -- Initialization

	make(count,o_id : INTEGER) is
		require 
			arg_positive : o_id > 0 and count >= 0
		do
			oid := o_id
			c_init_flags(count)
			c_init_oids(count)
		end -- make

feature -- Element change

	put_flag(object : ANY) is
		-- Put flag at current flags_index position
		do
			c_put_flag($object)
		end -- put_flag
	
	put_oid(id : INTEGER) is
		-- Put oid at current oids_index position
		require
		    Valid_id: id > 0
		do
			c_put_oid(id)
		end -- put_oid

	save is
		-- Save C arrays in database
		do
			c_save_idf_table(oid)
		end -- save
	
	load is
		-- Retrieve table from database
		do
			c_load(oid)
		end -- end

feature -- Access

	flags_index : INTEGER is
		-- Current index in flags array
		do
			Result := c_flags_index
		end -- flags_index

	oids_index : INTEGER is
		-- Current index in oids array
		do
			Result := c_oids_index
		end -- oids_index

	ith_oid(i: INTEGER ) : INTEGER is
		--  Oid at position 'i'
		require
			inside_bounds : i>=0 and i<=oids_index
		do
			Result := c_ith_oid(i);
		end -- ith_oid

	ith_special(i:INTEGER) : SPECIAL[ANY] is
		-- Special object position 'i'
		require
			inside_bounds : i>=0 and i<=oids_index
		do
			Result := c_ith_special(i)
		end -- ith_special

	ith_normal(i:INTEGER) : ANY is
		--  Normal object at position 'i'
		require
			inside_bounds : i>=0 and i<=oids_index
		do
			Result := c_ith_normal(i)
		end -- ith_normal

	oid : INTEGER -- Table id in Matisse

feature -- Status Report

	is_ith_special(i:INTEGER) : BOOLEAN is
		-- Is ith object a special object ?
		do
			Result := c_is_ith_special(i)
		end -- is_ith_special
   
feature {NONE, MATISSE_STORER, PROXY_IDF_TABLE} -- Implementation
	-- available to MATISSE_STORER to enable deterministic cleanup!!
	dispose is
		-- Free C arrays when current object is no more used
		do
			c_free_flags
			c_free_oids
		end -- dispose

feature  {NONE} -- Implementation

	oids : POINTER -- Oids array

	flags : POINTER -- Flags array

feature {NONE} -- Externals

	c_is_ith_special(i:INTEGER) : BOOLEAN is
		external
			"C"
		end -- c_is_ith_special

	c_ith_special(i:INTEGER) : SPECIAL[ANY] is
		external
			"C"
		end -- c_ith_special

	c_ith_normal(i:INTEGER) : ANY is
		external
			"C"
		end -- c_ith_normal

	c_init_flags(c : INTEGER) is
		external
			"C"
		end -- c_init_flags

	c_init_oids(c:INTEGER) is
		external 
			"C" 
		end -- c_init_oids

	c_put_flag(object : POINTER) is
		external
			"C"
		end -- c_put_flag

	c_put_oid(c:INTEGER) is
		external 
			"C" 
		end -- c_put_oid

	c_free_flags is
		external
			"C"
		end -- c_free_flags

	c_free_oids is
		external 
			"C" 
		end -- c_free_oids

	c_save_idf_table(c:INTEGER)  is
		external 
			"C" 
		end -- c_save_idf_table

	c_load(c:INTEGER)  is
		external 
			"C" 
		end -- c_load

	c_ith_oid(c:INTEGER)  : INTEGER is
		external 
			"C" 
		end -- c_ith_oid

	c_oids_index : INTEGER is
		external 
			"C" 
		end -- c_oids_index

	c_flags_index : INTEGER is
		external 
			"C" 
		end -- c_flags_index

end -- class MATISSE_IDF_TABLE
