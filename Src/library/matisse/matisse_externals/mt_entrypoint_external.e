indexing
	description: "External methods for class MT_ENTRYPOINT."

class 
	MT_ENTRYPOINT_EXTERNAL 

feature {NONE} -- Implementation MT_ENTRYPOINT

	c_get_objects_from_entry_point (aid, cid: INTEGER; ep_name: POINTER) is
			-- Use Mt_MGetObjectsFromEP.
		external 
			"C"
		end
	
	c_lock_objects_from_entry_point (lock: INTEGER; c_ep_name: POINTER; aid, cid: INTEGER) is
			-- Use LockObjectsFromEP.
		external 
			"C"
		end

	c_get_objects_from_entry_point_name (attr_name, class_name, ep_name: POINTER) is
		external 
			"C"
		end
		
	c_lock_objects_from_entry_point_name (lock: INTEGER; c_ep_name, attr_name, class_name: POINTER) is
		external 
			"C"
		end

end -- class MT_ENTRYPOINT_EXTERNAL
