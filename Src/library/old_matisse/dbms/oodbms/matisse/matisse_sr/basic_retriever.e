class BASIC_RETRIEVER 

inherit

	FILE_RETRIEVER

feature

	retrieve (file_name: like anchor): EXT_STORABLE is
            -- Retrieve object structure, from external
            -- representation previously stored in a file
            -- called `file_name'.
            -- To access resulting object under correct type,
            -- use assignment attempt.
            -- Will raise an exception (code `Retrieve_exception')
            -- if file content is not a `STORABLE' structure.
            -- Will return Void if the file does not exist or
            -- is not readable.
        local
            file: RAW_FILE
            kind_of_store : CHARACTER
            objects_count : INTEGER
            old_adress : POINTER
            old_flags,i : INTEGER
            retrieved_object: ANY
            is_collecting : BOOLEAN
        do
            full_collect
            !!Result
            !!file.make (file_name)
            if file.exists and then file.is_readable then
                file.open_read
                  -- 1/ Stop garbage collector
                is_collecting := collecting;collection_off
                  -- 2/ Init media
                init_media_for_retrieve(file.descriptor)
                  -- 3/ Check kind of store
                if kind_of_file_is_correct then
                      -- 4/ Read count of objects in file
                    objects_count := read_objects_count; check object_count_positive : objects_count >= 0;end 
                      -- 5/ Iterate through each object
                    io.putint(objects_count) io.new_line 
                    from
                          -- 6/Clear table and fill resize it
                        tc.clear_all;tc.make(objects_count)
                        i := 0
                    until 
                        i = objects_count
                    loop
                          -- 7/ Read old_adress
                        old_adress := read_object_address
                          -- 8/ Read flags
                        old_flags := read_object_flags
                          -- 9/ Create object
                        if read_is_special then
                            retrieved_object := retrieved_special
                        else 
                            retrieved_object := retrieved_normal    
                        end -- if
                        Result ?= retrieved_object                         
                          -- 10/ Update references on that object
                        if not(is_expanded($retrieved_object)) then
                            update_references_on_object_retrieved(old_adress,retrieved_object)
                        end;
                          -- 11/ Update fields inside the object
                        update_references_inside_retrieved_object(old_adress,retrieved_object,is_expanded($retrieved_object))
                        -- 12/ Read next object
                        i := i + 1
                    end -- loop
                else
                  -- Kind of file is not Ok
                end
                  -- 13/ Restart garbage collector if necessary
                if is_collecting then collection_on;end;
                file.close
            end
        end -- retrieve_by_name
feature -- Temporary stuff

    init_media_for_retrieve(file_handle: INTEGER) is
        -- Perform various init actions
    do
        set_file_descriptor_retrieve(file_handle)
    end -- init_media_for_retrieve

    update_references_on_object_retrieved(old_adress:POINTER;object : ANY ) is
        --
    local
            rtu : POINTER
            new_obj_list,temp_list: ARRAYED_LIST[POINTER]
            j : INTEGER
    do
        -- Is object referenced in table ?
        new_obj_list := tc.item(old_adress)
        if new_obj_list = Void then 
            -- Store object's reference in table
            !!temp_list.make(0)
            tc.put(temp_list,old_adress)
            temp_list.start
            temp_list.force(c_object_address($object))
        else
            -- Update references on that object ( list items after first )
            new_obj_list.put_i_th(c_object_address($object),1)
            from
                j := 2
            until        
                j > new_obj_list.count
            loop
                rtu := new_obj_list.i_th(j)
                change_inside_field($object,rtu)
                         -- put pointer on retrieved object inside field pointed by rtu.
                j := j + 1
            end -- loop
        end -- if 
    end -- updated references_on_object_retrieved

    update_references_inside_retrieved_object(old_adress:POINTER;object : ANY;is_exp : BOOLEAN)  is
        --
    local
            r_objects_count,i,j,type_value : INTEGER
            old_flags,old_adress_hash_code : INTEGER
            special_size,nb_field : INTEGER
            one_field : ANY
            special_object_retrieved : SPECIAL[POINTER]
            new_obj_ref : POINTER
            new_obj_list,temp_list: ARRAYED_LIST[POINTER]
            exp_retrieved : expanded ANY;
            retrieved_object : ANY
    do
        --if not(is_exp) then
        retrieved_object := object
        if is_special(retrieved_object) then
            if (is_special_simple($retrieved_object)) then
                -- Do nothing
            else
                from
                    special_object_retrieved ?= retrieved_object
                    nb_field := special_object_retrieved.count
                    j := 0
                until
                    j = nb_field
                loop
                    if pointer_inside_special_item(j,$special_object_retrieved)/=default_pointer then
                        if tc.item(pointer_inside_special_item(j,$special_object_retrieved))/=Void then
                            if tc.item(pointer_inside_special_item(j,$special_object_retrieved)).first/=default_pointer then
                                change_inside_field
                                                (
                                                tc.item(pointer_inside_special_item(j,$special_object_retrieved)).first,
                                                pointer_on_special_item(j,$special_object_retrieved)
                                                )
                            else        
                                new_obj_list := tc.item(pointer_inside_special_item(j,$special_object_retrieved));
                                new_obj_list.finish
                                new_obj_list.put_right(pointer_on_special_item(j,$special_object_retrieved))
                            end -- if
                        else
                            -- We want an object never seen before --> create its list
                            !!temp_list.make(2)
                            tc.put(temp_list,pointer_inside_special_item(j,$special_object_retrieved))
                            new_obj_list := tc.item(pointer_inside_special_item(j,$special_object_retrieved));
                            new_obj_list.finish
                            new_obj_list.force(default_pointer)
                            new_obj_list.finish
                            new_obj_list.force(pointer_on_special_item(j,$special_object_retrieved))
                        end -- if
                    end -- if
                    j:=j+1
                end -- loop
            end --if 
        else
            from
                nb_field := field_count (retrieved_object)
                debug;if is_exp then io.putint(nb_field);io.new_line;end;end
                j := 1
            until
                j > nb_field
            loop
                if ((field_type(j,retrieved_object)=Reference_type))  and then pointer_inside_field(j-1,$retrieved_object)/=default_pointer then
                    if tc.item(pointer_inside_field(j-1,$retrieved_object))/=Void then
                        if tc.item(pointer_inside_field(j-1,$retrieved_object)).first/=default_pointer then
                            change_inside_field
                                (tc.item(pointer_inside_field(j-1,$retrieved_object)).first,
                                    pointer_on_field(j-1,$retrieved_object))
                        else    
                            new_obj_list := tc.item(pointer_inside_field(j-1,$retrieved_object));
                            new_obj_list.finish
                            new_obj_list.put_right(pointer_on_field(j-1,$retrieved_object))
                        end -- if
                    else
                        -- We want an object never seen before --> create its list
                        !!temp_list.make(2)
                        tc.put(temp_list,pointer_inside_field(j-1,$retrieved_object))
                        new_obj_list := tc.item(pointer_inside_field(j-1,$retrieved_object));
                        new_obj_list.finish
                        new_obj_list.force(default_pointer)
                        new_obj_list.finish
                        new_obj_list.force(pointer_on_field(j-1,$retrieved_object))
                    end -- if
                elseif (field_type(j,retrieved_object)=Expanded_type) and then pointer_inside_field(j-1,$retrieved_object)/=default_pointer then
                 update_references_inside_retrieved_object(pointer_inside_field(j-1,$retrieved_object),field(j,retrieved_object),True)    
                end -- if  
                j :=j + 1
            end -- loop
        end -- if    
        --end -- if       
    end -- update_references_inside_object_retrieved


feature {NONE} -- Access

    read_objects_count : INTEGER is
        -- Read number of objects in storage
    do
        Result := c_read_objects_count
    end -- read_objects_count
 
   read_object_address : POINTER is
        -- Read address of object retrieved
    do
        Result := c_read_object_address
    end -- read_objects_address

    read_object_flags : INTEGER is
        -- Read flags of object retrieved
    do
        Result := c_read_object_flags
    end -- read_objects_count

    kind_of_file_is_correct : BOOLEAN is
        -- Is this format ok ?
        -- Only 3_2 is currently supported
        do
            Result := c_is_basic_store_3_2
        end -- kind_of_file_is_correct

feature {NONE} -- Element Change

    make_header is 
        -- Generate header for stored hierarchy retrieval by other systems
    do
        c_make_header
    end -- make_header

    basic_write_on_disk(object : ANY) is
            -- write a single object on disk
    do    
        -- write adress of object
        -- write flags of object
        -- if special then write size of object
        -- write body of the object
        c_st_write ($object)
    end -- write_on_disk    
    
    general_write_on_disk(object : ANY) is
            -- write a single object on disk
    do    
        -- write adress of object
        -- write flags of object
        -- if special then write size of object
        -- write body of the object
        c_gst_write ($object)
    end -- write_on_disk    
 
  feature {NONE} -- Implementation

    tc : HASH_TABLE[ARRAYED_LIST[POINTER],POINTER] 
    is
        -- Correspondance Table
        -- Each line has the following infos :
        -- first : adress of object at hash code line second...N : items referencing this object
    once
        !!Result.make(0)
    end;

    is_corrupted : BOOLEAN 
        -- is file ok ?

    read_is_special : BOOLEAN is
            -- Is object in file a special object ?
        local
            error : BOOLEAN        
        do
            if error then
                is_corrupted := true
            else
                Result := c_read_is_special
            end
        ensure
            no_read_error : not is_corrupted
        rescue
            error := true
            io.error.putstring("Error in read_is_special routine%N")
            retry
        end 
end -- class BASIC_RETRIEVER
