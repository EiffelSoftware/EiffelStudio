indexing
	description: "External methods for class MT_OBJECT."

class 
	MT_OBJECT_EXTERNAL 

inherit
	MT_CREATE_OBJECT_EXTERNAL

feature {NONE} -- Implementation MT_OBJECT
 
	c_is_predefined_object (oid: INTEGER): BOOLEAN is
		  -- Use MtPredefinedMSP.
		external 
			"C"
		end
	
	c_check_object(oid: INTEGER) is
		  -- Use MtCheckInstance.
		external 
			"C"
		end

	c_remove_object (oid: INTEGER) is
		  -- Use MtRemoveObject.
		external 
			"C"
		end

	c_remove_value (oid,aid: INTEGER) is
		  -- Use Mt_RemoveValue.
		external 
			"C"
		end
	 
	c_remove_value_by_name (oid: INTEGER; attr_name: POINTER) is
		  -- Use Mt_RemoveValue.
		external 
			"C"
		end
	 
	c_remove_successor (oid,rid, sid: INTEGER) is
		  -- Use Mt_RemoveSuccessors.
		external 
			"C"
		end
	 
	c_remove_all_successors (oid,rid: INTEGER) is
		  -- Use Mt_RemoveAllSuccessors.
		external 
			"C"
		end

	c_remove_successor_ignore_nosuchsucc (pred_oid, rid, succ_oid: INTEGER) is
		 -- Use Mt_RemoveSuccessors.
		external 
			"C"
		end
	 
	c_object_size (oid: INTEGER): INTEGER is
		  -- Use MtObjectSize.
		external 
			"C"
		end

	c_print_to_file (oid: INTEGER;file_pointer: POINTER) is
		  -- Use MtPrint.
		external 
			"C"
		end

	c_is_instance_of (oid,cid: INTEGER): BOOLEAN is
		  -- Use MtTypeP.
		external 
			"C"
		end
	 
	c_get_added_successors (oid,rid: INTEGER)  is
		  -- Use MtGetAllAddedSuccs.
		external 
			"C"
		end
	 
	c_get_removed_successors (oid,rid: INTEGER)  is
		  -- Use MtGetAllRemSuccs.
		external 
			"C"
		end

	c_get_successors (oid,rid: INTEGER) is
		  -- Use MtGetSuccessors.
		external 
			"C"
		end

	c_get_predecessors (oid,rid: INTEGER) is
		  -- Use MtGetPredecessors.
		external 
			"C"
		end

	c_free_object (oid: INTEGER) is
		  -- Use MtFreeObjects.
		external 
			"C"
		end

	c_add_successor_first (oid,rid,soid: INTEGER) is 
		  -- Use Mt_AddSuccessor MTFIRST.
		external 
			"C"
		end

	c_add_successor_append (oid,rid,soid: INTEGER) is 
		  -- Use Mt_AddSuccessor MTAPPEND.
		external 
			"C"
		end

	c_add_successor_after (oid,rid,soid,ooid: INTEGER) is 
		  -- Use Mt_AddSuccessor MTAFTER.
		external 
			"C"
		end

	c_set_successors (pred_oid, rid, size: INTEGER; succ_oids: POINTER) is
		-- Use Mt_SetSuccessors.
		external 
			"C"
		end

	c_lock_object (oid,lock: INTEGER) is
		  -- Use MtLockObjects.
		external 
			"C"
		end

	c_load_object (oid: INTEGER) is
		  -- Use MtLoadObjects.
		external 
			"C"
		end
	
	c_get_single_successor (pred_oid, rid: INTEGER): INTEGER is
			-- Use Mt_GetSuccessors.
			-- This is useful with 'Single-relationship'.
			-- (If there is no successor, return 0).
			-- (If there are more than one successor, return -1).
		external 
			"C"
		end
		
	c_write_lock_object (an_oid: INTEGER) is	 
		  -- Use MtLockObjects.
		external 
			"C"
		end

end -- class MT_OBJECT_EXTERNAL
