class MT_ENTRYPOINT_EXTERNAL 


feature {NONE} -- Implementation MT_ENTRYPOINT

    c_get_objects_from_ep(aid,cid : INTEGER;ep_name : POINTER) is
        -- Use Mt_MGetObjectsFromEP
    external
        "C"
    end -- c_get_objects_from_ep

    c_lock_objects_from_ep(lock : INTEGER;c_ep_name : POINTER;aid,cid : INTEGER) is
        -- Use LockObjectsFromEP
    external
	  "C"
    end -- c_lock_objects_from_ep

end -- class MT_ENTRYPOINT_EXTERNAL
