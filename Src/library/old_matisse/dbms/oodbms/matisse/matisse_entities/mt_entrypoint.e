class MT_ENTRYPOINT

inherit
	
	MATISSE_CONST
		export {NONE} all; {ANY} mtread,mtwrite
		end

	MT_STREAMABLE

	MT_ENTRYPOINT_EXTERNAL

	MT_KEYS_EXTERNAL

Creation

	make

feature {NONE} -- Initialization

	make(arg_name : STRING) is
		-- Work with entrypoint 'arg_name' in database
		require 
			arg_name_not_void : arg_name /= Void
			arg_name_not_empty : not arg_name.empty
		do
			name := Clone(arg_name)
		end -- make

feature -- Retrieval
	
	retrieve_objects(one_class : MT_CLASS;one_attribute : MT_ATTRIBUTE) : ARRAY[MT_OBJECT] is
		-- Retrieve objects from 'one_class' with attributes accessed through entrypoint 
		local
			c_ep_name : ANY
			keys_count,i : INTEGER
			one_object : MT_OBJECT
		do
			c_ep_name := name.to_c
			c_get_objects_from_ep(one_attribute.aid,one_class.cid,$c_ep_name)
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
		end -- retrive_object

feature -- Element Change
	
	lock_objects(lock : INTEGER;one_attribute : MT_ATTRIBUTE;one_class : MT_CLASS) is
		-- Lock objects of entrypoint
		require
			lock_is_read_or_is_write : lock = MTREAD or lock = MTWRITE
		local
			c_ep_name : ANY
		do
			c_ep_name := name.to_c
			c_lock_objects_from_ep(lock,$c_ep_name,one_attribute.aid,one_class.cid)
		end -- lock_objects

feature {NONE} -- Implementation
	
	name : STRING  -- Name of entrypoint

	stream : MT_ENTRYPOINT_STREAM

end -- class MT_ENTRYPOINT
