indexing

	description:
		"Constants used by C++ encapsulation.";
	date: "$Date$";
	revision: "$Revision$"

class SHARED_CPP_CONSTANTS

feature {NONE} -- Constants

    standard, new , delete, static, data_member, static_data_member: INTEGER is unique
 
    data_member_keyword: STRING is "data_member"
 
    delete_keyword: STRING is "delete"
 
    new_keyword: STRING is "new"
 
    static_keyword: STRING is "static"

end -- class SHARED_CPP_CONSTANTS
