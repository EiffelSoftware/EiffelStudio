indexing
	description: "Reference Element for XX_REF_TABLE classes."
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class REF_ELEMENT 

    inherit CT_ELEMENT
        rename
            put_first as put_field_name,
            put_second as put_object_ptr,
            first_item as field_name,
            second_item as object_ptr
        end

	creation
	    make
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

