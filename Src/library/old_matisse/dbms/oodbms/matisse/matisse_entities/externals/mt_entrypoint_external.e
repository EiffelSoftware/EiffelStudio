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

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

