class STORER_EXTERNAL

inherit
   
     EXT_INTERNAL
        export
            {NONE} all
        end

feature {NONE} -- External features

    c_i_th(p : POINTER ; i : INTEGER) : CHARACTER is
        -- i_th char from pointer p
        external 
            "C"
        end -- c_i_th

    c_index(i,j:INTEGER): CHARACTER is
        external
            "C"
        end -- c_index

    c_index_ref(i:POINTER;j:INTEGER): CHARACTER is
        external
            "C"
        end -- c_index_ref

    c_size_of_normal_flag(object : POINTER)  : INTEGER is
            -- Size of a special + flags   
        external 
            "C"
        end

  c_size_of_special(object : POINTER)  : INTEGER is
            -- Size of a special  
        external 
            "C"
        end

    c_size_of_normal(object : POINTER)  : INTEGER is
            -- Size of normal   
        external 
            "C"
        end

    c_is_special_object(object : POINTER) : BOOLEAN is
    external
        "C"
    end

    put_char_in_special_char(p : POINTER;c:CHARACTER) is
        external 
            "C"
        end

    put_int_in_special_char(p : POINTER;i:INTEGER) is
        external 
            "C"
        end

    put_ref_in_special_char(p : POINTER;r : POINTER) is
        external 
            "C"
        end

    pointer_on_special_item_char(i:INTEGER;object : POINTER) : POINTER is
        -- Pointer  on item
        external
            "C"
        end -- pointer_on_special_item

    c_allocate_buffer is
            -- Allocate memory for a buffer
        external
            "C"
        alias
            "allocate_gen_buffer"
        end;

    c_flush_buffer is
            -- Flush the buffer
        external
            "C"
        alias
            "flush_st_buffer"
        end;

    c_st_store(object : POINTER) is
        -- calls st_store
        external
            "C(EIF_POINTER)"
        alias
            "st_store_sol"
        end;

    c_write_basic_store_3_2 is
            -- Write kind of store in buffer
        external
            "C"
        end;
    
    c_write_general_store_3_3 is
            -- Write kind of store in buffer
        external
            "C"
        end;

    c_write_objects_count(nb_obj : INTEGER) is
        -- Write number of objects
        external
            "C(EIF_INTEGER)"
        end;

    c_st_write (object: POINTER) is
             -- Write one object in a file (basic store)
        external
            "C"
        alias
            "st_write"
        end;
    
    c_gst_write (object: POINTER) is
             -- Write one object in a file (general_store)
        external
            "C"
        alias
            "ext_gst_write"
        end;
    

    is_special_composites(object : POINTER) : BOOLEAN  is
            -- Is current object a special of pointers ?
        external 
            "C(EIF_REFERENCE):EIF_BOOLEAN"
        alias
            "c_is_special_composites"
        end ;

    is_special_refrences(object : POINTER) : BOOLEAN  is
            -- Is current object a special of pointers ?
        external 
            "C(EIF_REFERENCE):EIF_BOOLEAN"
        alias
            "c_is_special_references"
        end ;
    
    c_read_is_special : BOOLEAN is
        external
            "C"
        end

    set_file_descriptor_retrieve (file_handle : INTEGER) is
            -- set file descriptor to file_handle
        external
            "C(EIF_INTEGER)"
        alias
            "c_set_file_descriptor_retrieve"
        end ; 

     is_expanded  (object : POINTER) : BOOLEAN  is
          -- set file descriptor to file_handle
        external
            "C(EIF_OBJ):EIF_BOOLEAN"
        alias
            "c_is_expanded"
        end ; 

    c_read_object_address  : POINTER is
            -- Read old adress of object in file.  
        external
            "C"
        end;

    c_read_object_flags  : INTEGER is
            -- Adress of flags of object 
        external
            "C"
        end;


    write_buffer(date : POINTER;size : INTEGER) is
            -- Write some data of size 'size'
        external
            "C(EIF_POINTER,EIF_INTEGER)"
        alias
            "c_buffer_write"    
        end ;

    size_of_special(object : POINTER)  : INTEGER is
            -- Size of a special    
        external
            "C"
        alias
            "c_size_of_special"
        end;

    size_of_normal(object : POINTER)  : INTEGER is
            -- Size of a normal object    
        external
            "C(EIF_POINTER) : EIF_INTEGER"
        alias
            "c_size_of_normal"
        end;

    c_retrieved (file_handle: INTEGER): like Current is
            -- Object structured retrieved from file of pointer
            -- `file_ptr'
        external
            "C"
        alias
            "eretrieve"
        end;
        
    c_is_basic_store_3_2: BOOLEAN is
            -- Is kind of store equal to Basic_store_3_2 ?
        external
            "C"
        end;

    c_read_objects_count : INTEGER is
            -- Count of objects stored in file
        external
            "C"
        end;

    retrieved_special : SPECIAL[ANY] is
        external
            "C"
        alias
            "c_retrieved_special"
        end;

    retrieved_normal : like Current is
        external
            "C"
        alias
            "c_retrieved_normal"
        end;
    
    pointer_inside_field (i: INTEGER; object: POINTER): POINTER is
            -- Pointer value of `i'-th field of `object'
        external
            "C"

        end;

    pointer_on_field (i: INTEGER; object: POINTER): POINTER is
            -- Pointer value of `i'-th field of `object'
        external
            "C"
        end;

    change_inside_field(source,target : POINTER) is
        -- Replace field in target by source reference
    external
        "C"

    end -- set_reference_field
   
    pointer_on_special_item(i:INTEGER;object : POINTER) : POINTER is
        -- Pointer  on item
        external
            "C"
        end -- pointer_on_special_item

    pointer_inside_special_item(i:INTEGER;object : POINTER) : POINTER is
            -- Pointer inside item
        external
            "C"
        end -- pointer_inside_special_item

    c_object_address(p:POINTER) : POINTER is
        external
            "C"
        end -- c_object_address

    c_make_header is
    external
        "C"
    alias
        "ext_make_header"
    end -- c_make_header

     c_object_flags(p:POINTER) : INTEGER is
        external
            "C"
        end -- c_object_flags

    is_special_simple(object : POINTER) : BOOLEAN  is
            -- Is current object a special of pointers ?
        external 
            "C"
        alias
            "c_is_special_simples"
        end ;


end -- class STORER_EXTERNAL
