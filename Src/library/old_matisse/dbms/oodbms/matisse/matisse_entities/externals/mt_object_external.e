class MT_OBJECT_EXTERNAL 

inherit

	MT_CREATE_OBJECT_EXTERNAL

feature {NONE} -- Implementation MT_OBJECT
 
   c_predefined_msp(oid : INTEGER) : BOOLEAN is
        -- Use MtPredefinedMSP
    external
        "C"
    end -- c_predefined_msp
 
   c_check_instance(oid : INTEGER) is
        -- Use MtCheckInstance
    external
        "C"
    end -- c_check_instance

    c_remove_object(oid : INTEGER) is
        -- Use MtRemoveObject
    external
        "C"
    end -- c_remove_object

    c_remove_value(oid,aid : INTEGER) is
        -- Use Mt_RemoveValue
    external
        "C"
    end -- c_remove_value

    c_remove_all_successors(oid,rid : INTEGER) is
        -- Use Mt_RemoveAllSuccessors
    external
        "C"
    end -- c_remove_all_successors

    c_object_size(oid : INTEGER) : INTEGER is
        -- Use MtObjectSize
    external
        "C"
    end -- c_object_size

    c_print_to_file(oid : INTEGER;file_pointer : POINTER) is
        -- Use MtPrint
    external
        "C"
    end -- c_print_to_file

    c_type_p(oid,cid : INTEGER) : BOOLEAN is
        -- Use MtTypeP
    external
        "C"
    end -- c_type_p
    
    c_get_all_added_succs(oid,rid : INTEGER)  is
        -- Use MtGetAllAddedSuccs
    external
        "C"
    end -- c_get_all_added_succs
    
    c_get_all_rem_succs(oid,rid : INTEGER)  is
        -- Use MtGetAllRemSuccs
    external
        "C"
    end -- c_get_all_rem_succs

    c_get_successors(oid,rid : INTEGER)  is
        -- Use MtGetSuccessors
    external
        "C"
    end -- c_get_successors

    c_get_predecessors(oid,rid : INTEGER)  is
        -- Use MtGetPredecessors
    external
        "C"
    end -- c_predecessors

    c_free_object(oid : INTEGER)  is
        -- Use MtFreeObjects
    external
        "C"
    end -- c_free_object

    c_add_successor_first(oid,rid,soid : INTEGER) is 
        -- Use Mt_AddSuccessor MTFIRST
    external 
        "C"
    end -- c_add_successor_first

    c_add_successor_append(oid,rid,soid : INTEGER) is 
        -- Use Mt_AddSuccessor MTAPPEND
    external 
        "C"
    end -- c_add_successor_append

    c_add_successor_after(oid,rid,soid,ooid : INTEGER) is 
        -- Use Mt_AddSuccessor MTAFTER
    external 
        "C"
    end -- c_add_successor_after

    c_lock_object(oid,lock : INTEGER) is
        -- Use MtLockObjects
    external
        "C"
    end -- c_lock_object

    c_load_object(oid : INTEGER) is
        -- Use MtLoadObjects
    external
        "C"
    end -- c_load_object
	
	c_call_service_function(oid,aid : INTEGER;p:POINTER) is
		-- Use Mt_CallServiceFunction
	external
		"C"
	end -- c_call_service_function

end -- class MT_OBJECT_EXTERNAL
