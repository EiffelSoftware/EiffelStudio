indexing
    description: "TEMPORARY DAYNAMIC TYPE TABLES; necessary until ISE%
    	%fix their runtime dynamic type information for generic types%
    	%(expected July/Aug 1997 in Eiffel 4.2)."
    keywords:    ""
    revision:    "%%A%%"
    source:      "%%P%%"
    requirements: ""

class DYN_TYPE_TABLES

    feature -- TEMPORARY: DYNAMIC TYPE WORKAROUND
	dt_dyn_types:HASH_TABLE[INTEGER, INTEGER] is
		-- list of codes for types mapped to Matisse types, keyed by (dt_class_code + dt_field_num) 
		-- for classes in the business model. This table gives the mapped type code (eg. MtString)
		-- for a given <class_name, field_number> pair of an object being written to the db
	    once
	        !!Result.make(0)
	    end

	Dt_non_mapped_type:INTEGER is -100

end

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------