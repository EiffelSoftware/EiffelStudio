indexing
	description: "This data structure contains the set of reverse reference%
                    %lists for all the objects in the closure starting from the object%
                    %to which this list is attached."
	keywords:    "matisse store"
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class STORE_REF_TABLES

inherit
       STORER_EXTERNAL
	   export 
		{NONE} all;
		{ANY} default_pointer
	   undefine
		is_equal, copy
	   end

        HASH_TABLE [STORE_REF_TABLE, POINTER]
	    rename
		item as hash_table_item
            export 
		{NONE} all;
		{ANY} has, has_item, replace, remove
            end

creation
        make

feature -- Conversion
       oid(an_object_ptr:POINTER): INTEGER is
		-- return the oid for 'object'
	    require
		Args_valid: an_object_ptr /= Void
            do
		Result := item(an_object_ptr).target_oid
            end

feature -- Access
        item_i_th_field(i:INTEGER; an_object_ptr:POINTER): STORE_REF_TABLE is
                -- return the reference table for the object pointed to
                -- by the 'i'-th field of 'object'
	    require
		Args_valid: i > 0 and an_object_ptr /= default_pointer
            do
		if c_is_special(an_object_ptr) then 
		    Result := item(pointer_inside_special_item(i-1,an_object_ptr))
		else
		    Result := item(pointer_inside_field(i-1,an_object_ptr))
		end
            end

        item(an_object_ptr:POINTER): STORE_REF_TABLE is
                -- return the reverse reference table for the object pointed
                -- to by 'an_object_ptr'
	    require
		Args_valid: an_object_ptr /= default_pointer
            do
		Result := hash_table_item(an_object_ptr)
            end

feature -- Modification
	    add_table(a_table:STORE_REF_TABLE) is
		do
		    put(a_table, a_table.target_object_ptr)
		end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+

