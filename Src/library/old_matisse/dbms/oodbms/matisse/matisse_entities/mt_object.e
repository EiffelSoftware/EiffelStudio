class MT_OBJECT

inherit

	MATISSE_CONST
		export {NONE} all ; {ANY} mtread,mtwrite
		redefine is_equal
		end

	MT_OBJECT_EXTERNAL
	        redefine is_equal
		end


	MT_KEYS_EXTERNAL
		redefine is_equal
		end


	MT_NAME_EXTERNAL
 	       redefine is_equal
		end


	DB_DATA
		redefine is_equal
		end

Creation

	make,make_from_class,make_from_class_name

feature {NONE} -- Initialization

	frozen make(db_oid : INTEGER) is	
		-- Object from Database
		do
			oid := db_oid
		end -- make

feature {NONE} -- Initialization

	make_from_class(one_class : MT_CLASS)  is
		-- New object inserted into database
		local
			c_class_name : ANY
		do
			c_class_name := one_class.name.to_c
			oid := c_create_object($c_class_name)
		end -- make_from_class

	make_from_class_name(one_class_name : STRING)  is
		-- New object inserted into database
		require
			name_not_void : one_class_name /= Void
			name_not_empty : not one_class_name.empty
		local
			c_class_name : ANY
		do
			c_class_name := one_class_name
			oid := c_create_object($c_class_name)
		end -- make_from_class_name

feature -- Access

	oid : INTEGER -- Object ID in Matisse

	name : STRING is
		-- Object name in Matisse
		do
			!!Result.make(0) Result.from_c(c_object_name(oid))
		end -- name

	size : INTEGER is
		-- Size of Matisse Object in bytes
		do
			Result := c_object_size(oid)
		end -- size

	mt_generator : MT_CLASS is
		-- Class that has generated current object
		local
			all_classes : ARRAY[MT_OBJECT]
			i:INTEGER
			found : BOOLEAN
			one_class : MT_CLASS
		do
			all_classes := root_class.all_instances
			from
				i:=all_classes.lower
				found := False
			until
				i>all_classes.upper or found
			loop
				!!Result.make(all_classes.item(i).name) 
				found := is_instance_of(Result) and then not all_classes.item(i).name.is_equal("ANY") 
				i:=i+1
			end -- loop
			if not found then !!Result.make("ANY") end
		end  -- mt_generator

	successors(one_relationship : MT_RELATIONSHIP) : ARRAY[MT_OBJECT] is
		-- Successors of current Matisse Object	
		do
			c_get_successors(oid,one_relationship.rid)
			Result := retrieved_array
		end -- successors
	
	predecessors(one_relationship : MT_RELATIONSHIP) : ARRAY[MT_OBJECT] is
		-- Predecessors of current Matisse Object
		do
			c_get_predecessors(oid,one_relationship.rid)
			Result := retrieved_array
		end -- predecessors

	added_successors(one_relationship : MT_RELATIONSHIP) : ARRAY[MT_OBJECT] is
		-- Get all added successors through a relationship since beginning a current transaction
		do
			c_get_all_added_succs(oid,one_relationship.rid)
			 Result := retrieved_array
		end -- added_successors

	removed_successors(one_relationship : MT_RELATIONSHIP) : ARRAY[MT_OBJECT] is
		-- Get all removed successors since beginning of transaction
		do
			c_get_all_rem_succs(oid,one_relationship.rid)
			Result := retrieved_array
		end -- removed_successors

feature -- Element Change

	prepend_successor(one_relationship : MT_RELATIONSHIP;object_to_add : MT_OBJECT) is
		-- Add 'object_to_add'  to relationship's head
		do
			c_add_successor_first(oid,one_relationship.rid,object_to_add.oid)
		end -- prepend_successor

	append_successor(one_relationship : MT_RELATIONSHIP;object_to_add : MT_OBJECT) is
		-- Add 'object_to_add'  to relationship's tail
		do
			c_add_successor_append(oid,one_relationship.rid,object_to_add.oid)
		end -- append_successor

	insert_successor_after(one_relationship : MT_RELATIONSHIP;object_to_add : MT_OBJECT;one_object : MT_OBJECT) is
		-- Add 'object_to_add'  after `one_object' in relationship
		do
			c_add_successor_after(oid,one_relationship.rid,object_to_add.oid,one_object.oid)
		end -- insert_successor_after

	insert_n_successors_after(relationship : MT_RELATIONSHIP;all_objects : ARRAY[MT_OBJECT];one_object : MT_OBJECT) is
		-- Add objects in manifest array 'all_objects' after `one_object' in relationship
		-- Respect order of array
		local
			i:INTEGER
		do
			from 
				i := all_objects.lower
			until
				i> all_objects.upper
			loop
				insert_successor_after(relationship,all_objects.item(i),one_object)
				i:=i+1
			end -- loop
		end -- insert_n_successors_after

feature -- Status Report

	is_ok : BOOLEAN is
		-- Check instance
		do
			c_check_instance(oid)
		end  -- Check

	is_predefined_msp : BOOLEAN is
			-- Does object belongs to meta-schema ?
		do
			Result := c_predefined_msp(oid)
		end -- is_predefined_msp

	is_instance_of(one_class : MT_CLASS) : BOOLEAN is
		-- Is current object an instance of 'one_class'
	do
		Result := c_type_p(oid,one_class.cid)
	end -- is_instance_of

feature -- Comparison

	is_equal(other : MT_OBJECT) : BOOLEAN is
		-- Is current object equal to other according to ids ?
		do
			Result := oid = other.oid
		end -- is_equal

feature -- Removal

	remove is
		-- Remove object from database
		do
			c_remove_object(oid)
			oid := 0
		end -- remove

	remove_attr_value(one_attribute : MT_ATTRIBUTE) is
		-- Remove value from attribute
		do
			c_remove_value(oid,one_attribute.aid)
		end -- remove_attr_value

	remove_all_successors(one_relationship : MT_RELATIONSHIP) is
		-- Remove all successors of current Matisse Object
		do
			c_remove_all_successors(oid,one_relationship.rid)
		end -- remove_all_successors

feature -- Output

	print_to_file(file : FILE) is
		-- Outputs object to file
		require
			file_not_void: file /= Void
			file_exists: file.exists
			file_is_open_write: file.is_open_read
			file_is_plain_text: file.is_plain_text
		do
			c_print_to_file(oid,file.file_pointer)
		end -- print_to_file

feature -- Action

	service(one_attribute : MT_ATTRIBUTE;sf : MT_SERVICE_FUNCTION) is
		-- Call service function sf on current object and 'one_attribute'
		do
			c_call_service_function(oid,one_attribute.aid,$sf)
		end -- service

	lock(kind_of_lock : INTEGER) is
		-- Lock current object in Matisse
		require
			kind_is_read_or_is_write : kind_of_lock = Mtread or else kind_of_lock = Mtwrite
		do
			c_lock_object(oid,kind_of_lock)
		end -- lock

	load is
		-- Load current object in client cache so that there is no more server access readings on this object
		do
		c_load_object(oid)
	end -- load

feature {NONE} -- Implementation

	retrieved_array : ARRAY[MT_OBJECT] is
		local
			keys_count,i : INTEGER
			one_object : MT_OBJECT
		do
			keys_count := c_keys_count
			!!Result.make(1,keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!!one_object.make(c_ith_key(i))
				Result.force(one_object,i)
 				i := i + 1
			end -- loop
			c_free_keys    
		end -- retrieved_array

	dispose is
		-- Remove object from local cache
		do
			c_free_object(oid)
		end -- dispose

end -- class MT_OBJECT
