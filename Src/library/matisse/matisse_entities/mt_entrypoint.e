indexing
	description: "MATISSE-Eiffel Binding";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_ENTRYPOINT

inherit
	MT_CONSTANTS
		export 
			{NONE} all
			{ANY} Mt_Read, Mt_Write
		end

	MT_ENTRYPOINT_EXTERNAL

	MT_KEYS_EXTERNAL

	MT_CLASS_EXTERNAL

Creation
	make, make_from_name

feature {NONE} -- Initialization

	make (one_attribute: MT_ATTRIBUTE; one_class: MT_CLASS) is
			-- Work with entrypoint on attribut 'one_attribute' in database.
			-- `one_class' is an optional constraint, and can be void.
		require 
			attr_not_void: one_attribute /= Void
		do
			ep_attribute := one_attribute
			ep_class :=  one_class
		end

	make_from_name (attr_name: STRING; a_class_name: STRING) is
		require
			attr_name_not_void: attr_name /= Void
			attr_name_not_empty: not attr_name.is_empty
		do
			ep_attribute_name := clone (attr_name)
			if a_class_name /= Void then
				ep_class_name := clone (a_class_name)
			end
		end
		
feature -- Retrieval
	
	retrieve_objects (ep_string: STRING): ARRAY [MT_STORABLE] is
			-- Retrieve objects accessed through entrypoint value 'ep_string'.
		local
			c_ep_name, c_attr_name, c_class_name: ANY
			keys_count, i, cid: INTEGER
			one_object: MT_STORABLE
			matched_keys: ARRAY [INTEGER]
		do
			c_ep_name := ep_string.to_c
			if ep_attribute /= Void then
				if ep_class = Void then
					c_get_objects_from_entry_point (ep_attribute.oid, 0, $c_ep_name)
				else
					c_get_objects_from_entry_point (ep_attribute.oid, ep_class.oid, $c_ep_name)
				end
			else
				ep_attribute := current_db.get_attribute_from_name (ep_attribute_name, ep_class_name)
				if ep_class_name = Void then
					c_get_objects_from_entry_point (ep_attribute.oid, 0, $c_ep_name)
				else
					c_class_name := ep_class_name.to_c
					cid := c_get_class_from_name ($c_class_name)
					!! ep_class.make_from_oid (cid)
					c_get_objects_from_entry_point (ep_attribute.oid, cid, $c_ep_name)
				end
			end
			keys_count := c_keys_count
			!! matched_keys.make (1, keys_count)
			from
 				i := matched_keys.lower
			until 
				i > matched_keys.upper
			loop
				matched_keys.put (c_ith_key (i), i)
				i := i + 1
			end 
			
			!! Result.make (1, keys_count)
			from
 				i := matched_keys.lower
			until 
				i > matched_keys.upper
			loop
				one_object := current_db.new_eif_object_from_oid (matched_keys.item(i))
				Result.put (one_object, i)
				i := i + 1
			end -- loop
			c_free_keys
		end

	retrieve_n_firsts (ep_string: STRING; n: INTEGER): ARRAY [MT_STORABLE] is
			-- Return `n' firsts objects accessed through the entrypoint.
		local
			c_ep_name, c_attr_name, c_class_name: ANY
			keys_count, i, cid: INTEGER
			one_object: MT_STORABLE
			matched_keys: ARRAY [INTEGER]
		do
			c_ep_name := ep_string.to_c
			if ep_attribute /= Void then
				if ep_class = Void then
					c_get_objects_from_entry_point (ep_attribute.oid, 0, $c_ep_name)
				else
					c_get_objects_from_entry_point (ep_attribute.oid, ep_class.oid, $c_ep_name)
				end
			else
				ep_attribute := current_db.get_attribute_from_name (ep_attribute_name, ep_class_name)
				if ep_class_name = Void then
					c_get_objects_from_entry_point (ep_attribute.oid, 0, $c_ep_name)
				else
					c_class_name := ep_class_name.to_c
					cid := c_get_class_from_name ($c_class_name)
					!! ep_class.make_from_oid (cid)
					c_get_objects_from_entry_point (ep_attribute.oid, cid, $c_ep_name)
				end
			end
			keys_count := c_keys_count
			!! matched_keys.make (1, keys_count)
			from
 				i := matched_keys.lower
			until 
				i > matched_keys.upper or i > n + matched_keys.lower - 1
			loop
				matched_keys.put (c_ith_key (i), i)
				i := i + 1
			end 
			
			!! Result.make (1, keys_count)
			from
 				i := matched_keys.lower
			until 
				i > matched_keys.upper or i > n + matched_keys.lower - 1
			loop
				one_object := current_db.new_eif_object_from_oid (matched_keys.item(i))
				Result.put (one_object, i)
				i := i + 1
			end
			c_free_keys
		end

		
	retrieve_first (ep_string: STRING): MT_STORABLE is
			-- Return just a first object accessed through the entry point.
		local
			a_stream: MT_ENTRYPOINT_STREAM
		do
			a_stream := open_stream (ep_string)
			a_stream.start
			if not a_stream.exhausted then
				Result := a_stream.item
			end
			a_stream.close
		end

	open_stream (ep_string: STRING): MT_ENTRYPOINT_STREAM is
		do
			if ep_attribute = Void then
				ep_attribute := current_db.get_attribute_from_name (ep_attribute_name, ep_class_name)
			end
			if ep_class = Void then
				ep_class := current_db.get_mt_class_from_name (ep_class_name)
			end
			!! Result.make (ep_string, ep_attribute, ep_class)
		end

feature -- Element Change
	
	lock_objects (lock: INTEGER; ep_string: STRING) is
			-- Lock objects of entrypoint
		require
			lock_is_read_or_is_write: lock = Mt_Read or lock = Mt_Write
		local
			c_ep_name, c_attr_name, c_class_name: ANY
		do
			c_ep_name := ep_string.to_c
			if ep_attribute_name = Void then
				if ep_class = Void then
					c_lock_objects_from_entry_point (lock, $c_ep_name, ep_attribute.oid, 0)
				else
					c_lock_objects_from_entry_point (lock, $c_ep_name, ep_attribute.oid, ep_class.oid)
				end
			else
				c_attr_name := ep_attribute_name.to_c
				if ep_class_name = Void then
					c_lock_objects_from_entry_point_name (lock, $c_ep_name, $c_attr_name, $Void)
				else
					c_class_name := ep_class_name.to_c
					c_lock_objects_from_entry_point_name (lock, $c_ep_name, $c_attr_name, $c_class_name)
				end
			end
		end

feature {NONE} -- Implementation
	
	name: STRING  
		-- Name of entrypoint.

	ep_attribute: MT_ATTRIBUTE
		-- Associated attribute.

	ep_class: MT_CLASS
		-- Associated class

	ep_attribute_name: STRING
		-- Name of `ep_attribute'
	
	ep_class_name: STRING
		-- Name of `ep_class'

end -- class MT_ENTRYPOINT
