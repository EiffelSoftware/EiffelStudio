indexing
	description: "Constants used by C++ encapsulation.";
	date: "$Date$";
	revision: "$Revision$"

class SHARED_CPP_CONSTANTS

feature -- Validity

	valid_type (i: INTEGER): BOOLEAN is
			-- Does `i' represent a kind of C++ external.
		do
			Result := i = standard or i = creator or i = delete or i = static 
						or i = data_member or i = static_data_member
		end

feature {NONE} -- Constants

    standard: INTEGER is 1
	new, creator: INTEGER is 2
	delete: INTEGER is 3
	static: INTEGER is 4
	data_member: INTEGER is 5
	static_data_member: INTEGER is 6
 
    data_member_keyword: STRING is "data_member"
 
    delete_keyword: STRING is "delete"
 
    new_keyword: STRING is "new"
 
    static_keyword: STRING is "static"

end -- class SHARED_CPP_CONSTANTS
