class MT_CLASS_EXTERNAL 

inherit

	MT_CREATE_OBJECT_EXTERNAL

feature {NONE} -- Implementation MT_CLASS

    c_get_class_from_name(name:POINTER) : INTEGER is
    external
        "C"
    end -- c_get_class_from_name

    c_get_class_from_object(oid : INTEGER) : INTEGER is
        -- Use MtGetClassFromObject
    external
        "C"
    end -- c_get_class_from_object

    c_get_all_attributes(cid : INTEGER) is
        -- Use Mt_MGetAllAttributes
    external
        "C"
    end -- c_get_all_attributes

    c_get_all_relationships(cid : INTEGER) is
        -- Use Mt_MGetAllRelationships
    external
        "C"
    end -- c_get_all_relationships

    c_get_all_i_relationships(cid : INTEGER) is
        -- Use Mt_MGetAllIRelationships
    external
        "C"
    end -- c_get_all_i_relationships

    c_get_all_subclasses(cid : INTEGER) is
        -- Use Mt_MGetAllISubclasses
    external
        "C"
    end -- c_get_all_subclasses

    c_get_all_superclasses(cid : INTEGER) is
        -- Use Mt_MGetAllSuperclasses
    external
        "C"
    end -- c_get_all_superclasses

    c_get_instances_number(cid : INTEGER) : INTEGER is
        -- Use Mt_GetInstancesNumber
    external
        "C"
    end -- c_get_instances_number

    c_create_num_objects(n,oid : INTEGER)  is
        -- Use MtCreateNumObjects
    external
        "C"
    end -- c_create_num_objects


end -- class MT_CLASS_EXTERNAL

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

