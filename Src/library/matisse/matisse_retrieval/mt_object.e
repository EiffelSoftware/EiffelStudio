indexing
	description: "Class which define a Matisse Object"
	date: "$Date$"
	revision: "$Revision$"


class 
	MT_OBJECT

inherit
	MT_CONSTANTS
		undefine 
			is_equal
		end

	MT_OBJECT_EXTERNAL
		undefine 
			is_equal
		end


	MT_KEYS_EXTERNAL
		undefine 
			is_equal
		end


	MT_NAME_EXTERNAL
		undefine 
			is_equal
		end

creation
	make 

feature {NONE} -- Initialization

	frozen make (db_oid: INTEGER) is	
			-- Object from Database.
		do
			oid := db_oid
		end


feature -- Access

	oid: INTEGER 
		-- Object ID in Matisse.

	size: INTEGER is
			-- Size of Matisse Object in bytes.
		do
			Result := c_object_size (oid)
		end

	successors (one_relationship: MT_RELATIONSHIP): ARRAY [MT_OBJECT] is
			-- Successors of current Matisse Object.
		do
			c_get_successors (oid,one_relationship.rid)
			Result := retrieved_array
		end
	
	predecessors (one_relationship: MT_RELATIONSHIP): ARRAY [MT_OBJECT] is
			-- Predecessors of current Matisse Object.
		do
			c_get_predecessors (oid,one_relationship.rid)
			Result := retrieved_array
		end

	added_successors (one_relationship: MT_RELATIONSHIP): ARRAY [MT_OBJECT] is
			-- Get all added successors through a relationship 
			-- since beginning a current transaction.
		do
			c_get_added_successors (oid,one_relationship.rid)
			Result := retrieved_array
		end

	removed_successors (one_relationship: MT_RELATIONSHIP): ARRAY [MT_OBJECT] is
			-- Get all removed successors since beginning of transaction.
		do
			c_get_removed_successors (oid,one_relationship.rid)
			Result := retrieved_array
		end


feature -- Status Report

	is_ok: BOOLEAN is
			-- Check instance.
		do
			c_check_object (oid)
		end

	is_predefined_msp: BOOLEAN is
			-- Does object belongs to meta-schema?
		local
			a: MT_METHOD
			b: MT_UNIVERSAL_METHOD
			c: MT_MESSAGE
			d: MT_INDEX
		do
			Result := c_is_predefined_object (oid)
		end

	is_instance_of (one_class: MT_CLASS): BOOLEAN is
		-- Is current object an instance of 'one_class'.
	do
		Result := c_is_instance_of (oid,one_class.oid)
	end

feature -- Comparison

	is_equal (other: like Current ): BOOLEAN is
			-- Is current object equal to other according to ids?
		do
			Result := oid = other.oid
		end

feature -- Output

	print_to_file (file: FILE) is
			-- Outputs object to file.
		require
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_write: file.is_open_read
			file_is_plain_text: file.is_plain_text
		do
			c_print_to_file (oid, file.file_pointer)
		end

feature -- Action

	lock (a_lock: INTEGER) is
			-- Lock current object in Matisse.
		require
			a_lock_is_read_or_is_write: a_lock = Mt_Read or else a_lock = Mt_Write
		do
			c_lock_object (oid, a_lock)
		end

	write_lock is
			-- Set write lock on current object in MATISSE.
		do
			c_write_lock_object (oid)
		end

	load is
			-- Load current object in client cache so that 
			-- there is no more server access readings on this object.
		do
			c_load_object (oid)
		end

	dispose is
			-- Remove object from local cache.
		do
			c_free_object (oid)
		end
		
feature {NONE} -- Implementation

	retrieved_array: ARRAY [MT_OBJECT] is
		local
			keys_count, i: INTEGER
			one_object: MT_OBJECT
			oids: ARRAY [INTEGER]
		do
			keys_count := c_keys_count
			!! Result.make (1, keys_count)
			!! oids.make (1, keys_count)
			from
				i := 1
			until 
				i = keys_count + 1
			loop
				oids.force (c_ith_key (i), i)
 				i := i + 1
			end
			c_free_keys

			from 
				i := 1
			until 
				i > keys_count
			loop
				Result.force (current_db.eif_object_from_oid (oids.item (i)), i)
				i := i + 1
			end
		end

feature {NONE} -- Byte array manipulation

	put_byte_array_to_file (file_pointer: POINTER; byte_array: POINTER; count: INTEGER): INTEGER is
			-- Write 'byte_array' at current position.
			-- Return the number of bytes written.
		external 
			"C"
		end
		
end -- class MT_OBJECT


