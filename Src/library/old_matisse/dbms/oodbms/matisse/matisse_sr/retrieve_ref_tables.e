indexing
	description: "This data structure contains the set of reverse reference%
                   %lists for all the objects in the closure starting from the object%
                   %to which this list is attached."
	keywords:    "Matisse retrieve"
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class RETRIEVE_REF_TABLES

    inherit
       STORER_EXTERNAL
	   export 
		{NONE} all;
		{ANY} default_pointer
	   undefine
		is_equal, copy
	   end

        HASH_TABLE [RETRIEVE_REF_TABLE, INTEGER]
	    rename
		item as hash_table_item
            export 
		{NONE} all;
		{ANY} has, has_item, replace, remove, clear_all
            end

creation
        make

feature -- Conversion

feature -- Access
        item(an_oid:INTEGER): RETRIEVE_REF_TABLE is
                -- return the reverse reference table for the object stored
                -- as 'an_oid'
	    require
		Args_valid: an_oid /= 0
            do
		Result := hash_table_item(an_oid)
            end


feature -- Modification
	add_table(a_table:RETRIEVE_REF_TABLE) is
	    do
		put(a_table, a_table.target_oid)
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

