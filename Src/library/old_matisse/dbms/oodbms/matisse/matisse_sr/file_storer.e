deferred class FILE_STORER 

inherit

	IO_MEDIUM_USE

	STORER

feature {NONE} -- Initialization

	make(arg_size : like size) is
		-- Build storer contents with arg_size or default
		require
			size_ok : arg_size >= Default_size
		deferred
		end -- make

feature -- Element Change

	store_one_object(object : ANY;is_exp : BOOLEAN)   is
		-- Write object and its dependences on the disk
		-- Unmarked means written on disk
		local 
 			a_special : SPECIAL[ANY]
			number_of_fields,i : INTEGER
		do
			-- if already unmarked then do not store
			if object/=Void and then (is_exp or else (is_marked(object)))  then
 				-- unmark the object
				unmark(object) 
				-- Special object
				if is_special(object) then
					if not(is_special_simple($object)) then
					a_special ?= object
					check a_special /= Void end
					from
						number_of_fields := a_special.count
						i := 0
					until
						i = number_of_fields
					loop
						store_one_object(a_special.item(i),dynamic_type(a_special.item(i))=Expanded_type)
						i := i+1
					end -- loop
				end -- if
			else
				from
					number_of_fields := field_count (object)
 					i := 1
				until
					i > number_of_fields
				loop
					store_one_object(field (i, object),field_type(i, object)=Expanded_type) 
					i := i+1
				end -- loop
			end -- if
			if not(is_exp) then putobject(object) end 
		else
                -- Object is already marked, do nothing
		end -- if    
	end -- store_one_object

	store (one_object : ANY;file: like media) is
		-- Produce on `file' an external representation of the
		-- entire object structure reachable from current object.
		-- Retrievable within current system only.
		require else
			file_not_void: file /= Void;
			file_exists: file.exists;
			file_is_open_write: file.is_open_write
			file_is_binary: not file.is_plain_text
 		local
			objects_count : INTEGER -- count objects while traversing
			was_collecting : BOOLEAN -- Was the garbage collector on ?
			es : EXT_STORABLE -- handle specific traversal actions
		do
			--1/ Stop garbage collector
			was_collecting := collecting;full_collect;collection_off
			-- 2/ Allocate buffer for writing datas
			set_media(file);
			-- 3/ Write the kind of store in file
			put_kind_of_store(Magic_number)
			-- 4/ Do the traversal : mark and count the objects to store
			es ?= one_object check es /= Void end 
		--	objects_count := es.new_deep_traversal(one_object,0);
			-- 5/Write in buffer, the count of stored objects and header if needed
			put_header(max_d_type);
			putint(objects_count);
			-- 6/ Write objects to be stored in buffer
			store_one_object(one_object,dynamic_type(one_object)=Expanded_type);
			-- 7/ Flush the allocated buffer ( there are often remaining data )
			flush
			-- 8/ Set the garbage collector            
			if was_collecting then collection_on;end
			-- 9/ Free buffer
			unset_media
		end -- store

feature {NONE} -- Implementation

	put_header(max_dyn_type : like max_d_type) is
		-- Append header of store
		do
		end -- put_header

	put_kind_of_store(a_magic : like Magic_number) is
		-- Append 'one_char', the magic character
		do
			media.putchar(a_magic)
		end -- put_kind_of_store

	put_char,putchar(c : CHARACTER) is
		-- Append character c
		deferred
		end -- putchar

	putint,put_int(i:INTEGER) is
		deferred    
		end -- putint, put_int

	putreference,put_reference( p : POINTER ) is
		-- Append reference p
		deferred
	end -- putreference, put_reference

	flush is
		-- Empty buffer into media
		deferred 
		end -- flush

feature {NONE} -- Magic numbers

	Magic_number : CHARACTER is deferred end

	max_d_type : INTEGER is deferred end 

feature -- Access
    
	Default_size : INTEGER is 1024 -- Size of area if argument was not correct
   
	size : INTEGER -- Size of storage area.

feature {NONE} -- Implementation
    
	index : INTEGER -- Current storage position in area.

	implementation : TO_SPECIAL[CHARACTER]  -- Storage area.
    
	area : SPECIAL[CHARACTER]  -- Area in storage area ( needed for $ operator)

invariant

	index_inside_bounds : index >=0 and index <= size

end -- class FILE_STORER
